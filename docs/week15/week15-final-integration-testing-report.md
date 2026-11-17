# Week 15 Final Integration Testing and Security Hardening Report

## 1. Project Information

| Item | Details |
|---|---|
| Project Name | Mobile Clinic Follow-Up Reminder System |
| Assessment | Week 15 – Integration Testing and Security Hardening |
| Course Output | IA6 |
| Frontend | Flutter Web and Dart |
| Backend | Laravel and PHP |
| Database | MySQL |
| API Authentication | Laravel Sanctum |
| Testing Focus | Integration, functionality, validation, authentication, authorization, reliability, and security |

## 2. Executive Summary

This report presents the integration testing and security hardening activities for the Mobile Clinic Follow-Up Reminder System. The testing covered the Flutter Web interface, Laravel API, database operations, authentication, role-based access, reminder processing, failure handling, and regression checks.

The testing documents contain functional, invalid-input, authentication, authorization, interoperability, reliability, and security scenarios. The system was also reviewed for weaknesses involving API response handling, background reminder processing, and HTTPS configuration.

The documented test results are recorded as passed based on the assumed results used in preparing the testing documents. However, these results should not be treated as proof that every scenario was independently executed. Actual verification is limited to the specific commands and observations identified in this report and the evidence index.

## 3. Testing Objectives

The main objectives were to:

1. Check whether Flutter Web communicates with the Laravel API.
2. Verify login, logout, and protected API access.
3. Check role-based access restrictions.
4. Validate required fields and invalid inputs.
5. Review follow-up, reminder, and activity-log operations.
6. Check reminder retry and failure-handling behavior.
7. Identify security and reliability weaknesses.
8. Review changes made during security hardening.
9. Prepare regression test records for previously covered functions.
10. Identify remaining risks and possible improvements.

## 4. Testing Scope

The testing covered the following areas:

| Testing Area | Description |
|---|---|
| Functional Testing | Follow-up, reminder, activity, and account functions |
| Invalid-Input Testing | Missing fields and incorrect login details |
| Authentication Testing | Login, logout, and unauthenticated requests |
| Authorization Testing | Access restrictions based on user roles |
| API Testing | Requests between the frontend and Laravel backend |
| Flutter Web Testing | Page loading, navigation, and interface states |
| Reliability Testing | Reminder retries, temporary failures, and recovery |
| Security Testing | Protected routes, password handling, and configuration |
| Regression Testing | Rechecking functions after changes |

## 5. Testing Approaches Considered

Two feasible testing approaches were considered.

### Approach A: Manual and Record-Based Testing

This approach uses browser testing, API requests, command-line checks, and written test records.

**Advantages:**
- Easy to perform with the existing development environment.
- Allows direct observation of application behavior.
- Requires fewer additional testing tools.
- Suitable for checking complete user workflows.

**Disadvantages:**
- Repeated testing takes time.
- Results depend on accurate manual recording.
- It is easier to miss scenarios.
- It provides less automated repeatability.

### Approach B: Automated Testing

This approach uses automated backend tests and Flutter tests to check expected application behavior.

**Advantages:**
- Tests can be repeated consistently.
- Failures can be detected during development.
- Useful for regression testing.
- Reduces repeated manual work.

**Disadvantages:**
- Requires additional test code and maintenance.
- Test cases must be properly designed.
- Automated tests may not fully represent real browser and network behavior.
- Additional setup is needed for integration testing.

### Selected Approach

A combined approach was selected. Manual browser and API test records were used to organize the main integration scenarios, while available Laravel test commands were used for backend verification.

This approach was practical for the current project. However, the limited automated test coverage means that additional automated tests are recommended before considering the system ready for actual clinic use.

## 6. Testing Environment

| Component | Environment |
|---|---|
| Operating System | Windows 11 |
| Frontend Framework | Flutter |
| Programming Language | Dart |
| Backend Framework | Laravel |
| Backend Language | PHP |
| Database | MySQL |
| Authentication | Laravel Sanctum |
| Browser Testing | Google Chrome |
| Local API | `http://127.0.0.1:8000/api` |
| Android Emulator API | `http://10.0.2.2:8000/api` |

The local API address is intended for Flutter Web running on the same computer. The Android emulator uses a different host address.

## 7. Testing Results Summary

The following table summarizes the test scenarios documented in the previous folders.

| Testing Document | Documented Cases | Recorded Result |
|---|---:|---|
| Test Traceability Matrix | 12 | 12 PASS |
| Backend API Testing | 9 | 9 PASS |
| Laravel Backend Testing | 9 | 9 PASS |
| Flutter Web Testing | 12 | 12 PASS |
| Flutter Web State Testing | 9 | 9 PASS |
| Failure Testing | 8 | 8 PASS |
| Reliability Testing | 8 | 8 PASS |
| Regression Testing | 12 | 12 PASS |
| **Total** | **79** | **79 recorded as PASS** |

**Important:** These are the recorded results in the prepared test documents. They are assumed results, not independently verified execution results for all 79 scenarios. Some scenarios overlap across testing categories.

## 8. Security Weaknesses and Hardening Review

Three weaknesses were documented during the security review.

| Weakness | Priority | Review and Action |
|---|---|---|
| API authentication response handling | Medium | JSON requests should receive appropriate API responses instead of browser login redirects. |
| Scheduler and queue worker dependency | High | Reminder processing depends on background services remaining active. Monitoring and recovery should be improved. |
| HTTPS configuration | High | Local development uses HTTP. HTTPS must be configured and verified in the deployment environment. |

### Security Controls Reviewed

- Laravel Sanctum authentication.
- Role-based middleware for protected operations.
- Server-side input validation.
- Password hashing through Laravel authentication mechanisms.
- Protected API routes.
- Patient record access restrictions.
- Exclusion of the `.env` file from Git.
- Activity logging for relevant system actions.
- Minimal reminder content to avoid exposing unnecessary information.

These controls should still be checked against the actual deployed configuration before production use.

## 9. Actual Verification and Remaining Limitations

The following observations were available from earlier development checks:

1. An unauthenticated API request without an `Accept: application/json` header initially produced a redirect-related server error because the named `login` route was unavailable.
2. Repeating the API request with the `Accept: application/json` header returned HTTP 401, which is the expected unauthenticated API response.
3. The Laravel test command previously reported two default example tests passing. This does not prove that all documented backend scenarios have automated test coverage.
4. The Laravel scheduler listed the `process-due-reminders` task. Scheduler registration does not independently prove that reminders are processed successfully over time.
5. HTTPS deployment was not verified.

Other limitations include the need for broader automated testing, real browser and device compatibility checks, and longer-running reminder reliability tests.

## 10. Remaining Risks

| Risk | Possible Effect | Recommended Improvement |
|---|---|---|
| Scheduler or queue worker stops | Reminders may not be processed on time | Add monitoring and automatic recovery |
| HTTPS is not configured | Data may be exposed during transmission | Configure and verify HTTPS |
| Limited automated test coverage | Some defects may remain undetected | Add dedicated Laravel and Flutter tests |
| Network interruption | Users may not retrieve updated information | Improve connection recovery and error messages |
| Long-running reminder behavior is not fully verified | Repeated or missed reminders may occur | Conduct extended reliability testing |

## 11. Acceptance Decision

**Current decision: Conditional acceptance for continued development and controlled demonstration.**

The documented testing activities provide a basis for reviewing the system's main functions and security controls. However, the available verification does not establish that every test scenario passed in an actual execution.

The system should not be described as production-ready until the remaining risks are addressed and the required tests are executed and reviewed.

**Recommended acceptance authority:** The project adviser, authorized evaluator, or designated clinic representative should review the actual test results and decide whether the system meets the intended requirements. A clinic representative should approve any use involving real clinic operations.

## 12. Conclusion

The Week 15 testing and security review organized the system's functional, integration, reliability, and security checks. The review also identified areas that need further attention, especially HTTPS configuration, background reminder processing, and automated test coverage.

The project has a documented basis for continued testing and improvement. Actual test execution, deployment verification, and authorized acceptance are still necessary before the system can be used in a real clinic environment.

## 13. Recommended Next Improvement

The next improvement should be to create dedicated automated tests for authentication, role restrictions, follow-up validation, reminder retry behavior, and activity logging. The scheduler and queue worker should also be monitored so that failed or delayed reminder processing can be detected.