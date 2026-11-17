# Week 15 – Backend API Test Results

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Backend Framework:** Laravel  
**Database:** MySQL  
**API Testing Tool:** Postman and PowerShell  
**API Base URL:** http://127.0.0.1:8000/api  
**Prepared by:** Andrie Abon  
**Testing Period:** November 2026

---

## 1. Testing Objective

The objective of backend API testing is to verify that the Laravel API processes requests correctly, validates submitted information, protects restricted endpoints, and communicates properly with the MySQL database.

The testing also checks authentication, authorization, error handling, and the retrieval of follow-up records, reminders, and activity logs.

## 2. API Test Environment

| Component | Configuration |
|---|---|
| Backend Framework | Laravel |
| Programming Language | PHP |
| Database | MySQL |
| Authentication | Laravel Sanctum |
| API Testing Tools | Postman and PowerShell |
| Local API Address | http://127.0.0.1:8000/api |
| Operating System | Windows 11 |

## 3. API Test Cases and Results

| Test ID | API Endpoint | Method | Test Description | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|---|
| API-001 | `/login` | POST | Submit valid clinic personnel credentials. | Returns successful authentication and an access token. | The API accepts the valid credentials and returns the authenticated user information and access token. | PASS |
| API-002 | `/login` | POST | Submit incorrect login credentials. | Returns HTTP 401 Unauthorized. | The API rejects the incorrect credentials and does not grant access. | PASS |
| API-003 | `/follow-ups` | GET | Access without an authentication token. | Returns HTTP 401 Unauthorized. | The API rejects the unauthenticated request and does not return protected records. | PASS |
| API-004 | `/follow-ups` | GET | Access using an authenticated clinic personnel account. | Returns authorized follow-up records. | The API successfully returns the follow-up records permitted for the account. | PASS |
| API-005 | `/follow-ups` | POST | Patient attempts to create a follow-up record. | Returns HTTP 403 Forbidden. | The API denies the restricted action and prevents the patient from creating a follow-up record. | PASS |
| API-006 | `/follow-ups` | POST | Submit a follow-up with a required field missing. | Returns HTTP 422 validation error. | The API rejects the incomplete request and returns validation information. | PASS |
| API-007 | `/reminders` | GET | Retrieve reminders using an authorized account. | Returns reminders permitted for the account. | The API successfully retrieves the reminders accessible to the authenticated user. | PASS |
| API-008 | `/activity-logs` | GET | Retrieve activity logs using an authorized account. | Returns activity records permitted for the account. | The API returns activity records according to the user's access permissions. | PASS |
| API-009 | `/logout` | POST | Log out using a valid authentication token. | Invalidates the current access token. | The API successfully processes logout and invalidates the current access token. | PASS |

## 4. HTTP Response Status Codes

The following HTTP status codes are used to identify the results of API requests.

| HTTP Status | Meaning | Application Behavior |
|---|---|---|
| 200 | OK | Request completed successfully. |
| 201 | Created | A resource was successfully created. |
| 401 | Unauthorized | Authentication is required or credentials are invalid. |
| 403 | Forbidden | The authenticated user is not allowed to perform the action. |
| 404 | Not Found | The requested resource does not exist. |
| 422 | Unprocessable Content | Submitted information failed validation. |
| 500 | Internal Server Error | An unexpected backend error occurred. |

## 5. API Testing Results Summary

| Result | Number of Tests |
|---|---:|
| PASS | 9 |
| FAIL | 0 |
| BLOCKED | 0 |
| NOT RUN | 0 |
| **Total** | **9** |

**API Test Success Rate:**

\[
\frac{9}{9}\times100=100\%
\]

## 6. Security and Validation Observations

The API testing covers the following security and validation behaviors:

1. Authentication is required before accessing protected endpoints.
2. Invalid login credentials are rejected.
3. Role restrictions prevent patients from performing unauthorized follow-up management actions.
4. Required fields are validated before information is accepted.
5. Protected records are returned according to the authenticated user's permissions.
6. Logout invalidates the current authentication token.

## 7. Conclusion

The backend API test cases cover authentication, authorization, follow-up management, reminder retrieval, activity log access, input validation, and logout functionality.

Based on the recorded results, all nine API test cases passed their expected conditions. The results indicate that the tested API operations behave as intended within the configured development environment.

Further security and integration testing should still be performed before considering the application for actual clinic use.