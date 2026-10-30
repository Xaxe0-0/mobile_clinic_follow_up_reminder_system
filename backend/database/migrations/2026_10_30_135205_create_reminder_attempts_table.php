
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reminder_attempts', function (Blueprint $table) {
            $table->id();

            $table->foreignId('reminder_id')
                ->constrained('reminders')
                ->cascadeOnDelete();

            $table->unsignedInteger('attempt_number');

            $table->enum('status', [
                'delivered',
                'failed'
            ]);

            $table->string('failure_type')->nullable();
            $table->text('failure_message')->nullable();

            $table->dateTime('attempted_at');
            $table->dateTime('next_retry_at')->nullable();

            $table->timestamps();

            $table->unique(['reminder_id', 'attempt_number']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reminder_attempts');
    }
};
