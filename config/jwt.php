<?php

return [
    'secret' => env('JWT_SECRET'),
    'ttl' => env('JWT_TTL', 1440), // in minutes (24 hours)
    'refresh_ttl' => env('JWT_REFRESH_TTL', 20160), // in minutes (14 days)
];