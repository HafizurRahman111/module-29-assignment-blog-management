<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $userId = Auth::id();

        $posts = Post::with(['user', 'tags'])
            ->withCount(['comments', 'likes', 'bookmarks'])
            ->where(function ($query) use ($userId) {
                $query->where('visibility', 'public')
                      ->orWhere(function ($q) use ($userId) {
                          $q->where('visibility', 'private')
                            ->where('user_id', $userId);
                      });
            })
            ->latest()
            ->get();
    
        return Inertia::render('app/management/posts/PostList', [
            'posts' => $posts,
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
    public function show(Post $post)
    {
        // Eager load the relationships
        $post->load([
            'user:id,username',
            'tags:id,name',
            'comments' => function ($query) {
                $query->with(['user:id,username', 'replies.user:id,username']);
            }
        ]);

        return Inertia::render('app/management/posts/ViewPost', [
            'post' => $post,
        ]);
    }



    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Post $post)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Post $post)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Post $post)
    {
        //
    }
}
