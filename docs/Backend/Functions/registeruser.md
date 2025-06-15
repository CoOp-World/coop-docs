---
layout: default
title: registeruser
parent: Functions
grand_parent: Backend
nav_order: 39
---

# `registeruser` Function

## 🔗 Name and URL

- **Function Name:** `registeruser`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/registerUser`

## 🛠️ What the Function Is Doing

This function handles user registration for the Co-Op World game. Specifically, it updates a user's MongoDB document with registration data such as gender choices and registration timestamp. It also supports CORS preflight (`OPTIONS`) requests and logs any errors to a Pub/Sub topic for retry logic or monitoring.

If MongoDB is not reachable or the request body is malformed, the function logs the failed request to a Pub/Sub queue for future reprocessing using a designated `post-retry-worker`.

## 📥 Expected Input

### Method

- `POST`

### Headers

- `Content-Type: application/json`

### JSON Body

| Field               | Required | Type   | Description                                                  |
| ------------------- | -------- | ------ | ------------------------------------------------------------ |
| `user_id`           | ✅       | string | The user's game ID (used to look up the document in MongoDB) |
| `human_gender`      | ✅       | string | The gender of the human player                               |
| `virtual_gender`    | ✅       | string | The selected virtual agent gender                            |
| `registration_time` | ✅       | string | Timestamp of when the registration occurred                  |

## 🔄 How It’s Used in the System

This function is called from the game after a user chooses the gender of the character they want to play with. It registers the user in the MongoDB database, allowing them to participate in the game and be tracked throughout the study. The function ensures that all necessary user information is captured and stored correctly, enabling further interactions and data collection as the user engages with the game.
