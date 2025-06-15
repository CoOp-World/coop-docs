---
layout: default
title: addlevelstart
parent: Functions
grand_parent: Backend
nav_order: 3
---

# `addlevelstart` Function

## 🔗 Name and URL

- **Function Name:** `addlevelstart`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/addLevelStart`

## 🛠️ What the Function Is Doing

This function is responsible for recording the start of a level in the game. It processes incoming requests that contain information about the level start event, validates the input, and then updates the user's game record in the database.

## 📥 Expected Input

You need to send a POST request to the function with the following JSON structure in the body including every field mentioned in
[Level Start Record](../../MongoDB/Collections/coop__levels_start.html)

## 🔄 How It’s Used in the System

When a user starts a level, the game client sends a request to this function to log the start of the level. The function processes the request, validates the data, and updates the user's game record in the database, ensuring that the level start event is recorded accurately.
