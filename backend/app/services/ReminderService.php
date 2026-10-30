<?php

namespace App\Services;

use App\Models\Reminder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ReminderService
{
    public function process(Reminder $reminder): void
    {
        if ($reminder->status === 'delivered' ||
            $reminder->status === 'manual_review') {
            return;
        }

        if ($reminder->attempt_count >= $reminder->max_attempts) {
            $this->sendToManualReview($reminder, 'Maximum attempts reached.');
            return;
        }

        DB::transaction(function () use ($reminder) {
            $reminder->refresh();

            $reminder->update([
                'status' => 'processing',
            ]);

            $attemptNumber = $reminder->attempt_count + 1;

            $reminder->increment('attempt_count');

            $result = $this->simulateDelivery($attemptNumber);

            $reminder->attempts()->create([
                'attempt_number' => $attemptNumber,
                'status' => $result['status'],
                'failure_type' => $result['failure_type'],
                'failure_message' => $result['failure_message'],
                'attempted_at' => now(),
                'next_retry_at' => null,
            ]);

            if ($result['status'] === 'delivered') {
                $reminder->update([
                    'status' => 'delivered',
                    'delivered_at' => now(),
                    'next_attempt_at' => null,
                    'failure_reason' => null,
                ]);

                Log::info('Reminder delivered', [
                    'reminder_id' => $reminder->id,
                    'attempt' => $attemptNumber,
                ]);

                return;
            }

            if ($result['failure_type'] === 'permanent') {
                $this->sendToManualReview(
                    $reminder,
                    $result['failure_message']
                );

                return;
            }

            if ($attemptNumber >= $reminder->max_attempts) {
                $this->sendToManualReview(
                    $reminder,
                    'Maximum attempts reached.'
                );

                return;
            }

            $nextAttempt = now()->addMinute();

            $reminder->update([
                'status' => 'retrying',
                'next_attempt_at' => $nextAttempt,
                'failure_reason' => $result['failure_message'],
            ]);

            $reminder->attempts()
                ->where('attempt_number', $attemptNumber)
                ->update([
                    'next_retry_at' => $nextAttempt,
                ]);

            Log::warning('Reminder scheduled for retry', [
                'reminder_id' => $reminder->id,
                'attempt' => $attemptNumber,
            ]);
        });
    }

    private function simulateDelivery(int $attemptNumber): array
    {
        if ($attemptNumber === 1) {
            return [
                'status' => 'failed',
                'failure_type' => 'temporary',
                'failure_message' => 'Simulated temporary service failure.',
            ];
        }

        if ($attemptNumber === 2) {
            return [
                'status' => 'delivered',
                'failure_type' => null,
                'failure_message' => null,
            ];
        }

        return [
            'status' => 'failed',
            'failure_type' => 'permanent',
            'failure_message' => 'Simulated permanent delivery failure.',
        ];
    }

    private function sendToManualReview(
        Reminder $reminder,
        string $reason
    ): void {
        $reminder->update([
            'status' => 'manual_review',
            'next_attempt_at' => null,
            'failure_reason' => $reason,
        ]);

        Log::error('Reminder requires manual review', [
            'reminder_id' => $reminder->id,
        ]);
    }
}
