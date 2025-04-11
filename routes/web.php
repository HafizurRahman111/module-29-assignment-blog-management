<?php

use App\Http\Controllers\DashboardController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\SiteController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;


Route::get('/', [SiteController::class, 'index']);
Route::get('/blog', [SiteController::class, 'blog'])->name('blog');
Route::get('/about', [SiteController::class, 'about'])->name('about');


// Dashboard related routes
Route::get('/dashboard', [DashboardController::class, 'index'])->name('index');
Route::get('/dashboard/profile', [DashboardController::class, 'profile'])->name('profile');

Route::get('/users', [UserController::class, 'index'])->name('users.index');


Route::get('/posts', [PostController::class, 'index'])->name('posts.index');