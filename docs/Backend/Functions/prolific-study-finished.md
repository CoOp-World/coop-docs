---
layout: default
title: prolific-study-finished
parent: Functions
grand_parent: Backend
nav_order: 33
---

# `prolific-study-finished` Function

## 🔗 Name and URL

- **Function Name:** `prolific-study-finished`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific_study_finished`

## 🛠️ What the Function Is Doing

This function is triggered when a participant completes a Prolific-based study and submits their feedback.

- It verifies the request includes a `user_id`.
- Fetches the associated user document from MongoDB.
- If the user is valid and not already marked as `COMPLETED` or `BLOCKED`, it updates their status to `COMPLETED` and stores the feedback fields.
- If the user is already marked as completed or blocked, it responds with an appropriate redirect.
- On success, it returns a redirect link to the Prolific study completion page.

## 📥 Expected Input

### Request Method

- `POST`

### JSON Body Parameters

| Parameter               | Required | Description                                |
| ----------------------- | -------- | ------------------------------------------ |
| `user_id`               | ✅       | Unique identifier for the participant      |
| `feedback_time`         | ✅       | Timestamp of when feedback was submitted   |
| `Q_general_opinion`     | ❌       | Open feedback about the game or experience |
| `Q_bugs`                | ❌       | Reported bugs                              |
| `Q_suggestions`         | ❌       | Suggestions for improvement                |
| `Q_additional_comments` | ❌       | Any additional participant comments        |

### Example

```json
{
  "user_id": "1234abcd",
  "feedback_time": "2025-06-08T14:00:00Z",
  "Q_general_opinion": "Great game!",
  "Q_bugs": "None found",
  "Q_suggestions": "Add more levels",
  "Q_additional_comments": "Thanks for the opportunity"
}
```

## 🔄 How It’s Used in the System

This function is used to finalize a participant's involvement in the Prolific study by marking them as `COMPLETED` in the database and collecting their feedback. It ensures that all necessary data is captured for analysis and that participants are properly acknowledged for their contributions. The function also handles cases where users may have already completed the study or been blocked, providing appropriate responses to maintain data integrity and user experience.
