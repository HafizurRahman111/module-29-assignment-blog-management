<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
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
                    ->orWhere('user_id', $userId);
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
        return Inertia::render('app/management/posts/CreatePost');
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'content' => 'required|string|max:1500',
            'image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'visibility' => 'required|in:public,private',
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput()
                ->with(['error' => 'Please fix the form errors.']);
        }

        $filePath = null;
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $fileName = time() . '.' . $image->getClientOriginalExtension();
            $filePath = 'uploads/posts/' . $fileName;
            $image->move(public_path('uploads/posts/'), $fileName);
        }

        Post::create([
            'user_id' => Auth::id(),
            'title' => $request->title,
            'content' => $request->content,
            'visibility' => $request->visibility,
            'image' => $filePath,
        ]);

        return redirect()->route('posts.index')
            ->with('success', 'Post created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $post = Post::findOrFail($id);

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
