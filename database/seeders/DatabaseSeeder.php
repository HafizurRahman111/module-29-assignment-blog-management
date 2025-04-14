<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        User::factory()->create([
            'username' => 'testuser',
            'email' => 'test@example.com',
            'password' => Hash::make('pass1234'),
            'profile_pic' => 'default/default-user-photo.png',
        ]);

        User::factory()->create([
            'username' => 'testuser2',
            'email' => 'test2@example.com',
            'password' => Hash::make('pass1234'),
            'profile_pic' => 'default/default-user-photo.png',
        ]);

        User::factory(count: 10)->create();

        $this->call([
            PostSeeder::class,
            TagSeeder::class,
            PostTagSeeder::class,
            CommentSeeder::class,
            LikeSeeder::class,
            BookmarkSeeder::class,
            NotificationSeeder::class
        ]);

    }
}
