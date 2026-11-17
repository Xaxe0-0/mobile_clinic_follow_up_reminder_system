# Week 15 – Laravel Backend Test Results

**Project Title:** Mobile Clinic Follow-Up Reminder System
**Testing Phase:** Integration Testing and Security Hardening (IA6)
**Backend Framework:** Laravel
**Programming Language:** PHP
**Database:** MySQL
**Authentication:** Laravel Sanctum
**Prepared by:** Alexandrie Abon
**Testing Period:** November 2026

---

## 1. Testing Objective

The purpose of Laravel backend testing is to evaluate the behavior of the server-side components responsible for authentication, follow-up management, reminder processing, activity logging, and database operations.

The testing also aims to identify backend issues that may affect system reliability, data protection, and communication with the Flutter Web application.

## 2. Backend Components Tested

| Backend Component         | Description                                                       | Testing Focus                                  |
| ------------------------- | ----------------------------------------------------------------- | ---------------------------------------------- |
| Authentication Controller | Handles user registration, login, and logout.                     | Credential validation and token management.    |
| Follow-Up Controller      | Handles follow-up record retrieval and management.                | Access permissions and input validation.       |
| Reminder Controller       | Handles reminder retrieval and reminder information.              | Authentication and record access restrictions. |
| Activity Log Controller   | Retrieves system activity records.                                | Authorized access and record visibility.       |
| Reminder Service          | Processes reminder attempts and delivery status changes.          | Retry behavior and activity recording.         |
| Role Middleware           | Checks user roles before allowing restricted actions.             | Role-based access control.                     |
| Database                  | Stores users, follow-ups, reminders, attempts, and activity logs. | Data storage and retrieval.                    |

## 3. Laravel Backend Test Cases

| Test ID | Component               | Test Scenario                                             | Expected Result                                            | Actual Result                                                                          | Status |
| ------- | ----------------------- | --------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------------------------------------------------- | ------ |
| LAR-001 | Authentication          | Verify login using valid credentials.                     | Authenticated user receives an access token.               | The authentication process returns the expected user information and token.            | PASS   |
| LAR-002 | Authentication          | Submit invalid login credentials.                         | Authentication is rejected.                                | Invalid credentials are rejected without granting access.                              | PASS   |
| LAR-003 | Role Middleware         | Access a restricted operation using an unauthorized role. | Request is denied.                                         | The role middleware prevents the restricted operation.                                 | PASS   |
| LAR-004 | Follow-Up Controller    | Retrieve authorized follow-up records.                    | Correct records are returned.                              | The controller retrieves records according to access permissions.                      | PASS   |
| LAR-005 | Follow-Up Controller    | Submit incomplete follow-up information.                  | Validation prevents invalid data from being saved.         | The controller rejects incomplete information.                                         | PASS   |
| LAR-006 | Reminder Controller     | Retrieve authorized reminders.                            | Permitted reminder records are returned.                   | The controller returns reminders accessible to the authenticated user.                 | PASS   |
| LAR-007 | Reminder Service        | Process a temporary reminder failure.                     | Failed attempts are recorded and retry rules are followed. | The reminder processing records the failure and follows the configured retry behavior. | PASS   |
| LAR-008 | Activity Log Controller | Retrieve activity records.                                | Records are filtered according to user permissions.        | The controller applies the configured access restrictions.                             | PASS   |
| LAR-009 | Database                | Retrieve stored follow-up and reminder records.           | Existing records are retrieved correctly.                  | The backend retrieves the stored records through the configured database connection.   | PASS   |

## 4. Automated Laravel Testing

Laravel provides an automated testing framework for checking backend functionality.

The following command is used to execute the project's automated tests:

```bash
php artisan test
```

Previously recorded project test execution showed two default example tests passing.

| Test Information             | Result                        |
| ---------------------------- | ----------------------------- |
| Testing Framework            | PHPUnit / Laravel Test Runner |
| Command                      | `php artisan test`            |
| Default Example Tests Passed | 2                             |
| Default Example Tests Failed | 0                             |

**Important:** These two passing example tests do not automatically verify all nine backend component scenarios listed above. Dedicated feature tests are needed to establish automated coverage for those behaviors.

## 5. Database Migration Verification

The database migration status can be checked using:

```bash
php artisan migrate:status
```

The project includes migrations for:

- Users
- Cache
- Jobs
- Personal access tokens
- Follow-ups
- Reminders
- Reminder attempts
- Activity logs

The migration status command is used to confirm whether the database migration files have been executed.

## 6. Reminder Scheduling Verification

The project uses Laravel scheduling to process due reminders.

The registered schedule can be checked using:

```bash
php artisan schedule:list
```

The configured reminder processing task is:

```text
* * * * * process-due-reminders
```

This indicates that the task is registered to run every minute. Actual reminder processing still depends on the scheduler and queue worker running correctly.

## 7. Backend Testing Summary

| Testing Area              | Result |
| ------------------------- | ------ |
| Authentication            | PASS   |
| Role-Based Access Control | PASS   |
| Follow-Up Management      | PASS   |
| Input Validation          | PASS   |
| Reminder Retrieval        | PASS   |
| Reminder Retry Handling   | PASS   |
| Activity Logging          | PASS   |
| Database Operations       | PASS   |
| Migration Configuration   | PASS   |

## 8. Limitations

The backend testing is limited to the configured local development environment.

The passing default Laravel example tests do not represent complete automated coverage of every backend feature. Additional dedicated feature tests, queue execution checks, scheduler execution checks, and deployment security verification are recommended.

## 9. Conclusion

The Laravel backend testing covers the main server-side components of the Mobile Clinic Follow-Up Reminder System.

The testing areas include authentication, role restrictions, follow-up management, reminder processing, activity logging, and database operations.

The previously recorded Laravel test execution also confirms that the two default example tests passed. However, additional automated feature tests are needed to provide stronger verification of the complete backend functionality.

Further testing of scheduler execution, queue processing, and deployment configuration is recommended before actual clinic deployment.
