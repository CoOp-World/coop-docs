---
layout: default
title: prolific-updatefeedback
parent: Functions
grand_parent: Backend
nav_order: 35
---

# `prolific-updatefeedback` Function

## 🔗 Name and URL

- **Function Name:** `prolific-updatefeedback`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific-updateFeedback`

## 🛠️ What the Function Is Doing

This function updates feedback-related responses for a Prolific participant in the MongoDB collection. It expects a `PUT` request with the participant's `_id` and optional feedback fields in the request body. It will update only the provided fields under the `answers` object in the participant document.

## 📥 Expected Input

### Request Method

- `PUT`

### Query Parameters

| Parameter | Required | Description                             |
| --------- | -------- | --------------------------------------- |
| `user_id` | ✅       | The MongoDB ObjectId of the participant |

### JSON Body Parameters

| Parameter               | Required | Description                           |
| ----------------------- | -------- | ------------------------------------- |
| `Q_general_opinion`     | ❌       | General opinion of the study          |
| `Q_bugs`                | ❌       | Reported bugs                         |
| `Q_suggestions`         | ❌       | Suggestions for improvement           |
| `Q_additional_comments` | ❌       | Any additional comments from the user |

## 🔄 How It’s Used in the System

This function is used to update feedback responses from participants in the Prolific study. It allows researchers to collect and maintain accurate feedback data, which is essential for analyzing the study's effectiveness and participant satisfaction. The function ensures that only the specified fields are updated, preserving the integrity of the participant's data in the MongoDB database.
