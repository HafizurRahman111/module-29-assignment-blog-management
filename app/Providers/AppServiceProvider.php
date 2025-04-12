<?php

namespace App\Providers;

use App\Models\Notification;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\ServiceProvider;
use Inertia\Inertia;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Inertia::share([
            'auth' => [
                'user' => Auth::user() ? [
                    'username' => Auth::user()->username,
                    'profile_pic' => Auth::user()->profile_pic ?? 'https://via.placeholder.com/40',
                    'role' => Auth::user()->role ?? 'User',
                ] : null,
            ],
            'notifications' => function () {
                $user = Auth::user();

                if ($user) {
                    $unreadNotifications = Notification::with('user')
                        ->where('user_id', $user->id)
                        ->whereNull('read_at')
                        ->orderBy('created_at', 'desc')
                        ->take(3)
                        ->get();

                    return [
                        'unreadNotifications' => $unreadNotifications,
                    ];
                }

                return [
                    'unreadNotifications' => [],
                ];
            },
        ]);
    }
}
