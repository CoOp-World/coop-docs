---
layout: default
title: felix-test-gap-speed
parent: Functions
grand_parent: Backend
nav_order: 17
---

# `felix-test-gap-speed` Function

## 🔗 Name and URL

- **Function Name:** `felix-test-gap-speed`
- **Region:** `europe-central2`
- **URL:** `https://felix-test-gap-speed-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This Cloud Function receives level configuration data via an HTTP `POST` request and updates the configuration for level 16 in a MongoDB database. Specifically, it updates:

- `time` (duration of the level)
- `velocities` (movement settings)
- `gap` (spacing values between elements)

The function includes:

- CORS support
- MongoDB integration using environment variables
- JSON serialization for BSON types
- Structured error logging and Pub/Sub publishing for failed executions

If any error occurs, it logs details and sends the error to a configured Pub/Sub topic.

## 📥 Expected Input

This function expects a `POST` request with a JSON body like:

```json
{
  "time": 180,
  "velocities": [50, 60, 70],
  "gap": [3, 4, 5]
}
```

Where:

- `time`: Duration of the level in seconds.
- `velocities`: An array of integers representing the speed settings for the virtual player.
- `gap`: An array of integers representing the spacing between coins.

## 🔄 How It’s Used in the System

The function is used to change the speed of the virtual player and the gap between the coins creation ant the time of the level for Felix expiriment. The function is called by the frontend when the user changes the speed of the virtual player or the gap between the coins creation and the time of the level:
[here](../../Addons/Check%20Speed%20&%20Gap.html).
