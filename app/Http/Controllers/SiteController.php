<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Post;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SiteController extends Controller
{
    public function index()
    {
        return Inertia::render('public/Home');
    }

    public function about()
    {
        return Inertia::render('public/About');
    }

    public function blog()
    {
        $posts = Post::with(['user', 'tags'])
            ->where('visibility', 'public')
            ->withCount(['comments', 'likes', 'bookmarks'])
            ->latest()
            ->get();

        // dd($posts);
        return Inertia::render('public/Blog', [
            'posts' => $posts,
        ]);
    }

}
