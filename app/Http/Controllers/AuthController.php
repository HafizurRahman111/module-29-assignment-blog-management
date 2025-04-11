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
        return Inertia::render('Auth/Register');
    }

    public function register(Request $request)
    {
        // Validate the input
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|min:4|max:250',
            'email' => 'required|string|email|max:255|unique:users|regex:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/',
            'mobile' => 'required|string|min:6|max:20|unique:users|regex:/^\+?[0-9\s\-\(\)]{10,20}$/',
            'password' => 'required|string|confirmed|min:8|max:50',
        ]);

        // Handle validation failure
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        // Create the new user
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'mobile' => $request->mobile,
            'password' => Hash::make($request->password),
        ]);

        // Generate a hashed version of the email
        $hashedEmail = Hash::make($user->email);

        // Send email verification OTP
        $this->sendEmailVerificationOtp($user);

        // Set flash message and status for the frontend
        session()->flash('status', true);
        session()->flash('message', 'Registration successful. Please check your email for verification code.');

        $data = [
            'message' => 'Registration successful. Please check your email for verification code.',
            'status' => true,
            'error' => ''
        ];

        return redirect()->route('verification.notice', [
            'email' => $user->email,
        ])->with($data);
    }


    public function showLogin()
    {
        return Inertia::render('Auth/Login');
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
            'password' => 'required|string',
        ], [
            'email.exists' => 'The provided email does not exist in our records.',
            'password.required' => 'The password field is required.'
        ]);

        if ($validator->fails()) {
            return redirect()
                ->route('login')
                ->withErrors($validator)
                ->withInput($request->except('password'));
        }

        $credentials = $request->only('email', 'password');

        if (!Auth::attempt($credentials, $request->remember)) {
            return redirect()
                ->route('login')
                ->with('error', 'Invalid credentials. Please try again.')
                ->withInput($request->only('email'));
        }

        $user = Auth::user();

        if (!$user->hasVerifiedEmail()) {
            Auth::logout();

            return redirect()
                ->route('login')
                ->with('error', 'Please verify your email address before logging in.')
                ->withInput($request->only('email'));
        }

        try {
            $token = JWTToken::createToken($user->email, $user->id);

            $request->session()->put([
                'jwt_token' => $token,
                'user_id' => $user->id,
            ]);

            $request->session()->regenerate();

            return redirect()
                ->route('dashboard')
                ->with('success', 'Welcome back, ' . $user->name . '!');

        } catch (\Exception $e) {
            Auth::logout();

            return redirect()
                ->route('login')
                ->with('error', 'An error occurred during login. Please try again.')
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