---
layout: default
title: execute-wearing
parent: Functions
grand_parent: Backend
nav_order: 16
---

# `execute-wearing` Function

## 🔗 Name and URL

- **Function Name:** `execute-wearing`
- **Region:** `europe-central2`
- **URL:** `https://execute-wearing-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This HTTP Cloud Function equips a user with a virtual item:

- It checks if the user owns the specified `item_id`.
- If the item is owned but not already worn (in `equiped_items`), it adds the item to that list.
- If the item is not owned or already worn, the function returns an error.

The function accesses user data in MongoDB and supports CORS for safe frontend access.

## 📥 Expected Input

This function expects a `POST` request with the following JSON body:

```json
{
  "id": "user_123",
  "item_id": "hat_green"
}
```

The `id` field represents the user's unique identifier, and `item_id` is the identifier of the item to be equipped.

## 🔄 How It’s Used in the System

The function is used in the Co-op World game to handle item wearing requests. It processes requests to equip items from a user's inventory, ensuring that the item is valid and updating the database accordingly. This function is essential for allowing players to wear items and customize their characters within the game.
