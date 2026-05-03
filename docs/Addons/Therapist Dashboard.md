---
layout: default
title: Therapist Dashboard
nav_order: 4
parent: Addons
---

# CO-OP Therapist Interface

The CO-OP Therapist Interface repository contains the therapist dashboard used to monitor all users in a study, review statistics, and manage patient strategy data.

It is the operational interface for therapists and researchers who need a quick overview of participant progress, activity, and study-level metrics.

The attached screenshot shows the main dashboard layout: a patient list, search, and sidebar navigation for patients, statistics, strategies, and settings.

## System Overview

This application is built as a full-stack dashboard:

- **Backend**: Node.js + Express.js + MongoDB (Mongoose)
- **Frontend**: React + Vite + Tailwind CSS + Radix UI
- **Authentication**: JWT tokens
- **State Management**: React Query (TanStack Query)
- **Deployment**: Google Cloud Run containers

## What It Does

- Displays all users in a study.
- Shows statistics and progress summaries.
- Lets therapists review strategies and patient-level configuration.
- Provides a login-protected dashboard for study monitoring.

## Main Screens

- **Patients**: Main landing page with searchable patient cards and progress summaries.
- **Statistics**: Global analytics for study-level metrics and strategy comparisons.
- **Strategies**: Strategy configuration and review for each patient and level.
- **Settings**: Dashboard and application settings.

## How It Works

The dashboard loads participant data for the current study and presents it in a therapist-friendly interface. It helps the research team track completion, compare users, and inspect study statistics without opening the underlying data sources directly.

The flow is roughly:

1. The therapist logs in through the protected `/login` route.
2. The frontend stores the JWT token and the therapist ID in local storage.
3. The dashboard fetches patient records from the backend.
4. For each patient, the UI combines backend data with external game APIs to calculate progress and level completion.
5. The dashboard renders the cards, charts, and patient details used during the study.

## Access Information

- **Dashboard URL**: [Dashboard Link](https://co-op-therapist-interface-791222378113.europe-central2.run.app/login){:target="_blank"}
- **Repository**: [CO-OP-therapist-interface](https://github.com/CoOp-World/CO-OP-therapist-interface){:target="_blank"}

## Key Components

- **Patient Management**: Add, edit, and track patients.
- **Strategy Configuration**: Multiple behavioral strategies for virtual players.
- **Progress Tracking**: Monitor completed levels and game statistics.
- **Global Analytics**: Aggregate statistics across all patients.
- **Level Management**: Configure strategies per game level.
- **Sidebar Navigation**: Patients, statistics, strategies, and settings.

## Architecture Notes

### Backend

The backend is organized with Express routes and MongoDB models.

- `GET /api/patients` lists patients for the therapist.
- `POST /api/patients` creates a new patient.
- `PATCH /api/patients/:id` updates patient information.
- `DELETE /api/patients/:id` removes a patient.
- `GET /api/game/:patientId` provides game data for external systems.

The server uses CORS restrictions so only the expected dashboard and game client origins can call it.

### Frontend

The React app handles authentication and route protection.

- The `/login` route redirects authenticated users to the dashboard.
- The main dashboard route is protected so unauthenticated users cannot open it.
- API calls use a shared service layer with JWT attached to each request.

### External Integrations

The dashboard pulls data from the main game ecosystem, including:

- the co-op client APIs for level and game data,
- the parent dashboard API for response and completion summaries,
- local patient and strategy records for therapist review.

## Security

- JWT-based login protection for dashboard routes.
- Protected API requests through the shared axios service.
- CORS checks that allow only trusted origins.
- Session cleanup on logout.

## Development Notes

- The dashboard is containerized for Cloud Run deployment.
- Environment variables should be managed through production secrets, not committed files.
- The interface is designed for therapists and researchers rather than general players.
