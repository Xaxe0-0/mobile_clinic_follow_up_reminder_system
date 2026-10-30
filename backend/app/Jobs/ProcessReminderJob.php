<?php

namespace App\Jobs;

use App\Models\Reminder;
use App\Services\ReminderService;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

class ProcessReminderJob implements ShouldQueue
{
    use Queueable;

    public function __construct(
        public int $reminderId
    ) {}

    public function handle(ReminderService $reminderService): void
    {
        $reminder = Reminder::find($this->reminderId);

        if (!$reminder) {
            return;
        }

        if (in_array($reminder->status, ['delivered', 'manual_review'])) {
            return;
        }

        if ($reminder->next_attempt_at &&
            $reminder->next_attempt_at->isFuture()) {
            return;
        }

        $reminderService->process($reminder);
    }
}
