---
layout: default
title: prolific-first-page-finished
parent: Functions
grand_parent: Backend
nav_order: 30
---

# `prolific-first-page-finished` Function

## 🔗 Name and URL

- **Function Name:** `prolific-first-page-finished`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific_first_page_finished`

## 🛠️ What the Function Is Doing

This function is responsible for handling the logic after a Prolific user completes the first part of the game. It:

- Verifies a provided completion code against the expected one.
- Tracks the number of invalid attempts.
- Updates the user’s status to `AWAITING_FEEDBACK`, `BLOCKED`, or maintains the current status based on verification outcome.
- Saves the total play duration in the database if the code is valid.
- Redirects the user to the appropriate page (`feedback`, `completed`, or `error`) based on their status.

## 📥 Expected Input

The function expects a `POST` request with a JSON body structured as:

```json
{
  "user_id": "string", // Required: the user’s unique identifier
  "completion_code": "integer", // Required: code to verify the completion of the first page
  "duration": 123 // Optional: time in seconds the user spent playing
}
```

- `user_id`: The unique identifier of the user.
- `completion_code`: The code that the user must provide to verify they have completed the first page.
- `duration`: The total time spent by the user on the first page (optional).

## 🔄 How It’s Used in the System

This function is invoked when a Prolific user completes the first part of the game in the Prolific interface [here](https://prolific-survey-791222378113.europe-central2.run.app). It ensures that the user has successfully finished the required tasks and updates their status accordingly. The function also handles invalid attempts and redirects users to the appropriate next step, ensuring a smooth user experience in the Prolific study flow.
