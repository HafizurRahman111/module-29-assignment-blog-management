<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class NotificationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userId = Auth::user()->id;

        $notifications = Notification::with('user')
            ->where('user_id', operator: $userId)
            ->orderBy('created_at', 'desc')->get();

        return Inertia::render('app/management/notifications/NotificationList', [
            'notifications' => $notifications,
        ]);
    }

    public function getLatestNotifications(Request $request)
    {
        $user = $request->user();

        $unreadNotifications = Notification::with('user')->where('user_id', operator: 1)
            ->whereNull('read_at')
            ->orderBy('created_at', 'desc')
            ->get();

        // dd($unreadNotifications);

        return response()->json($unreadNotifications);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Notification $notification)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Notification $notification)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Notification $notification)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Notification $notification)
    {
        //
    }
}
