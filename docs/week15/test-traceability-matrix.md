# Week 15 – Test Cases and Traceability Matrix

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Frontend:** Flutter Web  
**Backend:** Laravel  
**Database:** MySQL  
**Browser:** Google Chrome  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Testing Overview

The purpose of this testing activity is to verify the functionality, integration, reliability, authentication, authorization, and security of the Mobile Clinic Follow-Up Reminder System.

Testing focuses on the communication between the Flutter Web interface, Laravel backend API, and MySQL database. It also checks how the system handles invalid inputs, unauthorized requests, network problems, and reminder processing failures.

The test cases cover both normal operations and situations where the system must reject requests or handle failures safely.

## 2. Test Cases

| Test ID | Requirement Area | Feature / Condition | Test Scenario | Test Type | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|---|---|
| TC-001 | Authentication | Login | Log in using valid clinic personnel credentials. | Functional | User successfully logs in and reaches the dashboard. | The system accepts the valid credentials and redirects the user to the dashboard. | PASS |
| TC-002 | Authentication | Login | Attempt to log in using an incorrect password. | Invalid Input | Login is rejected and a safe error message is displayed. | The system rejects the incorrect password and displays an error message without granting access. | PASS |
| TC-003 | Authentication | Protected API | Access a protected API endpoint without an authentication token. | Security | API rejects the request with an unauthenticated response. | The API rejects the request and does not provide protected information. | PASS |
| TC-004 | Authorization | Role Restriction | A patient attempts to create a follow-up record. | Security | API denies the request and no record is created. | The API denies the restricted action and does not create a follow-up record. | PASS |
| TC-005 | Follow-Ups | Follow-Up List | Clinic personnel opens the follow-up list. | Functional | Authorized follow-up records are returned and displayed. | The system successfully retrieves and displays the authorized follow-up records. | PASS |
| TC-006 | Follow-Ups | Input Validation | Submit a follow-up record with a required field missing. | Invalid Input | Validation rejects the request and no invalid record is saved. | The API returns a validation error and does not save the incomplete record. | PASS |
| TC-007 | Reminders | Reminder List | Open the reminders page using an authorized account. | Functional | The system displays reminders the user is permitted to view. | The system successfully retrieves and displays the authorized reminders. | PASS |
| TC-008 | Reminders | Retry Handling | Simulate a temporary reminder delivery failure. | Reliability | The system follows its configured retry policy and records the attempt. | The reminder processing records the failed attempt and follows the configured retry policy. | PASS |
| TC-009 | Activity Logs | Activity List | Open the activity logs page using an authorized account. | Functional | The system displays activity records permitted for the user's role. | The system retrieves and displays the activity records allowed for the account. | PASS |
| TC-010 | Interoperability | Flutter and Laravel API | Load follow-up records from Flutter Web while the backend is running. | Integration | Flutter Web receives and displays the API response. | Flutter Web successfully communicates with the Laravel API and displays the returned records. | PASS |
| TC-011 | Reliability | Backend Unavailable | Attempt to load API-backed information while Laravel is unavailable. | Failure | The UI displays a connection error and does not show false success. | The application handles the connection failure and displays an appropriate error. | PASS |
| TC-012 | Regression | Previously Fixed Features | Repeat affected tests after applying a security or reliability fix. | Regression | The fixed behavior works and related features remain functional. | The repeated tests confirm the expected behavior and no related regression is observed. | PASS |

## 3. Requirement Traceability Matrix

This matrix connects the project requirements to the test cases used to verify them.

| Requirement | Related Test IDs | Verification Method | Result |
|---|---|---|---|
| Functional Testing | TC-001, TC-005, TC-007, TC-009 | Perform normal operations through Flutter Web. | PASS |
| Invalid Input Testing | TC-002, TC-006 | Submit incorrect credentials and incomplete information. | PASS |
| Authentication | TC-001, TC-002, TC-003 | Test valid login, invalid login, and unauthenticated API access. | PASS |
| Authorization | TC-004 | Attempt a restricted operation using a patient account. | PASS |
| Interoperability | TC-010 | Verify communication between Flutter Web and Laravel API. | PASS |
| Reliability | TC-008, TC-011 | Test reminder retry behavior and backend connection failure handling. | PASS |
| Security | TC-003, TC-004, TC-006 | Test protected endpoints, role restrictions, and input validation. | PASS |
| Regression | TC-012 | Repeat affected test cases after applying fixes. | PASS |

## 4. Test Execution Summary

| Test Result | Number of Test Cases |
|---|---:|
| PASS | 12 |
| FAIL | 0 |
| BLOCKED | 0 |
| NOT RUN | 0 |
| **Total** | **12** |

**Test Success Rate:**

\[
\frac{12}{12}\times100=100\%
\]

All 12 test cases are recorded as passed in this test summary.

## 5. Test Status Definitions

| Status | Description |
|---|---|
| PASS | The actual result matches the expected result. |
| FAIL | The actual result does not match the expected result. |
| BLOCKED | The test cannot be completed because of an issue or dependency. |
| NOT RUN | The test has not yet been performed. |

## 6. Testing Environment

| Component | Configuration |
|---|---|
| Frontend | Flutter Web |
| Backend | Laravel |
| Programming Languages | Dart and PHP |
| Database | MySQL |
| Browser | Google Chrome |
| Operating System | Windows 11 |
| API Base URL | http://127.0.0.1:8000/api |

## 7. Testing Limitations

The testing was conducted within the available development environment using Flutter Web, Laravel, MySQL, and Google Chrome.

The results are limited to the tested scenarios and configured environment. They do not establish that the application is ready for production use.

Additional testing may still be necessary for HTTPS configuration, deployment security, browser compatibility, performance under heavier usage, and actual clinic operating conditions.

## 8. Conclusion

The test cases cover the major requirements of the Mobile Clinic Follow-Up Reminder System, including functional operations, invalid inputs, authentication, authorization, interoperability, reliability, security, and regression testing.

Based on the recorded test results, all 12 test cases passed their expected conditions. The test cases also provide a structured way to evaluate the system and identify areas that may require further improvement.

Further testing and review are recommended before considering the system for actual clinic use.