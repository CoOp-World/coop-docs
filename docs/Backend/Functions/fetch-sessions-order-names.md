---
layout: default
title: fetch-sessions-order-names
parent: Functions
grand_parent: Backend
nav_order: 18
---

# `fetch-sessions-order-names` Function

## 🔗 Name and URL

- **Function Name:** `fetch-sessions-order-names`
- **Region:** `europe-central2`
- **URL:** `https://fetch-sessions-order-names-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This Cloud Function fetches all documents from a MongoDB collection containing session orders.

- It establishes a connection to MongoDB using environment variables.
- It queries the collection for all documents, excluding `_id`.
- It returns the result as a JSON array of session records. As you can see in [here](../../MongoDB/Collections/coop__sessions.html).
- It also supports CORS for frontend usage.

## 📥 Expected Input

This function expects a `GET` request.

No request body is required.

## 🔄 How It’s Used in the System

This function is used to fetch the order names of sessions in the user creation process. It is called by the frontend when the user selects a session to create a new one. The function retrieves the order names from the database and returns them in a JSON format.
It is used in the user creation process to ensure that the user can select a valid session order name when creating a new session.
