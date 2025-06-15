---
layout: default
title: getlevelsinfo
parent: Functions
grand_parent: Backend
nav_order: 25
---

# `getlevelsinfo` Function

## 🔗 Name and URL

- **Function Name:** `getlevelsinfo`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/getlevelsinfo`

## 🛠️ What the Function Is Doing

This Cloud Function retrieves and organizes the level progression information for a specific user based on game history stored in MongoDB in [this](../../MongoDB/Collections/coop__levels.html) collection.

- It pulls all level documents from MongoDB for the specified `user_id`.
- Levels are sorted by:
  - `level_num` (ascending)
  - `human_player_score` (descending) as a tiebreaker
- Each level is represented with:
  - `index`: the level number (0-based)
  - `isLock`: always set to `False`
  - `record`: the user's highest score for that level
  - `stars`: number of stars earned on that level
- An extra “next” level is appended to allow frontends to pre-unlock or prompt for the next play session.

## 📥 Expected Input

This function expects a `GET` request with the following query parameter:

```plaintext
val=<user_id>
```

- `val`: The unique identifier of the user whose level information is being requested.

## 🔄 How It’s Used in the System

This function is used to fetch the level progression data for a user, which is essential for displaying their game history and current status in the user interface. It provides a structured overview of levels played, scores achieved, and stars earned, enabling users to track their progress and plan future gameplay sessions.
This fumction is called in the game when a user connects to the game and see the level select display. It provides the necessary data to display the user's level progression and achievements, allowing them to see their performance across different levels.
