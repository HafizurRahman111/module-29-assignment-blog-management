<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

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
            'image' => $this->faker->optional()->imageUrl(640, 480, 'post', true),
            'visibility' => $this->faker->randomElement(['public', 'private']),
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
