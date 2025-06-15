---
layout: default
title: resetuser
parent: Functions
grand_parent: Backend
nav_order: 40
---

# `resetuser` Function

## 🔗 Name and URL

- **Function Name:** `resetuser`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/resetUser`

## 🛠️ What the Function Is Doing

This function resets a user's registration and gameplay progress in the Co-Op World game. It locates the user by their `user_id` in the MongoDB database and sets the following fields to their default states:

- `levels_played`: reset to 0
- `high_score`: reset to 0
- `human_gender` and `virtual_gender`: cleared (set to `None`)
- `registration_time`: cleared
- `was_activated`: set to `"No"`
- `was_registered`: set to `"No"`

If the user is not found, it returns a 404 response with `status: "Unidentified"`. Errors are logged and pushed to Pub/Sub for retry handling.

## 📥 Expected Input

### Method

- `POST`

### Query Parameters

| Parameter | Required | Description            |
| --------- | -------- | ---------------------- |
| `val`     | ✅       | The `user_id` to reset |

### Headers

- `Content-Type: application/json`

## 🔄 How It’s Used in the System

This function is used to reset a user's progress in the Co-Op World game, allowing them to start over. It is particularly useful for participants who may want to re-engage with the game from the beginning or for testing purposes. By resetting the user's data, the function ensures that they can experience the game afresh without any previous progress affecting their new gameplay experience.
