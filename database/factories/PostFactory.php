<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Post>
 */
class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */


    public function definition(): array
    {
        return [
            'user_id' => User::inRandomOrder()->value('id'),
            'title' => $this->faker->sentence,
            'content' => $this->faker->paragraphs(3, true),
            'image' => 'https://dummyimage.com/640x480/' . ltrim($this->faker->hexColor, '#') . '/' . ltrim($this->faker->hexColor, '#') . '&text=' . urlencode($this->faker->word),
            'visibility' => $this->faker->randomElement(['public', 'private']),
            'created_at' => now(),
            'updated_at' => now(),
        ];

    }
}
