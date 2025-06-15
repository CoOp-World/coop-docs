---
layout: default
title: execute-removal
parent: Functions
grand_parent: Backend
nav_order: 15
---

# `execute-removal` Function

## 🔗 Name and URL

- **Function Name:** `execute-removal`
- **Region:** `europe-central2`
- **URL:** `https://execute-removal-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This HTTP Cloud Function is responsible for removing an item from a user's `equiped_items` list in MongoDB.

- It reads the `user_id` and `item_id` from the request.
- It validates that the item is currently equipped by the user.
- If valid, it removes the item from `equiped_items` and updates the document in the database.

CORS is enabled for compatibility with web clients.

## 📥 Expected Input

This function expects a `POST` request with the following JSON body:

```json
{
  "id": "user_123",
  "item_id": "hat_green"
}
```

The `id` field represents the user's unique identifier, and `item_id` is the identifier of the item to be removed from the user's equipped items.

## 🔄 How It’s Used in the System

The function is used in the Co-op World game to handle item removal requests. It processes requests to remove items from a user's inventory or game state, ensuring that the removal is valid and updating the database accordingly. This function is essential for maintaining the integrity of the game's inventory system and allowing players to manage their owned items effectively.
