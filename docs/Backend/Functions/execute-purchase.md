---
layout: default
title: execute-purchase
parent: Functions
grand_parent: Backend
nav_order: 14
---

# `execute-purchase` Function

## 🔗 Name and URL

- **Function Name:** `execute-purchase`
- **Region:** `europe-central2`
- **URL:** `https://execute-purchase-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This Cloud Function is triggered via HTTP and is responsible for handling in-game purchases:

- It authenticates the request and extracts the `user_id`, `item_id`, and `price` from the request JSON.
- It checks the user's current balance from MongoDB.
- If the user has enough funds, it deducts the `price` and appends the `item_id` to the user's `owned_items`.
- The updated document is saved back to the MongoDB collection.

It also supports CORS for cross-origin HTTP requests (e.g. from a frontend app).

## 📥 Expected Input

This function expects a `POST` request with a JSON body like the following:

```json
{
  "id": "user_123",
  "item_id": "speed_boost_01",
  "price": 50
}
```

The `id` field represents the user's unique identifier, `item_id` is the identifier of the item being purchased, and `price` is the cost of the item in the game's currency.

## 🔄 How It’s Used in the System

The function is used in the Co-op World game to handle in-game purchases. It processes purchase requests, validates them, and updates the user's inventory or game state accordingly. This function is essential for enabling players to acquire items or benefits within the game through a secure and reliable purchasing mechanism.
