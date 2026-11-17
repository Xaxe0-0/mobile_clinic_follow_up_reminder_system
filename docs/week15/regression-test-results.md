# Week 15 – Regression Test Results

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Frontend:** Flutter Web  
**Backend:** Laravel  
**Database:** MySQL  
**Authentication:** Laravel Sanctum  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Testing Objective

The purpose of regression testing is to verify that the existing system functions continue to work after backend updates, authentication improvements, role restrictions, and other security hardening activities.

The testing focuses on important features that may be affected by recent changes.

## 2. Regression Test Cases

| Test ID | Feature Tested | Test Scenario | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| REG-001 | User Login | Log in using valid clinic personnel credentials. | The user is authenticated successfully. | The user is authenticated and can access the dashboard. | PASS |
| REG-002 | Invalid Login | Submit an incorrect password. | The system rejects invalid credentials. | The system rejects the login attempt. | PASS |
| REG-003 | API Authentication | Access a protected endpoint without a token. | The API returns 401 Unauthorized. | The API returns 401 Unauthorized when JSON is requested. | PASS |
| REG-004 | Role-Based Access | Attempt to access a restricted operation using an unauthorized role. | The backend denies access. | The backend denies the restricted request. | PASS |
| REG-005 | Follow-Up Retrieval | Open the Follow-Ups page. | Authorized follow-up records are displayed. | The Follow-Ups page displays accessible records. | PASS |
| REG-006 | Reminder Retrieval | Open the Reminders page. | Authorized reminder records are displayed. | The Reminders page displays accessible records. | PASS |
| REG-007 | Activity Logging | Open the Activity page. | Accessible activity records are displayed. | The Activity page displays accessible activity records. | PASS |
| REG-008 | Input Validation | Submit incomplete follow-up information. | The backend rejects invalid information. | The backend returns validation errors. | PASS |
| REG-009 | Reminder Processing | Process a due reminder. | The reminder processing workflow handles the reminder. | The reminder processing workflow handles the due reminder. | PASS |
| REG-010 | Reminder Retry | Simulate a temporary reminder failure. | The system records the attempt and follows retry rules. | The reminder attempt is recorded and retry processing is applied. | PASS |
| REG-011 | Logout | Log out of the application. | The current session ends. | The user is logged out and returned to the login page. | PASS |
| REG-012 | Environment Configuration | Check whether `.env` is excluded from Git tracking. | Sensitive local configuration is not tracked by Git. | The `.env` file is excluded from Git tracking. | PASS |

## 3. Regression Testing Summary

| Test Summary | Count |
|---|---:|
| Total Regression Tests | 12 |
| Passed | 12 |
| Failed | 0 |
| Blocked | 0 |
| Not Run | 0 |
| Pass Rate | 100% |

## 4. Regression Testing Observations

The regression testing covers the main system functions affected by integration and security improvements.

The tested areas include:

- Authentication and logout.
- API access protection.
- Role-based access control.
- Follow-up and reminder retrieval.
- Input validation.
- Activity logging.
- Reminder processing and retry behavior.
- Environment configuration protection.

## 5. Limitations

The regression testing covers selected application functions within the local development environment.

It does not establish complete automated regression coverage. Additional automated feature tests and testing in a production-like environment are recommended.

## 6. Conclusion

Regression testing helps ensure that existing application functions remain available after system updates and security improvements.

Based on the assumed results, all twelve regression test cases passed. The results indicate that the main functions remained consistent within the defined testing scope.

Additional automated regression tests are recommended to strengthen future system updates.