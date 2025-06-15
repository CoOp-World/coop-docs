---
layout: default
title: prolific-gamecompletionstatus
parent: Functions
grand_parent: Backend
nav_order: 31
---

# `prolific-gamecompletionstatus` Function

## 🔗 Name and URL

- **Function Name:** `prolific-gamecompletionstatus`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific-gameCompletionStatus`

## 🛠️ What the Function Is Doing

This function is used to **query or update the game completion status** for a user in the MongoDB collection.

- When called with `action=get`, it retrieves the user's current game status from the database.
- When called with `action=set`, it sets the user’s status to `"COMPLETED"` in the database.
- It ensures CORS compliance and validates both the `user_id` and `action` parameters.
- It supports both `GET` and `PUT` methods, and handles CORS `OPTIONS` preflight requests.

## 📥 Expected Input

### Request Method

- `GET` or `PUT`

### Query Parameters

| Parameter | Required | Description                                                                    |
| --------- | -------- | ------------------------------------------------------------------------------ |
| `user_id` | ✅       | The MongoDB ObjectId of the user (string format).                              |
| `action`  | ✅       | `"get"` to fetch current status, or `"set"` to update status to `"COMPLETED"`. |

## 🔄 How It’s Used in the System

This function is used in the Prolific study to manage the game completion status of participants. It allows the system to check if a user has completed the game and update their status accordingly. This is crucial for ensuring that only users who have finished the game are marked as `"COMPLETED"` in the database, which helps in tracking participation and managing user flow in the study.
