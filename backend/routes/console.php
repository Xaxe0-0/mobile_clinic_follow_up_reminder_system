<?php

use App\Jobs\ProcessReminderJob;
use App\Models\Reminder;
use Illuminate\Support\Facades\Schedule;

Schedule::call(function () {
    Reminder::query()
        ->whereIn('status', ['pending', 'retrying'])
        ->where('scheduled_at', '<=', now())
        ->where(function ($query) {
            $query->whereNull('next_attempt_at')
                ->orWhere('next_attempt_at', '<=', now());
        })
        ->select('id')
        ->chunkById(100, function ($reminders) {
            foreach ($reminders as $reminder) {
                ProcessReminderJob::dispatch($reminder->id);
            }
        });
})->everyMinute()->name('process-due-reminders')->withoutOverlapping();
