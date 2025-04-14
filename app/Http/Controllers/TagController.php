<?php

namespace App\Http\Controllers;

use App\Models\Tag;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Inertia\Inertia;

class TagController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $tags = Tag::latest()->get();

        return Inertia::render('app/management/tags/TagList', [
            'tags' => $tags,
        ]);
    }

    public function create()
    {
        return Inertia::render('app/management/tags/CreateTag');
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255|unique:tags,name',
        ]);

        $tag = Tag::create($validated);

        return $request->wantsJson()
            ? response()->json(['message' => 'Tag created successfully.', 'name' => $tag->name, 'id' => $tag->id], 201)
            : redirect()->route('tags.index')->with('success', 'Tag created successfully.');
    }


    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        $tag = Tag::find($id);

        if (!$tag) {
            return redirect()->route('tags.index')->with('error', 'Tag not found.');
        }

        return Inertia::render('app/management/tags/EditTag', [
            'tag' => $tag, // Pass only the ID to the view
        ]);
    }



    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        // Retrieve the tag by its ID
        $tag = Tag::findOrFail($id);

        // Validate the input data
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255', Rule::unique('tags')->ignore($id)]
        ]);

        // Update the tag with the validated data
        $tag->update($validated);

        // Redirect with a success message
        return redirect()->route('tags.index')
            ->with('success', 'Tag updated successfully');
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $tag = Tag::find($id);

        if (!$tag) {
            // If tag is not found, return a response
            return response()->json(['message' => 'Tag not found'], 404);
        }

        // Proceed with deletion if the tag is found
        $tag->delete();

        return response()->json(['message' => 'Tag deleted successfully']);
    }

}
