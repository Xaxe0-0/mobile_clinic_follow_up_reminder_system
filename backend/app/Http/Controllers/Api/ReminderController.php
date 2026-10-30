<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\Reminder;

class ReminderController extends Controller
{
    public function index()
    {
        $reminders = Reminder::with('followUp')
            ->latest()
            ->paginate(10);

        return response()->json($reminders);
    }

    public function show(Reminder $reminder)
    {
        return response()->json(
            $reminder->load(['followUp', 'attempts'])
        );
    }

    public function attempts(Reminder $reminder)
    {
        return response()->json(
            $reminder->attempts()->latest('attempted_at')->get()
        );
    }
}