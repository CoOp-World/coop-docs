---
layout: default
title: editusers
parent: Functions
grand_parent: Backend
nav_order: 12
---

# `editusers` Function

## 🔗 Name and URL

- **Function Name:** `editusers`
- **Region:** `europe-central2`
- **URL:** `https://editusers-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

The function is responsible for editing existing user accounts in the Co-op World game. It allows administrators to update user information such as master and requests. This function is useful for modifying user accounts after they have been created, ensuring that user data remains accurate and up-to-date.

## 📥 Expected Input

The function expects an HTTP POST request with a JSON payload containing the following fields:

- `users`: An array of user IDs that should be edited. Each ID is a string representing a unique user identifier.

In addition, the function accepts the following optional parameters:

- `master`: A boolean indicating whether the user is a master user (can do levels more than once). Defaults to not changing this field if not specified.
- `req`: A boolean indicating whether the user will get requests through the game. Defaults to not changing this field if not specified.

## 🔄 How It’s Used in the System

The function is used in the user management process of the Co-op World game. It allows administrators to modify existing user accounts, such as changing their master status or request settings. This is particularly useful for maintaining user data integrity and ensuring that user accounts reflect the current state of the game.
