# Week 15 – Defect Log

**Project Title:** Mobile Clinic Follow-Up Reminder System  
**Testing Phase:** Integration Testing and Security Hardening (IA6)  
**Prepared by:** Alexandrie Abon  
**Testing Period:** November 2026

---

## 1. Purpose

The defect log records identified system weaknesses, their possible effects, priority levels, and recommended corrective actions.

It helps track issues that may affect authentication, authorization, data protection, reminder processing, and application reliability.

## 2. Defect Priority Classification

| Priority | Description |
|---|---|
| Critical | A weakness that may expose sensitive information or allow serious unauthorized access. |
| High | A weakness that may affect important system functions or security controls. |
| Medium | A weakness that affects usability, reliability, or a specific system function. |
| Low | A minor issue with limited impact. |

## 3. Identified Defects and Weaknesses

| Defect ID | Identified Weakness | Possible Impact | Priority | Recommended Corrective Action |
|---|---|---|---|---|
| DEF-001 | Unauthenticated API requests may be handled incorrectly when the client does not request JSON responses. | The API may return an internal server error instead of a proper unauthorized response. | Medium | Ensure API clients send the `Accept: application/json` header and configure API authentication responses appropriately. |
| DEF-002 | Reminder processing depends on the Laravel scheduler and queue worker. | Reminders may not be processed on time if either service stops running. | High | Configure continuous scheduler and queue worker execution with monitoring and recovery procedures. |
| DEF-003 | The local development API uses HTTP instead of HTTPS. | Network traffic may be exposed if used outside a trusted local environment. | High | Use HTTPS when deploying the application to a hosted environment. |

## 4. Defect Status

| Defect ID | Corrective Action | Status |
|---|---|---|
| DEF-001 | Use JSON request headers and review API authentication response handling. | Addressed for JSON API requests; broader configuration review recommended. |
| DEF-002 | Review scheduler and queue worker configuration. | Improvement recommended; continuous operation requires verification. |
| DEF-003 | Identify HTTPS as a deployment requirement. | Pending deployment configuration. |

## 5. Defect Summary

| Summary | Count |
|---|---:|
| Total Identified Weaknesses | 3 |
| Critical | 0 |
| High | 2 |
| Medium | 1 |
| Low | 0 |

## 6. Conclusion

The defect log identifies three areas that require attention: API authentication response handling, reminder processing reliability, and secure network communication.

The identified weaknesses provide a basis for prioritizing corrective actions and improving the overall security and reliability of the system.