---
layout: default
title: fetchuserinfo
parent: Functions
grand_parent: Backend
nav_order: 22
---

# `fetchuserinfo` Function

## 🔗 Name and URL

- **Function Name:** `fetchuserinfo`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/fetchUserInfo`

## 🛠️ What the Function Is Doing

This Cloud Function retrieves and updates basic metadata for a user based on their `user_id`.

- It looks up the user's document in MongoDB.
- If found, it sets `was_activated` to `"Yes"` and ensures the fields `current_balance`, `owned_items`, and `equiped_items` are initialized if missing.
- The response includes relevant user details such as:
  - `user_id`, `name`, gender fields
  - game-related info (`levels_played`, `high_score`, `current_balance`)
  - experimenter metadata and ownership of virtual items

It supports CORS and can be queried via GET from a browser or frontend app.

## 📥 Expected Input

This function expects a `GET` request with the query parameter:

```plaintext
val=<user_id>
```

- `val`: The unique identifier of the user whose information is being requested.

## 🔄 How It’s Used in the System

This function is called when a user accesses their profile or when the game needs to load user-specific data. It ensures that the user's metadata is up-to-date and provides essential information for gameplay, such as current balance and owned items.

### Example Response

```json
{
  "user_id": "user_123",
  "name": "Liam",
  "human_gender": "male",
  "virtual_gender": "female",
  "levels_played": 7,
  "high_score": 450,
  "registration_time": "2024-12-01T12:00:00Z",
  "was_registered": "Yes",
  "experimenter": "chen",
  "master": false,
  "request_enable": true,
  "randomize": false,
  "current_balance": 100,
  "owned_items": ["hat_blue", "cape_green"],
  "equiped_items": ["hat_blue"]
}
```
