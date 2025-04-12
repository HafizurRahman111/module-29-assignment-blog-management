<?php

namespace App\Http\Middleware;

use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that's loaded on the first page visit.
     *
     * @see https://inertiajs.com/server-side-setup#root-template
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determines the current asset version.
     *
     * @see https://inertiajs.com/asset-versioning
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @see https://inertiajs.com/shared-data
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        return array_merge(parent::share($request), [
            'auth' => [
                'user' => $request->user() ? [
                    'id' => $request->user()->id,
                    'username' => $request->user()->username,
                    'email' => $request->user()->email,
                    'profile_pic' => $request->user()->profile_pic, // Ensure this field is available
                ] : null,
            ],
            'notifications' => function () use ($request) {
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

                return []; // Return an empty array if no user is authenticated or no unread notifications exist
            },
            'flash' => [
                'message' => fn() => $request->session()->pull('message'),
                'status' => fn() => $request->session()->pull('status'),
                'error' => fn() => $request->session()->pull('error'),
            ],
        ]);

    }
}
