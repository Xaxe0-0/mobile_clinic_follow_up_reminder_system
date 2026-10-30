# Mobile Clinic Follow-Up Reminder System

A privacy-aware clinic follow-up reminder application built using **Flutter and Dart** for the frontend, **Laravel REST API** for the backend, and **MySQL** for database management.

The system aims to help clinics manage follow-up appointments, track appointment confirmations, monitor missed follow-ups, and process scheduled reminders. It also includes a reminder retry mechanism to handle temporary delivery failures and identify cases that require manual review.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Objectives](#objectives)
3. [Technology Stack](#technology-stack)
4. [System Modules](#system-modules)
5. [System Features](#system-features)
6. [System Architecture](#system-architecture)
7. [Project Requirements](#project-requirements)
8. [Installation and Setup](#installation-and-setup)
9. [Running the Project](#running-the-project)
10. [User Manual](#user-manual)
11. [GitHub Workflow](#github-workflow)
12. [Security and Privacy](#security-and-privacy)
13. [Testing](#testing)
14. [Deployment](#deployment)
15. [Documentation and Maintenance](#documentation-and-maintenance)
16. [Project Status](#project-status)

---

## Project Overview

The Mobile Clinic Follow-Up Reminder System is designed to help clinics organize follow-up appointments and reduce missed appointments through scheduled reminders and follow-up tracking.

The system is intended to support patients and authorized clinic personnel in managing follow-up schedules, recording appointment responses, and identifying appointments that need further attention.

It also includes an automated reminder process with retry and recovery handling. Temporary reminder failures can be retried, while permanent or repeated failures can be flagged for clinic staff review.

The application is intended for clinic follow-up management. It is not a replacement for professional medical advice, diagnosis, or treatment.

## Objectives

- Organize and manage clinic follow-up schedules.
- Help patients receive reminders about upcoming follow-ups.
- Track appointment confirmations, cancellations, and completed appointments.
- Identify missed or unanswered follow-ups.
- Retry temporary reminder delivery failures.
- Allow authorized clinic staff to review unresolved reminder failures.
- Protect patient information through authentication and access control.
- Maintain documentation for testing, deployment, and future maintenance.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Build the application interface |
| Dart | Frontend programming language |
| Laravel 12 | Backend REST API |
| PHP | Backend programming language |
| MySQL | Database management |
| Laravel Scheduler | Schedule automated reminder processing |
| Laravel Queue | Process reminder jobs |
| Laravel Sanctum | API token authentication support |
| Visual Studio Code | Code editing and development |
| Android Studio | Android development and emulator support |
| Postman | API testing |
| PHPUnit | Backend testing |
| Flutter Test | Frontend testing |
| Git and GitHub | Version control and source code hosting |

## System Modules

The system is organized into the following modules:

1. **Dashboard Module** – Displays a summary of follow-ups, reminders, and recent activities.
2. **User Authentication Module** – Provides the login and account access interface.
3. **Follow-Up Management Module** – Manages follow-up appointment schedules and their statuses.
4. **Reminder Management Module** – Displays and monitors scheduled reminders and delivery statuses.
5. **Automated Reminder Processing Module** – Processes reminders using the Laravel Scheduler and Queue.
6. **Reminder Retry and Recovery Module** – Handles temporary failures and retries reminder processing.
7. **Activity Logs Module** – Records important system activities and status changes.
8. **Patient Profile Module** – Displays patient account information.

## System Features

### 1. User Authentication

- Login interface.
- Logout interface.
- Planned role-based access for patients and clinic personnel.
- Backend authentication and authorization support using Laravel Sanctum.

### 2. Follow-Up Appointment Management

- Create follow-up schedules.
- View upcoming and previous follow-ups.
- Update appointment information.
- Track follow-up statuses such as scheduled, confirmed, completed, cancelled, and no response.

### 3. Reminder Management

- Schedule reminders for upcoming follow-ups.
- Display reminder statuses.
- Track reminder attempts.
- Retry temporary delivery failures.
- Flag unresolved failures for manual review.

### 4. Automated Reminder Processing

- Process reminders that are due.
- Use Laravel Scheduler to identify reminders ready for processing.
- Use Laravel Queue to process reminder jobs.
- Record reminder attempts and their results.
- Support simulated successful delivery after a temporary failure.

### 5. Activity Logs

- Record important reminder processing activities.
- Track status changes.
- Identify reminders that require staff review.

### 6. Privacy and Security

- Validate incoming information on the backend.
- Support authentication and authorization.
- Avoid exposing sensitive medical information in reminder messages.
- Keep passwords and authentication tokens out of application logs.
- Use controlled sample data during development.

**Note:** Some features are still under development. Their availability depends on the current implementation and testing results.

## System Architecture

The system follows a client-server architecture.

1. **Flutter Frontend:** Displays the user interface and sends requests to the backend.
2. **Laravel REST API:** Handles requests, validates information, applies business rules, and processes records.
3. **MySQL Database:** Stores user, follow-up, reminder, reminder attempt, and activity log information.
4. **Laravel Scheduler:** Checks for reminders that are ready to be processed.
5. **Laravel Queue:** Handles reminder processing jobs.
6. **Reminder Service:** Simulates reminder delivery, handles retries, and records processing results.

The Flutter application communicates with MySQL through the Laravel REST API. It should never connect directly to the database.

## Project Requirements

Install the following tools before starting development:

- Flutter SDK
- Dart SDK (included with Flutter)
- PHP compatible with Laravel 12
- Composer
- MySQL Server
- Visual Studio Code or another code editor
- Git
- Android Studio and Android SDK if building or testing for Android
- Postman for API testing

Node.js and npm may also be needed for Laravel frontend assets.

## Installation and Setup

### 1. Clone the Repository

Open PowerShell or a terminal and run:

```bash
git clone https://github.com/Xaxe0-0/mobile_clinic_follow_up_reminder_system.git
cd mobile_clinic_follow_up_reminder_system
```

### 2. Set Up the Flutter Frontend

Install the Flutter dependencies:

```bash
flutter pub get
```

Check the Flutter installation:

```bash
flutter doctor
```

Check the available devices:

```bash
flutter devices
```

The current frontend can be run in Chrome using Flutter Web. Android testing requires an available Android emulator or physical device.

### 3. Set Up the Laravel Backend

Open a separate terminal and enter the backend folder:

```powershell
cd backend
```

Install the dependencies:

```bash
composer install
```

Create the environment file if it does not exist:

```powershell
Copy-Item .env.example .env
```

Generate the application key:

```bash
php artisan key:generate
```

### 4. Configure the MySQL Database

Create the database in MySQL or phpMyAdmin:

```sql
CREATE DATABASE clinic_follow_up_db;
```

Update the backend `.env` file with your local database configuration:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=clinic_follow_up_db
DB_USERNAME=root
DB_PASSWORD=
```

Change the username and password if your local MySQL installation uses different credentials.

Configure the queue and reminder simulation:

```dotenv
QUEUE_CONNECTION=database
REMINDER_SIMULATION_MODE=success_after_retry
```

Do not upload the `.env` file or real credentials to GitHub.

### 5. Run the Database Migrations

From the backend folder, execute:

```bash
php artisan migrate
```

This creates the required database tables.

### 6. Clear the Laravel Configuration Cache

Run:

```bash
php artisan optimize:clear
```

### 7. Configure the Flutter API URL

The Flutter frontend must use the correct Laravel API address.

For local Chrome development, the API base URL is commonly:

```text
http://127.0.0.1:8000/api
```

For the standard Android Studio emulator, use:

```text
http://10.0.2.2:8000/api
```

For a physical Android device, use the computer's reachable local network IP address.

These HTTP addresses are for local development only. Use HTTPS for production.

## Running the Project

For local development, you may need multiple terminals.

### Terminal 1 – Flutter Frontend

From the project root:

```bash
flutter pub get
flutter run -d chrome
```

This starts the Flutter application in Google Chrome.

For Android testing, use:

```bash
flutter run
```

Select an available Android device when prompted.

### Terminal 2 – Laravel Backend

From the backend folder:

```bash
php artisan serve
```

The local backend address is commonly:

```text
http://127.0.0.1:8000
```

### Terminal 3 – Laravel Queue Worker

From the backend folder:

```bash
php artisan queue:work
```

This processes queued reminder jobs.

### Terminal 4 – Laravel Scheduler

From the backend folder:

```bash
php artisan schedule:work
```

This continuously checks scheduled tasks, including due reminders.

Keep the queue worker and scheduler running when testing automated reminder processing.

To stop a running development process, press `Ctrl + C` in its terminal.

## User Manual

This section explains how to use the current application interface. Some screens currently display sample information and may not yet be connected to the backend database.

### 1. Opening the Application

1. Open the project folder in Visual Studio Code or PowerShell.
2. Make sure the Flutter dependencies are installed.
3. Run the application:

   ```bash
   flutter run -d chrome
   ```

4. Wait for Google Chrome to open.
5. The login screen should appear.

### 2. Logging In

1. Enter an email address containing `@`.
2. Enter any non-empty password.
3. Click the **Login** button.
4. The dashboard should appear.

**Important:** The current frontend login is only a prototype. It checks the input format but does not yet verify the account against Laravel authentication. Do not use it as a real secure login system.

### 3. Using the Dashboard

The Dashboard is the main screen after entering the application.

Users can view:

- Summary cards for follow-ups and reminders.
- A list of follow-up appointments.
- Recent system activities.
- Navigation options for the other modules.

The displayed information is currently sample data.

### 4. Managing Follow-Ups

1. Open the **Follow-Ups** module from the sidebar.
2. Review the displayed follow-up records.
3. Click the **Add Follow-Up** button to open the form.
4. Enter the required sample appointment information.
5. Submit the form.
6. Review the added record in the list.

The current add-follow-up interface uses local frontend state. It does not yet save the record to MySQL through the Laravel API.

### 5. Viewing Reminders

1. Open the **Reminders** module.
2. Review the available reminder records.
3. Check the displayed reminder statuses.
4. Identify reminders that are pending, delivered, retrying, failed, or require manual review.

The current screen uses sample information. Actual reminder records should be connected to the backend before real use.

### 6. Viewing Activity Logs

1. Open the **Activity Logs** module.
2. Review the displayed activities.
3. Check the activity descriptions and status changes.

The backend has an activity log structure for recording important system events. The current frontend activity list still uses sample data.

### 7. Viewing the Patient Profile

1. Open the **My Profile** module.
2. Review the displayed profile information.
3. Use the sidebar to return to another module.

The current profile screen displays sample information and is not yet connected to a real authenticated patient account.

### 8. Logging Out

1. Open the sidebar.
2. Locate the **Sign Out** option.
3. Click it to return to the login screen.

The current sign-out behavior is a frontend navigation action, not yet a complete Laravel token logout process.

### 9. Testing Automated Reminder Processing

For development and demonstration, the backend supports simulated reminder processing.

1. Make sure MySQL is running.
2. Start the Laravel backend.
3. Start the queue worker:

   ```bash
   php artisan queue:work
   ```

4. Start the scheduler:

   ```bash
   php artisan schedule:work
   ```

5. Create a fictional test follow-up and reminder record using the backend.
6. Dispatch or wait for the reminder job to be processed.
7. Check the reminder status and attempt records in the database.

With the default `success_after_retry` simulation mode:

- The first attempt produces a simulated temporary failure.
- The reminder changes to `retrying`.
- Another attempt is scheduled after one minute.
- The next attempt simulates successful delivery.
- The reminder changes to `delivered`.

For permanent failure testing, the simulation mode can be changed to:

```dotenv
REMINDER_SIMULATION_MODE=permanent_failure
```

After changing the `.env` configuration, run:

```bash
php artisan optimize:clear
```

Restart the queue worker before testing again.

**Reminder:** This is a development simulation. It does not send actual SMS or email notifications.

## Building an Android APK

When Android support is ready for testing, run this command from the Flutter project root:

```bash
flutter build apk --release
```

The generated APK is usually located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Install and test the APK on a compatible Android device before distributing it.

Keep signing keys and production secrets secure. Do not commit them to GitHub.

## GitHub Workflow

Use Git to save changes and synchronize the local project with GitHub.

### Check the Current Status

```bash
git status
```

### Add Changes

```bash
git add .
```

### Commit Changes

```bash
git commit -m "Update clinic follow-up reminder system"
```

### Push Changes to GitHub

```bash
git push origin main
```

### Pull the Latest Changes

```bash
git pull origin main
```

Review your changes before committing. Never commit `.env` files, passwords, API keys, or real patient information.

## Security and Privacy

Because the system may handle sensitive appointment information, privacy and security must be considered throughout development.

- Use authentication and role-based authorization.
- Validate incoming information on the backend.
- Use HTTPS in production.
- Store secrets in protected environment variables.
- Avoid including patient names, diagnoses, passwords, or authentication tokens in reminder messages and application logs.
- Collect only the information required for follow-up management.
- Restrict access to patient records to authorized users.
- Use fictional or approved test data during development.
- Validate uploaded file types and sizes.
- Apply appropriate database backups and access controls.
- Avoid exposing internal system details through error messages.

Example of a privacy-conscious reminder:

> You have an upcoming follow-up appointment. Please sign in to view your schedule.

Do not include sensitive medical details in ordinary reminder messages.

## Testing

Testing should be performed as features are implemented.

Planned testing activities include:

- Login and authentication testing.
- Role-based authorization testing.
- Follow-up schedule creation and updates.
- Appointment confirmation and cancellation.
- Missed and unanswered follow-up handling.
- Reminder delivery and retry behavior.
- Temporary and permanent delivery failure handling.
- Input validation and error handling.
- Database operations and API responses.
- Privacy and access-control checks.
- Flutter and Laravel integration testing.
- Performance and reliability testing.
- Android emulator and physical device testing, when available.

Use controlled test accounts and sample data. Document actual results and unresolved issues rather than reporting tests as passed before they are performed.

## Deployment

The application may be deployed after development, testing, and security checks.

Deployment requirements include:

- A suitable hosting environment for Laravel and PHP.
- A MySQL database.
- A release build of the Flutter application.
- HTTPS for backend communication.
- Secure production environment configuration.
- A correct production API base URL.
- A reliable mechanism for scheduled reminder processing.
- Monitoring for failed reminder attempts.
- Database backup and recovery procedures.

The backend must be hosted on a server reachable by the application. Local development addresses such as `127.0.0.1` and `10.0.2.2` must not be used as production API addresses.

## Documentation and Maintenance

Project documentation should include:

- Installation and setup instructions.
- Database schema and migration information.
- API endpoint documentation.
- Testing procedures and actual results.
- User acceptance testing documentation.
- Deployment instructions.
- Known issues and limitations.
- Backup and recovery procedures.
- Maintenance and troubleshooting instructions.

Update the documentation whenever system features, dependencies, configuration, or deployment procedures change.

## Project Status

**Current Stage: Initial Development and Frontend Prototype**

The Flutter project has been initialized and uploaded to GitHub. The current frontend includes the login interface, dashboard, follow-up screen, reminders screen, activity logs, and patient profile screen.

The Laravel backend has been created with database migrations, API controllers, reminder processing services, queue jobs, and scheduler configuration.

Reminder delivery is currently simulated to demonstrate retry and recovery behavior. The frontend is not yet fully connected to Laravel authentication and live database records.

Further development is needed for secure authentication, role-based authorization, complete frontend-backend integration, actual notification provider integration, testing, and deployment.

This repository serves as the main source code repository for the Mobile Clinic Follow-Up Reminder System.
