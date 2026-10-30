<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ReminderAttempt extends Model
{
    protected $fillable = [
        'reminder_id',
        'attempt_number',
        'status',
        'failure_type',
        'failure_message',
        'attempted_at',
        'next_retry_at',
    ];

    protected function casts(): array
    {
        return [
            'attempted_at' => 'datetime',
            'next_retry_at' => 'datetime',
        ];
    }

    public function reminder(): BelongsTo
    {
        return $this->belongsTo(Reminder::class);
    }
}