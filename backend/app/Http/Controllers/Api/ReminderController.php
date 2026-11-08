<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Reminder;
use Illuminate\Http\Request;

class ReminderController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $query = Reminder::with('followUp')
            ->latest();

        // Patients can only view reminders for their own follow-ups.
        if ($user->isPatient()) {
            $query->whereHas('followUp', function ($followUpQuery) use ($user) {
                $followUpQuery->where('patient_id', $user->id);
            });
        }

        $reminders = $query->paginate(10);

        return response()->json($reminders);
    }

    public function show(Request $request, Reminder $reminder)
    {
        $user = $request->user();

        // Check whether the reminder belongs to the patient's follow-up.
        if (
            $user->isPatient() &&
            $reminder->followUp->patient_id !== $user->id
        ) {
            return response()->json([
                'message' => 'You are not authorized to view this reminder.',
            ], 403);
        }

        return response()->json(
            $reminder->load(['followUp', 'attempts'])
        );
    }

    public function attempts(Request $request, Reminder $reminder)
    {
        $user = $request->user();

        // Patients can only view attempts for their own reminders.
        if (
            $user->isPatient() &&
            $reminder->followUp->patient_id !== $user->id
        ) {
            return response()->json([
                'message' => 'You are not authorized to view these reminder attempts.',
            ], 403);
        }

        return response()->json(
            $reminder->attempts()->latest('attempted_at')->get()
        );
    }
}
