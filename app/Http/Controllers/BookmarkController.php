<?php

namespace App\Http\Controllers;

use App\Models\Bookmark;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class BookmarkController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $userId = Auth::user()->id;

        $bookmarks = Bookmark::with('post.user', 'post.tags')
            ->with([
                'post' => function ($query) {
                    $query->withCount(['comments', 'likes', 'bookmarks']);
                }
            ])
            ->where('user_id', $userId)
            ->get()
            ->pluck('post')
            ->filter()
            ->values();

        return Inertia::render('app/management/bookmarks/BookmarkList', [
            'posts' => $bookmarks,
        ]);
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
    public function show(Bookmark $bookmark)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Bookmark $bookmark)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Bookmark $bookmark)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Bookmark $bookmark)
    {
        //
    }
}
