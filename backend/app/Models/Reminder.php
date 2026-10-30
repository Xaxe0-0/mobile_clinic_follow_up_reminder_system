<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Reminder extends Model
{
    protected $fillable = [
        'follow_up_id',
        'scheduled_at',
        'next_attempt_at',
        'status',
        'attempt_count',
        'max_attempts',
        'delivered_at',
        'failure_reason',
    ];

    protected function casts(): array
    {
        return [
            'scheduled_at' => 'datetime',
            'next_attempt_at' => 'datetime',
            'delivered_at' => 'datetime',
        ];
    }

    public function followUp(): BelongsTo
    {
        return $this->belongsTo(FollowUp::class);
    }

    public function attempts(): HasMany
    {
        return $this->hasMany(ReminderAttempt::class);
    }
}
