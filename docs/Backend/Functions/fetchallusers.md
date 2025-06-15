---
layout: default
title: fetchallusers
parent: Functions
grand_parent: Backend
nav_order: 19
---

# `fetchallusers` Function

## 🔗 Name and URL

- **Function Name:** `fetchallusers`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/fetchAllUsers`

## 🛠️ What the Function Is Doing

This Cloud Function retrieves user data from MongoDB with optional filtering:

- It supports filtering by `experimenters` (list of experimenter names).
- It filters out users who haven't played any levels unless `filter_non_played` is explicitly set to `false`.
- It returns user metadata including `user_id`, `levels_played`, `experimenter`, and `grade`.

CORS headers are applied to support frontend web clients.

## 📥 Expected Input

This function accepts a `POST` request with an optional JSON body:

```json
{
  "experimenters": ["Jax", "Briar"],
  "filter_non_played": true
}
```

- `experimenters`: An array of experimenter names to filter users by.
- `filter_non_played`: A boolean flag to include users who haven't played any levels. Defaults to `true`.

## 🔄 How It’s Used in the System

This function is used to fetch user data for the admin panel. It allows administrators to view all users, filter by experimenters, and decide whether to include users who haven't played any levels. **It currently not used in the frontend**, but it can be integrated into the admin panel to manage and analyze user data effectively.
