<?php

namespace App\Http\Controllers;

use App\Helper\JWTToken;
use App\Mail\EmailVerified;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use App\Mail\EmailVerificationOtp;

class AuthController extends Controller
{
    public function showRegister()
    {
        return Inertia::render('public/auth/Register');
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required|string|min:4|max:250|unique:users',
            'email' => 'required|string|email|max:255|unique:users|regex:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/',
            'profile_pic' => 'required|image|mimes:jpeg,png,jpg|max:2048',
            'password' => 'required|string|confirmed|min:8|max:50',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $filePath = null;
        if ($request->hasFile('profile_pic')) {
            $image = $request->file('profile_pic');

            $fileName = time() . '.' . $image->getClientOriginalExtension();
            $filePath = 'uploads/' . $fileName;
            $image->move(public_path('uploads'), $fileName);
        }

        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'profile_pic' => $filePath,
            'password' => Hash::make($request->password),
        ]);

        $data = [
            'message' => 'Registration successful. Please check your email for verification code.',
            'status' => true,
            'error' => ''
        ];

        return redirect()->route('login')->with($data);
    }


    public function showLogin()
    {
        return Inertia::render('public/auth/Login');
    }

    public function login(Request $request)
    {
        // Validate incoming data
        $validated = $request->validate([
            'email' => 'required|email|exists:users,email',
            'password' => 'required|string',
        ], [
            'email.exists' => 'The provided email does not exist in our records.',
            'password.required' => 'The password field is required.',
        ]);

        // Attempt to log the user in with the provided credentials
        if (!Auth::attempt($validated, $request->filled('remember'))) {
            return redirect()->route('login')
                ->withErrors(['email' => 'Invalid credentials. Please try again.'])
                ->withInput($request->only('email'));  // Only persist the email on error
        }

        $user = Auth::user();

        try {
            // Generate JWT token for the authenticated user
            $token = JWTToken::createToken($user->email, $user->id);

            // Store the token and user ID in the session
            session([
                'jwt_token' => $token,
                'user_id' => $user->id,
            ]);

            // Regenerate the session ID for security
            $request->session()->regenerate();

            // Redirect the user to the dashboard with a success message
            return redirect()->route('dashboard.index')
                ->with('success', 'Welcome back, ' . $user->name . '!');

        } catch (\Exception $e) {
            // Log the user out in case of any exception
            Auth::logout();

            // Handle the exception and show a generic error message
            return redirect()->route('login')
                ->withErrors(['email' => 'An error occurred during login. Please try again.'])
                ->withInput($request->only('email'));
        }
    }


    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login')->with('success', 'You have been logged out.');
    }


    public function showVerifyEmail(Request $request)
    {
        return Inertia::render('Auth/VerifyEmail', [
            'email' => $request->query('email'), // Get email from query parameters
            'status' => session('status'),
            'error' => session('error')
        ]);
    }

    public function verifyEmail(Request $request, $email)
    {
        // Validate the input
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
            'otp' => 'required|numeric|digits:6',
        ]);

        if ($validator->fails()) {
            return back()->withErrors($validator);
        }

        // Retrieve the user
        $user = User::where('email', $request->email)->firstOrFail();

        // Ensure the user is not already verified
        if ($user->email_verified_at !== null) {
            return redirect()->route('login')->with('info', 'Your email is already verified.');
        }

        // Check OTP attempts
        if ($user->otp_attempts >= 5) {
            return back()->with('error', 'Too many attempts. Please request a new OTP.');
        }

        // Check if OTP exists and not expired
        if (!$user->otp || !$user->otp_expires_at || Carbon::now()->gt($user->otp_expires_at)) {
            return back()->with('error', 'OTP has expired. Please request a new one.');
        }

        // Verify OTP
        if (!Hash::check($request->otp, $user->otp)) {
            $user->increment('otp_attempts');
            return back()->with('error', 'Invalid OTP. Attempts remaining: ' . (5 - $user->otp_attempts));
        }

        // Mark email as verified
        $user->update([
            'email_verified_at' => Carbon::now(),
            'otp' => 0,
            'otp_expires_at' => null,
            'otp_attempts' => 0,
        ]);

        // Log in the user
        Auth::login($user);

        // Send second confirmation email after verification
        Mail::to($user->email)->send(new EmailVerified($user));

        // Redirect to the login page with success message
        return redirect()->route('home')->with('success', 'Email verified successfully! A confirmation email has been sent.');
    }

    public function resendOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
        ]);

        if ($validator->fails()) {
            return back()->with('error', 'Invalid email');
        }

        $user = User::where('email', $request->email)->firstOrFail();

        // Throttle resend requests (1 per minute)
        if ($user->otp_sent_at && Carbon::now()->diffInMinutes($user->otp_sent_at) < 1) {
            return back()->with('error', 'Please wait before requesting a new OTP.');
        }

        $this->sendEmailVerificationOtp($user);

        return back()->with('status', 'A new OTP has been sent to your email.');
    }

    protected function sendEmailVerificationOtp(User $user)
    {
        $otp = random_int(100000, 999999);

        $user->update([
            'otp' => Hash::make($otp),
            'otp_expires_at' => Carbon::now()->addMinutes(30),
            'otp_attempts' => 0,
            'otp_sent_at' => Carbon::now(),
        ]);

        try {
            Mail::to($user->email)->send(new EmailVerificationOtp($otp, $user));

            \Log::info("OTP sent to {$user->email}");
        } catch (\Exception $e) {
            \Log::error("Failed to send OTP email: " . $e->getMessage());
            throw new \RuntimeException('Failed to send verification email. Please try again later.');
        }
    }

    public function me()
    {
        return response()->json(Auth::user());
    }
}