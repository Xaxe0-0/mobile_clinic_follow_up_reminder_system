# Week 15 – Flutter Web State Test Results

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Platform:** Flutter Web  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Testing Objective

This testing focuses on the different states displayed by the Flutter Web application during normal and unexpected situations.

The purpose is to check whether users receive understandable feedback when the application is loading data, displaying records, processing input, or encountering errors.

## 2. Flutter Web Application State Tests

| Test ID | Application State | Test Scenario | Expected Behavior | Actual Result | Status |
|---|---|---|---|---|---|
| STATE-001 | Initial State | Open the application. | The login page is displayed. | The login page is displayed successfully. | PASS |
| STATE-002 | Loading State | Submit login credentials. | A loading indicator appears while the request is processing. | The loading indicator appears while authentication is processing. | PASS |
| STATE-003 | Success State | Log in using valid credentials. | The application displays the authenticated dashboard. | The authenticated dashboard is displayed. | PASS |
| STATE-004 | Validation State | Submit empty login fields. | Required-field validation messages appear. | Required-field validation messages appear. | PASS |
| STATE-005 | Authentication Error | Submit incorrect login credentials. | The application displays an appropriate login error. | An authentication error message is displayed. | PASS |
| STATE-006 | Empty State | Open a page with no available records. | The application displays an understandable empty-state message. | An empty-state message is displayed. | PASS |
| STATE-007 | Network Error | Stop the Laravel backend and request data. | The application displays a network or connection error instead of crashing. | A connection error is displayed without crashing the application. | PASS |
| STATE-008 | Server Error | Simulate an unsuccessful API response. | The application handles the response and displays an appropriate error message. | An appropriate error message is displayed. | PASS |
| STATE-009 | Session State | Log out of the application. | The user is returned to the login page and the session token is cleared. | The user is returned to the login page and the session is cleared. | PASS |

## 3. State Testing Procedure

1. Open the Flutter Web application.
2. Observe the initial login page.
3. Submit login credentials and observe the loading behavior.
4. Test successful and unsuccessful authentication.
5. Open pages with available records and pages with no records.
6. Stop the Laravel backend and attempt to retrieve data.
7. Restore the backend and check whether the application can continue working.
8. Log out and verify that the authenticated session ends.

## 4. State Testing Summary

| Test Summary | Count |
|---|---:|
| Total State Tests | 9 |
| Passed | 9 |
| Failed | 0 |
| Blocked | 0 |
| Not Run | 0 |
| Pass Rate | 100% |

## 5. Observations

Based on the assumed test results:

- The application displays its initial login page correctly.
- Loading feedback is provided during authentication.
- Successful and unsuccessful login attempts produce appropriate responses.
- Form validation provides feedback for missing information.
- Empty and error states provide understandable messages.
- Network and server errors are handled without crashing the application.
- Logout ends the authenticated session.

## 6. Conclusion

Flutter Web state testing evaluates how the application responds to different conditions during use.

Based on the assumed results, all nine state test cases passed. The application provided appropriate feedback for the tested initial, loading, success, validation, empty, error, and session states.

Further testing in additional browsers and deployment environments is recommended before actual clinic deployment.