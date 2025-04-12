<?php

namespace App\Http\Middleware;

use Closure;
use App\Facades\FirebaseJWT;
use Exception;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class FirebaseJwtMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $token = $request->bearerToken();

        if (!$token) {
            return response()->json(['error' => 'Authorization token not found'], 401);
        }

        try {
            $decoded = FirebaseJWT::decode($token);

            // Additional check for password reset tokens
            if (isset($decoded->reset_password) && $decoded->reset_password === true) {
                if (!$request->is('api/auth/password/reset')) {
                    return response()->json(['error' => 'Token is only valid for password reset'], 403);
                }
            }

            // Attach user to the request
            $request->auth = $decoded;

        } catch (Exception $e) {
            return response()->json(['error' => 'Invalid or expired token'], 401);
        }

        return $next($request);
    }
}