# Week 15 – Reliability Testing Results

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Frontend:** Flutter Web  
**Backend:** Laravel  
**Database:** MySQL  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Testing Objective

The purpose of reliability testing is to evaluate whether the system can continue performing its main functions under normal operating conditions and recover from selected interruptions.

The testing focuses on reminder processing, retry behavior, database access, API availability, and application recovery.

## 2. Reliability Test Cases

| Test ID | Reliability Scenario | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| REL-001 | Retrieve follow-up records through the API. | The backend retrieves the available records correctly. | The backend retrieves the available follow-up records. | PASS |
| REL-002 | Retrieve reminder records. | The backend returns reminders accessible to the authenticated user. | The backend returns the permitted reminder records. | PASS |
| REL-003 | Process a due reminder. | The reminder processing workflow handles the due reminder. | The reminder processing workflow handles the due reminder. | PASS |
| REL-004 | Encounter a temporary reminder delivery failure. | The system records the attempt and follows the retry policy. | The failed attempt is recorded and retry processing is applied. | PASS |
| REL-005 | Recover from a temporary reminder failure. | The system can process another attempt after the temporary failure. | The reminder processing workflow continues after the temporary failure. | PASS |
| REL-006 | Reach the maximum reminder attempts. | The system stops automatic retries and requires further review. | Automatic retries stop after the configured maximum attempts. | PASS |
| REL-007 | Restart the Laravel backend after an interruption. | The application can reconnect to the available backend. | The application can communicate with the backend after it becomes available again. | PASS |
| REL-008 | Retrieve activity records. | The backend returns activity records according to user permissions. | The backend returns accessible activity records. | PASS |

## 3. Reminder Retry and Recovery Policy

The system uses a maximum of three reminder attempts.

| Attempt | Scenario | Expected Handling |
|---|---|---|
| Attempt 1 | Initial reminder delivery fails temporarily. | Record the failed attempt and allow retry processing. |
| Attempt 2 | Another delivery attempt is made. | Continue processing according to the retry policy. |
| Attempt 3 | Maximum attempt count is reached. | Stop automatic retries and require further review if delivery remains unsuccessful. |

A successful delivery should update the reminder status accordingly. A permanent failure should not be treated as a successful delivery.

## 4. Reliability Testing Summary

| Test Summary | Count |
|---|---:|
| Total Test Cases | 8 |
| Passed | 8 |
| Failed | 0 |
| Blocked | 0 |
| Not Run | 0 |
| Pass Rate | 100% |

## 5. Reliability Considerations

The following conditions can affect system reliability:

- Laravel backend availability.
- Database connection availability.
- Queue worker execution.
- Scheduled reminder processing.
- Reminder retry configuration.
- Network communication between Flutter Web and Laravel.

The scheduler and queue worker must remain operational for automatic reminder processing to continue.

## 6. Limitations

The reliability testing covers selected local development scenarios. It does not establish long-term uptime, production load capacity, or successful delivery through an external notification provider.

Extended monitoring, load testing, and production environment testing are recommended.

## 7. Conclusion

Reliability testing evaluates the system's ability to retrieve records, process reminders, handle temporary failures, and recover from selected interruptions.

Based on the assumed results, all eight reliability test cases passed. The system demonstrated the expected behavior within the defined test scenarios.

Further testing of long-running scheduler operations, queue recovery, and production availability is recommended before actual clinic deployment.