
<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\FollowUpController;
use App\Http\Controllers\Api\ReminderController;
use App\Http\Controllers\Api\ActivityLogController;
use Illuminate\Support\Facades\Route;

// Public authentication routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Authenticated API routes
Route::middleware('auth:sanctum')->group(function () {

    Route::post('/logout', [AuthController::class, 'logout']);

    // Follow-up routes
    Route::get('/follow-ups', [FollowUpController::class, 'index']);
    Route::get('/follow-ups/{followUp}', [FollowUpController::class, 'show']);

    Route::middleware('role:clinic_personnel,coordinator')->group(function () {
        Route::post('/follow-ups', [FollowUpController::class, 'store']);
        Route::put('/follow-ups/{followUp}', [FollowUpController::class, 'update']);
    });

    // Reminder routes
    Route::get('/reminders', [ReminderController::class, 'index']);
    Route::get('/reminders/{reminder}', [ReminderController::class, 'show']);
    Route::get('/reminders/{reminder}/attempts', [ReminderController::class, 'attempts']);

    // Activity log routes
    Route::get('/activity-logs', [ActivityLogController::class, 'index']);
});
