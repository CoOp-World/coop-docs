---
layout: default
title: getallconfignames
parent: Functions
grand_parent: Backend
nav_order: 24
---

# `getallconfignames` Function

## 🔗 Name and URL

- **Function Name:** `getallconfignames`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/getallconfignames`

## 🛠️ What the Function Is Doing

This Cloud Function retrieves a list of all level configuration identifiers from MongoDB.

- Connects to the `levels_config` collection in the database.
- Extracts the `levelNum` field from each document.
- Returns a list of available level numbers (used to identify level configurations).
- Includes CORS support for client-side integration.

## 📥 Expected Input

This function expects a `GET` request.  
No request body or query parameters are required.

## 🔄 How It’s Used in the System

This function is used to fetch all available level configurations in the game. It provides a list of level identifiers that can be used by the user managment interface to choose the order the sessions and levels the user will play.
