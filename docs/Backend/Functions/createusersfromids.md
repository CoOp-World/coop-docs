---
layout: default
title: createusersfromids
parent: Functions
grand_parent: Backend
nav_order: 11
---

# `createusersfromids` Function

## 🔗 Name and URL

- **Function Name:** `createusersfromids`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/createUsersFromIDs`

## 🛠️ What the Function Is Doing

The function is responsible for creating new users in the Co-op World game based on a list of user IDs. It initializes user accounts with specific game progressions or uses the default progression if no specific order is provided. This function is particularly useful for creating users in bulk from a predefined list of IDs.

## 📥 Expected Input

The function expects an HTTP POST request with a JSON payload containing the following fields:

- `user_ids`: An array of user IDs that should be created. Each ID is a string representing a unique user identifier.

## 🔄 How It’s Used in the System

**This function is not currently used in the system.** It is designed to facilitate the creation of user accounts based on a predefined list of IDs, which can be useful for testing or bulk user creation scenarios.
