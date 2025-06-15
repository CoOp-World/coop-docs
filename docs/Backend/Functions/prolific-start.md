---
layout: default
title: prolific-start
parent: Functions
grand_parent: Backend
nav_order: 32
---

# `prolific-start` Function

## 🔗 Name and URL

- **Function Name:** `prolific-start`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific-start`

## 🛠️ What the Function Is Doing

This function is used to **register a new participant** (from Prolific) into the database. It performs the following actions:

- Parses a JSON POST request containing the participant's Prolific identifiers.
- Checks if a user with the given `prolific_pid` already exists.
- If not, creates a new document in MongoDB with the user's information and an initial status of `"AWAITING_COMPLETION"`.
- Returns the newly created document's MongoDB `_id`.

## 📥 Expected Input

### Request Method

- `POST`

### JSON Body Parameters

| Parameter      | Required | Description                    |
| -------------- | -------- | ------------------------------ |
| `prolific_pid` | ✅       | Unique Prolific participant ID |
| `study_id`     | ❌       | Prolific study ID              |
| `session_id`   | ❌       | Prolific session ID            |

### Example

```json
{
  "prolific_pid": "1234abcd",
  "study_id": "5678efgh",
  "session_id": "9012ijkl"
}
```

## 🔄 How It’s Used in the System

This function is used to register new participants in the Prolific study for the _Co-Op World_ game. It ensures that each participant has a unique identifier in the database, allowing for tracking and management of user data throughout the study. The function is essential for onboarding new users and preparing them for gameplay, ensuring that their progress can be monitored and analyzed effectively.
