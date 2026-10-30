<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\FollowUp;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class FollowUpController extends Controller
{
    public function index(Request $request)
    {
        $followUps = FollowUp::with(['patient', 'creator'])
            ->latest()
            ->paginate(10);

        return response()->json($followUps);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'patient_id' => ['required', 'exists:users,id'],
            'created_by' => ['required', 'exists:users,id'],
            'scheduled_at' => ['required', 'date', 'after:now'],
            'reminder_at' => ['required', 'date', 'before:scheduled_at'],
            'notes' => ['nullable', 'string', 'max:500'],
        ]);

        $followUp = FollowUp::create($validated);

        return response()->json([
            'message' => 'Follow-up created successfully.',
            'data' => $followUp,
        ], 201);
    }

    public function show(FollowUp $followUp)
    {
        return response()->json(
            $followUp->load(['patient', 'creator', 'reminders'])
        );
    }

    public function update(Request $request, FollowUp $followUp)
    {
        $validated = $request->validate([
            'scheduled_at' => ['sometimes', 'required', 'date', 'after:now'],
            'reminder_at' => ['sometimes', 'required', 'date', 'before:scheduled_at'],
            'notes' => ['nullable', 'string', 'max:500'],
            'status' => [
                'sometimes',
                Rule::in(['scheduled', 'confirmed', 'completed', 'cancelled', 'no_response', 'expired']),
            ],
        ]);

        $followUp->update($validated);

        return response()->json([
            'message' => 'Follow-up updated successfully.',
            'data' => $followUp,
        ]);
    }
}
