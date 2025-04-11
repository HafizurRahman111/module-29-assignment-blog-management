<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
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
        return Inertia::render('public/Blog');
    }
}
