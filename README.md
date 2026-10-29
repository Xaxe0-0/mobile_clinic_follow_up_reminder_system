# Mobile Clinic Follow-Up Reminder System

A privacy-aware clinic follow-up reminder mobile application built with Flutter and Dart for Android, Laravel REST API for the backend, and MySQL for database management. The system aims to help clinics manage follow-up appointments, send timely reminders, track appointment confirmations, and identify missed follow-ups.

## Table of Contents

- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Technology Stack](#technology-stack)
- [Planned Features](#planned-features)
- [System Architecture](#system-architecture)
- [Project Requirements](#project-requirements)
- [Installation and Setup](#installation-and-setup)
- [Running the Project](#running-the-project)
- [GitHub Workflow](#github-workflow)
- [Security and Privacy](#security-and-privacy)
- [Testing](#testing)
- [Deployment](#deployment)
- [Documentation and Maintenance](#documentation-and-maintenance)
- [Project Status](#project-status)

## Project Overview

The Mobile Clinic Follow-Up Reminder System is an Android mobile application designed to help clinics organize follow-up appointments and reduce missed appointments through timely reminders and follow-up tracking.

The system will allow authorized users to manage follow-up schedules, record appointment responses, and identify appointments that need further attention. It will also support retrying temporary reminder delivery failures and flagging unresolved failures for staff review.

The application is intended for clinic follow-up management and is not a replacement for professional medical advice, diagnosis, or treatment.

## Objectives

- Organize and manage clinic follow-up schedules.
- Help patients receive reminders about upcoming follow-ups.
- Track appointment confirmations, cancellations, and missed appointments.
- Reduce missed follow-ups through timely notifications.
- Retry temporary reminder delivery failures.
- Allow authorized clinic staff to review unresolved delivery failures.
- Protect patient information through authentication and access control.
- Maintain clear documentation for testing, deployment, and future maintenance.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Build the Android mobile application |
| Dart | Mobile application programming language |
| Android Studio | Development, debugging, and Android emulator testing |
| Laravel | Backend REST API |
| PHP | Backend programming language |
| MySQL | Database management |
| Git and GitHub | Version control and source code hosting |
| HTTPS | Secure communication in deployment |

Additional tools and services for email or push notifications, automated scheduling, and deployment may be selected as development progresses.

## Planned Features

### 1. User Authentication and Authorization

- Secure login and logout.
- Role-based access for patients and authorized clinic staff.
- Server-side authorization checks.
- Secure password recovery.

### 2. Follow-Up Appointment Management

- Create and manage follow-up schedules.
- View upcoming and previous follow-ups.
- Update appointment information when authorized.
- Record appointment status, including confirmed, cancelled, completed, missed, and awaiting response.

### 3. Reminder Management

- Send reminders for upcoming follow-ups.
- Use clear messages that avoid exposing sensitive medical information.
- Track reminder delivery and response status.
- Retry temporary delivery failures.
- Flag permanent or repeated failures for manual review.

### 4. Appointment Response Tracking

- Record patient confirmations and cancellations.
- Identify patients who have not responded.
- Identify missed follow-ups.
- Allow authorized staff to review cases that require further action.

### 5. Privacy and Audit Support

- Validate input on the server.
- Limit access to authorized users.
- Avoid storing unnecessary patient information.
- Keep logs free of passwords, authentication tokens, and sensitive medical details.
- Record important system actions where appropriate.

**Note:** These are planned features. Their availability will depend on the current implementation and testing results.

## System Architecture

The application will use a client-server architecture.

1. **Flutter Android app:** Displays the mobile interface and sends requests to the backend.
2. **Laravel REST API:** Validates requests, checks authorization, applies business rules, and processes follow-up records.
3. **MySQL:** Stores the application's required user, appointment, and reminder information.
4. **Reminder service:** Handles reminder scheduling, delivery attempts, retries, and failure reporting through a suitable notification provider.

The Flutter mobile app should communicate with the database through the Laravel API rather than connecting directly to MySQL.

## Project Requirements

Install the following tools before starting development:

- Flutter SDK
- Dart SDK, included with Flutter
- Android Studio
- Android SDK and an Android emulator, or a physical Android device
- PHP version compatible with the selected Laravel release
- Composer
- MySQL Server
- Node.js and npm, if needed for Laravel frontend assets
- Git
- Visual Studio Code or another code editor

A physical Android phone can be used for testing if USB debugging is enabled and the device is authorized. Visual Studio with the required C++ tools is only necessary if building the Flutter application for Windows desktop; it is not required for Android builds.

## Installation and Setup

### 1. Clone the Repository

Open a terminal and run:

```bash
git clone https://github.com/Xaxe0-0/mobile_clinic_follow_up_reminder_system.git
cd mobile_clinic_follow_up_reminder_system
```

### 2. Set Up the Flutter Mobile App

Install the Flutter dependencies:

```bash
flutter pub get
```

Check the Flutter installation and Android setup:

```bash
flutter doctor
```

Check for available Android devices or emulators:

```bash
flutter devices
```

Start an Android emulator from Android Studio's Device Manager, or connect an Android phone with USB debugging enabled.

### 3. Set Up the Laravel Backend

The Laravel backend should be maintained in a separate folder, such as `backend`, unless the project structure is changed later.

If the backend has not been created yet, make sure Composer and a compatible PHP version are installed. From the project root, create it with:

```bash
composer create-project laravel/laravel backend
```

Enter the backend folder:

```bash
cd backend
```

Install any required dependencies:

```bash
composer install
```

Create the local environment file if it does not exist.

On Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

On macOS or Linux:

```bash
cp .env.example .env
```

Generate the Laravel application key:

```bash
php artisan key:generate
```

Configure the database and other environment settings in the backend's `.env` file.

**Important:** Do not commit real credentials, API keys, passwords, or production environment files to GitHub.

### 4. Configure the MySQL Database

Create a database in MySQL:

```sql
CREATE DATABASE clinic_follow_up_reminder_system;
```

Update the Laravel backend's `.env` file with the appropriate local database settings:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=clinic_follow_up_reminder_system
DB_USERNAME=your_mysql_username
DB_PASSWORD=your_mysql_password
```

Replace the example username and password with your own local MySQL credentials. Keep these values private.

After creating the Laravel migrations, run:

```bash
php artisan migrate
```

### 5. Run the Laravel Backend

From the backend folder:

```bash
php artisan serve
```

Laravel will display the local development address, commonly:

```text
http://127.0.0.1:8000
```

The Flutter app needs the correct API base URL to communicate with the backend.

**Android emulator note:** When using the standard Android Studio emulator, `127.0.0.1` refers to the emulator itself. To access a backend running on the development computer, use `http://10.0.2.2:8000/api` for local emulator testing. For a physical phone, use the computer's reachable local network IP address and ensure the phone and computer can communicate. These local HTTP addresses are for development only; use HTTPS in production.

### 6. Connect Flutter to Laravel

Configure the Flutter application to use the Laravel API's base URL. The exact URL depends on whether the app is running on an Android emulator, a physical phone, or a production server.

For the standard Android Studio emulator, the local API base URL may be:

```text
http://10.0.2.2:8000/api
```

Make sure the corresponding Laravel API routes exist, CORS is configured where applicable, and authentication is implemented securely. Use HTTPS in production.

## Running the Project

For local development, use two terminals.

**Terminal 1 — Flutter mobile app**

From the project root:

```bash
flutter pub get
flutter devices
flutter run
```

Select the Android emulator or connected device if prompted.

**Terminal 2 — Laravel backend**

From the backend folder:

```bash
php artisan serve
```

Make sure MySQL is running and the Laravel database settings are correct before testing API requests.

## Building an Android APK

When you are ready to create an Android APK for testing, run this from the Flutter project root:

```bash
flutter build apk --release
```

The generated APK is usually located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Build and test the app before distributing it. Store signing keys and production secrets securely; do not commit them to GitHub.

## GitHub Workflow

Use Git to save changes and synchronize your local project with GitHub.

### Check the current status

```bash
git status
```

### Add changes

```bash
git add .
```

### Commit changes

```bash
git commit -m "Describe your changes"
```

### Push changes to GitHub

```bash
git push
```

### Pull the latest changes

```bash
git pull
```

Write meaningful commit messages, and review changes before committing. Never commit `.env` files or other sensitive configuration.

If you work with other developers, coordinate changes and resolve merge conflicts before pushing.

## Security and Privacy

Because this project may handle sensitive appointment information, privacy and security must be considered throughout development.

- Use authentication and role-based authorization.
- Validate and sanitize incoming data on the backend.
- Use HTTPS in production.
- Store secrets in protected environment variables.
- Avoid including patient names, diagnoses, passwords, or tokens in reminder messages and application logs.
- Collect only the information required for follow-up management.
- Restrict access to patient records to authorized users.
- Use controlled test data during development.
- Protect uploaded files and validate their type and size when uploads are supported.
- Apply appropriate database backups and access controls.
- Review error handling to avoid exposing internal system details.

A reminder should use privacy-conscious wording, such as:

> You have an upcoming follow-up appointment. Please sign in to view your schedule.

Do not include sensitive medical details in ordinary notification messages.

## Testing

Testing should be performed as features are implemented.

Planned testing activities include:

- Authentication and authorization testing.
- Follow-up schedule creation and updates.
- Appointment confirmation and cancellation.
- Missed and unanswered follow-up handling.
- Reminder delivery and retry behavior.
- Handling temporary and permanent delivery failures.
- Input validation and error handling.
- Database operations and API responses.
- Privacy and access-control checks.
- Flutter app and Laravel backend integration testing.
- Performance testing under expected and peak workloads.
- Testing on an Android emulator and, where possible, a physical Android device.

Use controlled test accounts and sample data. Document actual results and unresolved issues rather than reporting tests as passed before they are performed.

## Deployment

The application may be deployed after development, testing, and security checks.

Deployment requirements include:

- A suitable hosting environment for Laravel and PHP.
- A MySQL database.
- A release build of the Flutter Android application.
- HTTPS for communication with the backend.
- Secure production environment configuration.
- Correct API base URL and server configuration.
- A reliable mechanism for scheduled reminders.
- Monitoring for failed reminder attempts.
- Database backup and recovery procedures.

The backend must be hosted on a server reachable by the mobile app. A local development address such as `127.0.0.1` or `10.0.2.2` should not be used as the production API URL. Deployment steps will depend on the hosting provider selected for the project.

## Documentation and Maintenance

The project documentation should include:

- Installation and setup instructions.
- Database schema and migration information.
- API endpoint documentation, preferably using OpenAPI.
- Testing procedures and results.
- User acceptance testing documentation.
- Deployment instructions.
- Known issues and limitations.
- Backup and recovery procedures.
- Maintenance and troubleshooting instructions.

Keep the documentation updated when system features, dependencies, configuration, or deployment procedures change.

## Project Status

**Current stage:** Initial project setup.

The Flutter project has been initialized and uploaded to GitHub. The target platform is Android mobile. Backend development, database integration, reminder functionality, testing, and deployment should be documented as they are completed.

This repository will serve as the main source code repository for the Mobile Clinic Follow-Up Reminder System.
