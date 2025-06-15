---
layout: default
title: addlevelrecord
parent: Functions
grand_parent: Backend
nav_order: 2
---

# `addlevelrecord` Function

## 🔗 Name and URL

- **Function Name:** `addlevelrecord`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/addLevelRecord`

## 🛠️ What the Function Is Doing

This function is responsible for adding a new level record (logs during the level) to the database and also update the user's record. It processes incoming requests that contain level data, validates the input, and then stores the record in the appropriate database collection (coop/levels).

## 📥 Expected Input

You need to send a POST request to the function with the following JSON structure in the body including every field mentioned in
[Level Record](../../MongoDB/Collections/coop__levels.html)

## 🔄 How It’s Used in the System

After a user finishes a level, the game client sends a request to this function to add a new level record with the user level information of everything that happened during the level. The function processes the request, validates the data, and stores it in the database.
