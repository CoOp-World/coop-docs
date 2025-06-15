---
layout: default
title: create-sessions-order
parent: Functions
grand_parent: Backend
nav_order: 9
---

# `create-sessions-order` Function

## 🔗 Name and URL

- **Function Name:** `create-sessions-order`
- **Region:** `europe-central2`
- **URL:** `https://create-sessions-order-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This function is responsible for creating a new order of sessions and levels in the Co-op World game. It allows users to define the structure of levels and sessions, which can then be used for user creation and game progression.

## 📥 Expected Input

The function expects an HTTP POST request with a JSON payload containing the following fields:

- `levels`: An array of session levels in the order they should be created. Each level is represented by an object with the following properties:
  - `level_num`: The level number (e.g., 0, 1, 2, etc.).
  - `sessions`: The sessions the level contains, represented as an array of session objects. Each session object should have the following properties:
    - `session_num`: The session number (e.g., 1, 2, etc.).
    - `index_in_session`: The index of the session within the level (e.g., 1, 2, etc.).
- `name`: The name of the the order of sessions and levels for future use in the user creation.

## 🔄 How It’s Used in the System

The function is used to create a structured order of sessions and levels in the Co-op World game. This order can be utilized for user creation, allowing players to progress through the game in a defined manner. The function is typically called by administrators or developers who manage the game's content and structure in the user management interface.

## Example Request

```json
{
  "levels": [
    {
      "level_num": 0,
      "sessions": [
        {
          "session_num": 1,
          "index_in_session": 1
        },
        {
          "session_num": 1,
          "index_in_session": 2
        }
      ]
    },
    {
      "level_num": 1,
      "sessions": [
        {
          "session_num": 2,
          "index_in_session": 1
        }
      ]
    }
  ],
  "name": "Example Order"
}
```
