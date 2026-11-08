<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use Illuminate\Http\Request;

class ActivityLogController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $query = ActivityLog::query()
            ->latest()
            ->select([
                'id',
                'user_id',
                'event_type',
                'old_status',
                'new_status',
                'description',
                'created_at',
            ]);

        // Patients can only view their own activity records.
        if ($user->isPatient()) {
            $query->where('user_id', $user->id);
        } elseif (
            !$user->isClinicPersonnel() &&
            !$user->isCoordinator()
        ) {
            return response()->json([
                'message' => 'You are not authorized to view activity logs.',
            ], 403);
        }

        return response()->json($query->paginate(10));
    }
}
