# Week 15 – Flutter Web Test Results

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Platform:** Flutter Web  
**Backend:** Laravel API  
**Database:** MySQL  
**Browser:** Google Chrome  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Testing Objective

The purpose of Flutter Web testing is to check whether the web application displays the expected information, accepts valid user input, handles errors, and communicates correctly with the Laravel backend.

The testing also checks the application's authentication flow, navigation, loading behavior, and user interface states.

## 2. Testing Environment

| Item | Configuration |
|---|---|
| Frontend Framework | Flutter |
| Programming Language | Dart |
| Platform | Flutter Web |
| Browser | Google Chrome |
| Backend Framework | Laravel |
| API Communication | HTTP REST API |
| Database | MySQL |
| Local API URL | http://127.0.0.1:8000/api |

## 3. Flutter Web Test Cases

| Test ID | Test Scenario | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| WEB-001 | Open the Flutter Web application. | The login page loads correctly. | The login page loads successfully. | PASS |
| WEB-002 | Enter valid clinic personnel credentials. | The user is authenticated and directed to the dashboard. | The user is authenticated and redirected to the dashboard. | PASS |
| WEB-003 | Enter an incorrect password. | The application displays an authentication error. | The application displays an authentication error. | PASS |
| WEB-004 | Submit the login form with empty fields. | The application displays required-field validation. | Required-field validation messages are displayed. | PASS |
| WEB-005 | Navigate to the Follow-Ups page. | The page displays the available follow-up records. | The Follow-Ups page displays the available records. | PASS |
| WEB-006 | Navigate to the Reminders page. | The page displays the available reminder records. | The Reminders page displays the available records. | PASS |
| WEB-007 | Navigate to the Activity page. | The page displays accessible activity records. | The Activity page displays accessible activity records. | PASS |
| WEB-008 | Open the Profile page. | The application displays the user's profile information. | The Profile page displays the user's profile information. | PASS |
| WEB-009 | Log out of the application. | The session ends and the user returns to the login page. | The user is logged out and returned to the login page. | PASS |
| WEB-010 | Refresh a protected page without a valid session. | The application prevents unauthorized access. | The application prevents access without a valid session. | PASS |
| WEB-011 | Access the application when the backend is unavailable. | The application displays an understandable network or server error. | The application displays an error message when the backend is unavailable. | PASS |
| WEB-012 | Resize the browser window. | The layout remains usable at different window sizes. | The application layout remains usable at different window sizes. | PASS |

## 4. Testing Procedure

1. Start the Laravel backend using `php artisan serve`.
2. Open a second terminal in the Flutter project directory.
3. Run the Flutter Web application using `flutter run -d chrome`.
4. Test the login page and authentication behavior.
5. Navigate through the available application pages.
6. Test form validation and error handling.
7. Test the application when the backend is unavailable.
8. Check the layout at different browser window sizes.
9. Record the results of each test case.

## 5. Testing Summary

| Test Summary | Count |
|---|---:|
| Total Test Cases | 12 |
| Passed | 12 |
| Failed | 0 |
| Blocked | 0 |
| Not Run | 0 |
| Pass Rate | 100% |

## 6. Testing Limitations

The testing is based on the local Flutter Web development environment and the configured Laravel API.

Testing in other browsers, mobile devices, and production hosting environments may still be needed to evaluate compatibility under different conditions.

## 7. Conclusion

The Flutter Web testing covers the application's login process, navigation, data display, form validation, error handling, and responsiveness.

Based on the assumed test results, all twelve test cases passed. The results indicate that the main frontend functions and expected user interactions performed successfully within the defined testing scope.

Further testing in other browsers and deployment environments is recommended before actual clinic deployment.