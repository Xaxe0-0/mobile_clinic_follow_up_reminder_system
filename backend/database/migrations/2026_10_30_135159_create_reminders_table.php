
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reminders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('follow_up_id')
                ->constrained('follow_ups')
                ->cascadeOnDelete();

            $table->dateTime('scheduled_at');
            $table->dateTime('next_attempt_at')->nullable();

            $table->enum('status', [
                'pending',
                'processing',
                'delivered',
                'retrying',
                'failed',
                'manual_review'
            ])->default('pending');

            $table->unsignedInteger('attempt_count')->default(0);
            $table->unsignedInteger('max_attempts')->default(3);
            $table->dateTime('delivered_at')->nullable();
            $table->text('failure_reason')->nullable();

            $table->timestamps();

            $table->index(['status', 'scheduled_at']);
            $table->index('next_attempt_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reminders');
    }
};
