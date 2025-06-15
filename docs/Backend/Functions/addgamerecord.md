---
layout: default
title: addgamerecord
parent: Functions
grand_parent: Backend
nav_order: 1
---

# `addgamerecord` Function

## 🔗 Name and URL

- **Function Name:** `addgamerecord`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/addGameRecord`

## 🛠️ What the Function Is Doing

This function is responsible for adding a new game record to the database. It processes incoming requests that contain game data, validates the input, and then stores the record in the appropriate database collection (coop/games).

## 📥 Expected Input

You need to send a POST request to the function with the following JSON structure in the body including every field mentioned in
[Game Record](../../MongoDB/Collections/coop__games.html)

## 🔄 How It’s Used in the System

After a user enter the userId to the game, the game client sends a request to this function to add a new game record with the user environment data. The function processes the request, validates the data, and stores it in the database.
