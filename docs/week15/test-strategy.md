# WEEK 15 — TEST STRATEGY AND TEST PLAN

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Testing Platform:** Flutter Web and Laravel API  
**Database:** MySQL  
**Prepared by:** Andrie Abon  
**Date:** November 2026

## 1. Testing Objectives

The purpose of this testing activity is to check whether the Flutter Web interface communicates correctly with the Laravel backend and MySQL database. It also aims to identify security weaknesses, verify access restrictions, and check how the system handles invalid inputs, network errors, and reminder failures.

## 2. Scope of Testing

The testing will cover the following areas:

- **Functional Testing:** Check login, follow-up records, reminders, and activity logs.
- **Invalid Input Testing:** Check how the system handles missing, incorrect, or invalid information.
- **Boundary Testing:** Check input limits and other defined validation boundaries.
- **Interoperability Testing:** Check communication between Flutter Web, Laravel API, and MySQL.
- **Authentication Testing:** Verify that users must log in before accessing protected features.
- **Authorization Testing:** Verify that users can only access features allowed by their assigned roles.
- **Reliability Testing:** Check reminder processing, retry behavior, and failure handling.
- **Security Testing:** Check input validation, protected configuration, and safe handling of sensitive information.

## 3. Testing Environment

| Component | Testing Environment |
|---|---|
| Frontend | Flutter Web |
| Backend | Laravel |
| Programming Language | Dart and PHP |
| Database | MySQL |
| Browser | Google Chrome |
| API Testing | HTTP requests |
| Backend Testing | Laravel automated tests |
| Operating System | Windows 11 |

## 4. Testing Approaches

The project will use the following testing approaches:

1. **Manual Testing** – Perform actions through the Flutter Web interface and observe the results.
2. **API Testing** – Send requests to Laravel API endpoints and verify their responses.
3. **Automated Backend Testing** – Run Laravel tests to check backend behavior.
4. **Security Testing** – Attempt unauthorized access and submit invalid information to check system protection.
5. **Regression Testing** – Repeat previously completed tests after applying fixes to check whether existing functions still work.

## 5. Test Data

Testing will use controlled fictional accounts and sample follow-up records. Real patient information, passwords belonging to actual users, and other private information will not be used in screenshots or reports.

## 6. Test Execution Criteria

A test will be marked:

- **PASS:** The actual result matches the expected result.
- **FAIL:** The actual result does not match the expected result.
- **BLOCKED:** The test cannot be completed because of an environment, configuration, or dependency issue.

Failed tests will be recorded, investigated, and prioritized. After applying a fix, the affected test and related regression tests will be performed again.

## 7. Defect Prioritization

Defects will be prioritized based on their impact:

- **High:** Security problems, unauthorized access, or major failures that prevent important system functions.
- **Medium:** Problems affecting important features but with a possible workaround.
- **Low:** Minor interface, display, or usability problems.

## 8. Assumptions, Constraints, and Dependencies

**Assumptions:**
- The Laravel backend and MySQL database can be started in the local testing environment.
- Test accounts and fictional records are available.
- Flutter Web can access the Laravel API.

**Constraints:**
- Testing is limited to the available development environment.
- Results from local testing do not prove production readiness.
- External services and real clinic operations are not included unless specifically configured and tested.

**Dependencies:**
- Laravel backend
- MySQL database
- Flutter Web application
- Google Chrome browser
- Local network and API configuration

## 9. Test Completion and Acceptance

Testing will be considered completed when the planned test cases have recorded results, identified defects have been documented, prioritized weaknesses have been addressed where possible, and affected tests have been repeated.

The project result must be reviewed by the authorized project evaluator or instructor. Remaining risks and limitations must be clearly reported rather than treated as resolved.

## 10. Remaining Risks and Future Improvement

Some issues may remain because testing is performed in a local development environment. A future improvement is to conduct additional testing in a controlled deployment environment, including HTTPS configuration, broader browser compatibility, and real-world reliability checks using safe test data.