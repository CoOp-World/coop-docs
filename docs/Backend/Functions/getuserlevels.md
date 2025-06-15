---
layout: default
title: getuserlevels
parent: Functions
grand_parent: Backend
nav_order: 26
---

# `getuserlevels` Function

## 🔗 Name and URL

- **Function Name:** `getuserlevels`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/getuserlevels`

## 🛠️ What the Function Is Doing

This function dynamically assembles and returns the full list of game levels that are associated with a specific user.

- Connects to the MongoDB collections for both levels and users.
- For a given `user_id`, the function:
  - Retrieves the user document.
  - If no levels are assigned, returns a default linear set of 7 levels.
  - If custom levels are defined:
    - Iterates through each level and its sessions.
    - Builds a response containing the session number, index in session, and level config.
- Ensures `tasks` field is populated and applies `level_strategy` if defined.
- Automatically updates the `current_session` field in the user’s document if needed.
- Sorts the levels by session and index.

## 📥 Expected Input

This function expects a `GET` request with a query parameter:

```plaintext
val=<user_id>
```

- `val`: The unique identifier of the user whose levels are being requested.

## 🔄 How It’s Used in the System

This function is called when a user connects to the game and needs to retrieve their assigned levels. It provides the necessary data to display the user's level progression and achievements, allowing them to see their performance across different levels.
It is essential for the game interface to dynamically load the correct levels and sessions based on user-specific configurations, ensuring a personalized gaming experience.
