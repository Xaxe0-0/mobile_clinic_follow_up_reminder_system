<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use App\Models\FollowUp;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class FollowUpController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $query = FollowUp::with(['patient', 'creator'])
            ->latest();

        // Patients can only view their own follow-ups.
        if ($user->isPatient()) {
            $query->where('patient_id', $user->id);
        } elseif (
            !$user->isClinicPersonnel() &&
            !$user->isCoordinator()
        ) {
            return response()->json([
                'message' => 'You are not authorized to view follow-ups.',
            ], 403);
        }

        return response()->json($query->paginate(10));
    }

    public function store(Request $request)
    {
        $user = $request->user();

        // Only clinic personnel and coordinators can create follow-ups.
        if (!$user->isClinicPersonnel() && !$user->isCoordinator()) {
            return response()->json([
                'message' => 'You are not authorized to create follow-ups.',
            ], 403);
        }

        $validated = $request->validate([
            'patient_id' => ['required', 'exists:users,id'],
            'scheduled_at' => ['required', 'date', 'after:now'],
            'reminder_at' => ['required', 'date', 'before:scheduled_at'],
            'notes' => ['nullable', 'string', 'max:500'],
        ]);

        $followUp = DB::transaction(function () use ($validated, $user) {
            $validated['created_by'] = $user->id;

            $followUp = FollowUp::create($validated);

            ActivityLog::create([
                'user_id' => $user->id,
                'event_type' => 'follow_up_created',
                'subject_type' => FollowUp::class,
                'subject_id' => $followUp->id,
                'old_status' => null,
                'new_status' => $followUp->status,
                'description' => 'A follow-up appointment was created.',
            ]);

            return $followUp;
        });

        return response()->json([
            'message' => 'Follow-up created successfully.',
            'data' => $followUp,
        ], 201);
    }

    public function show(Request $request, FollowUp $followUp)
    {
        $user = $request->user();

        // Patients can only view their own follow-ups.
        if (
            $user->isPatient() &&
            $followUp->patient_id !== $user->id
        ) {
            return response()->json([
                'message' => 'You are not authorized to view this follow-up.',
            ], 403);
        }

        if (
            !$user->isPatient() &&
            !$user->isClinicPersonnel() &&
            !$user->isCoordinator()
        ) {
            return response()->json([
                'message' => 'You are not authorized to view this follow-up.',
            ], 403);
        }

        return response()->json(
            $followUp->load(['patient', 'creator', 'reminders'])
        );
    }

    public function update(Request $request, FollowUp $followUp)
    {
        $user = $request->user();

        // Only clinic personnel and coordinators can update follow-ups.
        if (!$user->isClinicPersonnel() && !$user->isCoordinator()) {
            return response()->json([
                'message' => 'You are not authorized to update follow-ups.',
            ], 403);
        }

        $validated = $request->validate([
            'scheduled_at' => ['sometimes', 'required', 'date', 'after:now'],
            'reminder_at' => ['sometimes', 'required', 'date', 'before:scheduled_at'],
            'notes' => ['nullable', 'string', 'max:500'],
            'status' => [
                'sometimes',
                Rule::in([
                    'scheduled',
                    'confirmed',
                    'completed',
                    'cancelled',
                    'no_response',
                    'expired',
                ]),
            ],
        ]);

        DB::transaction(function () use ($followUp, $validated, $user) {
            $oldStatus = $followUp->status;

            $followUp->update($validated);

            $newStatus = $followUp->fresh()->status;

            $statusChanged = $oldStatus !== $newStatus;

            ActivityLog::create([
                'user_id' => $user->id,
                'event_type' => $statusChanged
                    ? 'follow_up_status_updated'
                    : 'follow_up_updated',
                'subject_type' => FollowUp::class,
                'subject_id' => $followUp->id,
                'old_status' => $oldStatus,
                'new_status' => $newStatus,
                'description' => $statusChanged
                    ? 'A follow-up appointment status was changed.'
                    : 'A follow-up appointment was updated.',
            ]);
        });

        return response()->json([
            'message' => 'Follow-up updated successfully.',
            'data' => $followUp->fresh(),
        ]);
    }
}
