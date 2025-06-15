---
layout: default
title: prolific-updatedemodata
parent: Functions
grand_parent: Backend
nav_order: 34
---

# `prolific-updatedemodata` Function

## 🔗 Name and URL

- **Function Name:** `prolific-updatedemodata`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific-updateDemoData`

## 🛠️ What the Function Is Doing

This function is responsible for updating demographic data for a Prolific participant. Specifically, it allows a client to update the `Q_gender`, `Q_country`, and `Q_age` fields within the `answers` object in the participant’s document in MongoDB.

The function:

- Accepts `PUT` requests with a participant’s MongoDB `_id` as a query parameter.
- Reads demographic fields from the request body and updates only those that are present.
- Returns an error if no fields are provided or if the document does not exist.

## 📥 Expected Input

### Request Method

- `PUT`

### Query Parameters

| Parameter | Required | Description                             |
| --------- | -------- | --------------------------------------- |
| `user_id` | ✅       | The MongoDB ObjectId of the participant |

### JSON Body Parameters

| Parameter | Required | Description                              |
| --------- | -------- | ---------------------------------------- |
| `gender`  | ❌       | The participant’s self-identified gender |
| `age`     | ❌       | The participant’s age                    |
| `country` | ❌       | The participant’s country of origin      |

## 🔄 How It’s Used in the System

This function is used to update demographic information for participants in the Prolific study. It allows researchers to collect and maintain accurate demographic data, which is essential for analyzing study results and ensuring diversity among participants. The function ensures that only valid fields are updated, maintaining the integrity of the participant's data in the MongoDB database.
