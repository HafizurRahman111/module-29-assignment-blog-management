<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Notification>
 */
class NotificationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_id' => User::inRandomOrder()->first()->id,
            'type' => $this->faker->randomElement(['like', 'comment', 'reply']),
            'message' => $this->faker->sentence(),
            'read_at' => $this->faker->boolean(70) ? $this->faker->dateTimeBetween('-1 month', 'now') : null,
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
