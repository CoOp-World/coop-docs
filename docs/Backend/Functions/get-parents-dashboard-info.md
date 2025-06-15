---
layout: default
title: get-parents-dashboard-info
parent: Functions
grand_parent: Backend
nav_order: 23
---

# `get-parents-dashboard-info` Function

## 🔗 Name and URL

- **Function Name:** `get-parents-dashboard-info`
- **Region:** `europe-central2`
- **URL:** `https://get-parents-dashboard-info-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This Cloud Function retrieves information for a user's parent dashboard:

- Queries MongoDB for all game level records for a specific `user_id`.
- Sorts levels first by `level_num`, then by `human_player_score` (descending).
- Extracts and returns a list of unique levels, each with:
  - `index` – the level number
  - `help_requests` – list of help request events during that level
- Also includes:
  - `player_gender`
  - `virtual_gender`

This allows parents or therapists to review player progress and interaction history.

## 📥 Expected Input

This function expects a `GET` request with a query parameter:

```plaintext
val=<user_id>
```

- `val`: The unique identifier of the user whose parent dashboard information is being requested.

## 🔄 How It’s Used in the System

This function is called when a parent interface to view their child's game progress and interaction history. It provides a structured overview of the levels played, help requests, and player choices, enabling parents to monitor engagement and support needs.
The data used in [this](../../Addons/Parents%20Dashboard.html) dashboard is fetched from this function.
