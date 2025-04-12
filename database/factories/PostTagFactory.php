<?php

namespace Database\Factories;

use App\Models\Post;
use App\Models\PostTag;
use App\Models\Tag;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\PostTag>
 */
class PostTagFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $postTag = null;

        do {
            $post = Post::inRandomOrder()->first();
            $tag = Tag::inRandomOrder()->first();

            // Check if the combination already exists
            $postTag = PostTag::where('post_id', $post->id)
                ->where('tag_id', $tag->id)
                ->first();
        } while ($postTag);

        return [
            'post_id' => $post->id,
            'tag_id' => $tag->id,
        ];
    }
}
