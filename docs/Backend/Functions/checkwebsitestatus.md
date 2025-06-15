---
layout: default
title: checkwebsitestatus
parent: Functions
grand_parent: Backend
nav_order: 7
---

# `checkwebsitestatus` Function

## 🔗 Name and URL

- **Function Name:** `checkwebsitestatus`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/checkWebsiteStatus`

## 🛠️ What the Function Is Doing

This function checks the status of a website by making an HTTP request to the specified URL. It returns the HTTP status code and the response body, which can be used to determine if the website is up and running or if there are any issues. It checkes the status in mongoDB and updates the status if necessary, In collection
[here](../../MongoDB/Collections/coop__config.html).

## 📥 Expected Input

No input is required for this function. It can be triggered by an HTTP request without any parameters. The function will check the status of the website configured in the database.

## 🔄 How It’s Used in the System

Before the game starts, the client checks the status of the website by calling this function. If the website is down or not reachable, the game will display an error message to the user and prevent them from starting the game. This ensures that users are aware of any issues with the website before they attempt to play.
