---
layout: default
title: prolific-welcome-page-started
parent: Functions
grand_parent: Backend
nav_order: 38
---

# `prolific-welcome-page-started` Function

## 🔗 Name and URL

- **Function Name:** `prolific-welcome-page-started`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific_welcome_page_started`

## 🛠️ What the Function Is Doing

This function is used at the beginning of the Prolific onboarding process to either:

1. Retrieve an existing user document for a given session (if already started),
2. Or create a new user in the game database via a call to `createUsers` and store their Prolific metadata in a new document in MongoDB.

It handles returning the proper redirect path based on the user's current status (e.g., AWAITING_COMPLETION, COMPLETED, etc.).

## 📥 Expected Input

### Request Method

- `POST`

### Headers

- `Content-Type: application/json`

### JSON Body

| Field          | Required | Description                                                    |
| -------------- | -------- | -------------------------------------------------------------- |
| `PROLIFIC_PID` | ✅       | The participant’s Prolific PID                                 |
| `STUDY_ID`     | ✅       | The ID of the study from Prolific                              |
| `SESSION_ID`   | ✅       | The session ID from Prolific (used to identify repeat entries) |

## 🔄 How It’s Used in the System

This function is used to manage the initial state of a participant in the Prolific study. It ensures that each participant has a unique entry in the database, allowing for tracking of their progress and status throughout the study. The function is crucial for setting up the participant's session and determining their next steps based on their current status, such as whether they need to complete the game or if they have already finished it.
