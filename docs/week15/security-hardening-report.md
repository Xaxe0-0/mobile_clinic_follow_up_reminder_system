# Week 15 – Security Hardening Report

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Frontend:** Flutter Web  
**Backend:** Laravel  
**Database:** MySQL  
**Authentication:** Laravel Sanctum  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Objective

The purpose of security hardening is to strengthen the application's protection against unauthorized access, invalid requests, accidental data exposure, and common configuration weaknesses.

The hardening activities focus on authentication, role-based access control, input validation, protected configuration, and safe handling of application data.

## 2. Security Controls

| Security Area | Implemented or Configured Control | Purpose |
|---|---|---|
| Authentication | Laravel Sanctum token authentication. | Protects API resources from unauthenticated access. |
| Authorization | Role-based middleware. | Restricts operations according to user roles. |
| Input Validation | Laravel request validation. | Rejects incomplete or invalid information. |
| Password Protection | Laravel password hashing. | Avoids storing plain-text passwords. |
| API Protection | Authentication middleware on protected routes. | Requires an authenticated user for protected operations. |
| Data Access | User-based record filtering. | Limits access to records according to user permissions. |
| Configuration Protection | Environment variables stored in `.env`. | Keeps local configuration separate from application source code. |
| Error Handling | API error responses and application error messages. | Helps avoid exposing unnecessary internal details. |
| Data Minimization | Follow-up reminders use limited information. | Reduces unnecessary exposure of sensitive information. |

## 3. Security Hardening Activities

### 3.1 Authentication

Laravel Sanctum is used to authenticate users through API tokens.

The login process checks user credentials before issuing an access token. Logout removes the current access token.

### 3.2 Role-Based Access Control

The application uses role-based middleware to restrict protected operations.

The main roles are:

- Patient
- Clinic Personnel
- Coordinator

Restricted operations are available only to authorized roles.

### 3.3 Input Validation

Laravel validation rules are used to check incoming data.

Invalid or incomplete requests should be rejected before the application saves the submitted information.

### 3.4 Configuration Protection

Sensitive local configuration values are stored in the `.env` file.

The `.env` file is excluded from Git tracking to reduce the risk of exposing database credentials and other environment-specific settings.

### 3.5 Safe Data Handling

The application follows a data-minimization approach.

Reminder information should contain only the details needed to notify users about their scheduled follow-ups. Unnecessary medical information should not be included in reminder messages or application logs.

### 3.6 Secure Deployment

The local development environment uses HTTP. A production deployment must use HTTPS to protect communication between Flutter Web and the Laravel API.

Debug mode should also be disabled in the production environment.

## 4. Security Verification

| Test ID | Security Control | Expected Result | Status |
|---|---|---|---|
| SEC-001 | Unauthenticated API access | Protected endpoints reject unauthenticated requests. | PASS |
| SEC-002 | Invalid login credentials | Authentication is rejected. | PASS |
| SEC-003 | Unauthorized role access | Restricted operations are denied. | PASS |
| SEC-004 | Invalid input submission | Validation prevents invalid data from being saved. | PASS |
| SEC-005 | Environment configuration | `.env` is excluded from Git tracking. | PASS |
| SEC-006 | Password protection | Passwords are stored using Laravel hashing. | PASS |
| SEC-007 | Protected API routes | Protected routes require authentication. | PASS |
| SEC-008 | HTTPS deployment | HTTPS is identified as a required production control. | NOT VERIFIED |

## 5. Security Hardening Summary

The project has security controls for authentication, role restrictions, input validation, environment configuration, and protected API routes.

However, some controls still require additional verification, especially HTTPS deployment, continuous queue operation, scheduler monitoring, and production configuration.

## 6. Remaining Security Risks

| Risk | Possible Effect | Recommended Improvement |
|---|---|---|
| Local HTTP communication | Data may be exposed outside a trusted development environment. | Configure HTTPS for deployment. |
| Scheduler or queue interruption | Reminder processing may be delayed. | Add process monitoring and recovery. |
| Limited automated security coverage | Some security weaknesses may remain undetected. | Add dedicated automated feature and security tests. |
| Production configuration not verified | Incorrect deployment settings may expose application information. | Review production environment settings before deployment. |

## 7. Conclusion

The security hardening activities focus on improving authentication, authorization, input validation, configuration protection, and safe data handling.

The project has important foundational security controls, but additional deployment verification and automated security testing are still needed.

The system should be treated as a development project and should not be considered production-ready until the remaining risks are addressed.