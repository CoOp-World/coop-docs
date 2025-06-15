---
layout: default
title: createusers
parent: Functions
grand_parent: Backend
nav_order: 10
---

# `createusers` Function

## 🔗 Name and URL

- **Function Name:** `createusers`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/createUsers`

## 🛠️ What the Function Is Doing

The function is responsible for creating new users in the Co-op World game. It takes a structured order of sessions and levels, which was previously defined using the `create-sessions-order` function, and uses this structure to initialize user accounts with specific game progressions or use the default progression if no specific order is provided.

## 📥 Expected Input

The function expects an HTTP POST request with a JSON payload containing the following fields:

- `levels`: An array of session levels in the order they should be created. Each level is represented by an object with the following properties:
  - `level_num`: The level number (e.g., 0, 1, 2, etc.).
  - `sessions`: The sessions the level contains, represented as an array of session objects. Each session object should have the following properties:
    - `session_num`: The session number (e.g., 1, 2, etc.).
    - `index_in_session`: The index of the session within the level (e.g., 1, 2, etc.).

The function also accepts parameters for the users to be created:

- `language`: The language preference for the user (e.g., "Hebrew", "Arabic", etc.) by default it is set to "Hebrew".
- `grade`: The grade class of the user (e.g., "1", "2", etc.) by default it is set to "N/A".
- `num`: The number of users to create. If not specified, it defaults to 50.
- `master`: A boolean indicating whether the user is a master user (can do levels more than once). Defaults to `false`.
- `req`: A boolean indicating whether the user will get requests through the game. Defaults to `true`.
- `randomize`: A boolean indicating whether the user should have a randomized order of the virual players meeting in the intro (Felix experiment). Defaults to `false`.

## 🔄 How It’s Used in the System

The function is used in the user management process of the Co-op World game. It allows administrators to create multiple user accounts with predefined game progressions or default settings. This is particularly useful for setting up new users in bulk, such as during initial game setup or when onboarding new players.

## Expected Output

The function returns a JSON response containing the following fields:

- `status`: A string indicating the status of the operation (e.g., "success" or "error").
- `users`: An array of user ids that were created.
