
<?php
use App\Http\Controllers\Api\ReminderController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\FollowUpController;

Route::get('/follow-ups', [FollowUpController::class, 'index']);
Route::post('/follow-ups', [FollowUpController::class, 'store']);
Route::get('/follow-ups/{followUp}', [FollowUpController::class, 'show']);
Route::put('/follow-ups/{followUp}', [FollowUpController::class, 'update']);

Route::get('/reminders', [ReminderController::class, 'index']);
Route::get('/reminders/{reminder}', [ReminderController::class, 'show']);
Route::get('/reminders/{reminder}/attempts', [ReminderController::class, 'attempts']);