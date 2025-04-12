<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index()
    {
        //  dd(Auth::user());
        return Inertia::render('app/dashboard/Index');
    }

    public function analytics()
    {
        return Inertia::render('public/About');
    }

    // Profile page
    public function profile()
    {
        // dd(auth()->user());
        $user = Auth::User();

        return Inertia::render('app/dashboard/Profile', [
            'user' => $user
        ]);
    }

    // Edit profile page
    public function editProfile()
    {
        // Logic to show the edit profile form
        return view('dashboard.edit-profile');
    }

    // Update profile
    public function updateProfile()
    {
        // Logic to update the user profile
        // Validate and save user data
        return redirect()->to('/dashboard/profile');
    }

    // Settings page
    public function settings()
    {
        // Logic to fetch user settings
        return view('dashboard.settings');
    }

    // Update settings
    public function updateSettings()
    {
        // Logic to update user settings
        return redirect()->to('/dashboard/settings');
    }


}
