---
layout: default
title: adduserrecord
parent: Functions
grand_parent: Backend
nav_order: 4
---

# `adduserrecord` Function

## 🔗 Name and URL

- **Function Name:** `adduserrecord`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/addUserRecord`

## 🛠️ What the Function Is Doing

This function is responsible for adding a new user record to the database. It processes incoming requests that contain user information, validates the input, and then creates a new record in the `coop/users` collection.

**THIS FUNCTION IS NOT IN USE WE MOVED TO USING THE `createusers` FUNCTION INSTEAD**

## 📥 Expected Input

You need to send a POST request to the function with the following JSON structure in the body:

```json
{
  "userId": "string",
  "username": "string",
  "email": "string",
  "createdAt": "timestamp"
}
```

This structure includes fields for the user's ID, username, email, and the timestamp of when the user was created. Ensure that all fields are provided as specified.

## 🔄 How It’s Used in the System

**As I mentioned above this function is not in use anymore, we moved to using the `createusers` function instead**
