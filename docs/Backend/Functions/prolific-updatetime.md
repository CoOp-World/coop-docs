---
layout: default
title: prolific-updatetime
parent: Functions
grand_parent: Backend
nav_order: 37
---

# `prolific-updatetime` Function

## 🔗 Name and URL

- **Function Name:** `prolific-updatetime`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/prolific-updateTime`

## 🛠️ What the Function Is Doing

This function updates the play duration or survey duration for a Prolific participant record in MongoDB. It identifies the participant by `_id` and determines which field (`play_duration` or `survey_duration`) to update based on a `time` query parameter.

## 📥 Expected Input

### Request Method

- `PUT`

### Query Parameters

| Parameter | Required | Description                                           |
| --------- | -------- | ----------------------------------------------------- |
| `user_id` | ✅       | MongoDB `_id` of the document to update (as a string) |
| `time`    | ✅       | Type of time to update: `"gameplay"` or `"survey"`    |

### JSON Body

| Field  | Required | Description                                |
| ------ | -------- | ------------------------------------------ |
| `time` | ✅       | Time duration in minutes (or desired unit) |

## 🔄 How It’s Used in the System

This function is used to update the time spent by a participant in the game or survey. It allows researchers to track how long participants engage with the game, which is crucial for analyzing user behavior and study results. The function ensures that the correct duration field is updated based on the `time` parameter, maintaining accurate records in the MongoDB database.
