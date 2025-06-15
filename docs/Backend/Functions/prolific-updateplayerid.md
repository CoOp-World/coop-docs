---
layout: default
title: prolific-updateplayerid
parent: Functions
grand_parent: Backend
nav_order: 36
---

# `prolific-updateplayerid` Function

## 🔗 Name and URL

- **Function Name:** `prolific-updateplayerid`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific-updatePlayerID`

## 🛠️ What the Function Is Doing

This function updates the `user_id` field of a participant document in MongoDB based on their `_id`. It is typically used to set or associate the internal player ID after a participant has been created through Prolific.

## 📥 Expected Input

### Request Method

- `PUT`

### Query Parameters

| Parameter | Required | Description                                               |
| --------- | -------- | --------------------------------------------------------- |
| `user_id` | ✅       | The MongoDB `_id` of the document to update (as a string) |

### JSON Body Parameters

| Parameter   | Required | Description                          |
| ----------- | -------- | ------------------------------------ |
| `player_id` | ✅       | The player ID to assign to `user_id` |

## 🔄 How It’s Used in the System

This function is used to update the `user_id` field in the participant's document in MongoDB. It is essential for linking the Prolific participant with their internal player ID, which is used throughout the game and study. This ensures that all actions and data associated with the participant can be accurately tracked and managed within the system.
