---
layout: default
title: post-retry-worker
parent: Functions
grand_parent: Backend
nav_order: 29
---

# `post-retry-worker` Function

## 🔗 Name and URL

- **Function Name:** `post-retry-worker`
- **Region:** `europe-central2`
- **URL:** `https://post-retry-worker-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This function is responsible for retrying failed HTTP POST requests to Cloud Functions. When invoked, it:

- Parses the JSON payload that contains the request to retry.
- Backs up the retry request to a Cloud Storage bucket (`api_gateway_failed_requests`).
- Schedules a retry job using Cloud Scheduler to execute the failed POST request again, typically one minute after the current time.

## 📥 Expected Input

The function expects a POST request with a JSON body formatted as follows:

```json
{
  "cloudFunctionIdentifier": "addGameRecord",
  "request": {
    "url": "https://europe-central2-co-op-world-game.cloudfunctions.net/",
    "headers": {
      "Content-Type": "application/json"
    },
    "body": {
      "player_id": "12345",
      "score": 1000,
      "level": 5,
      "timestamp": "2023-05-27T12:00:00Z"
    }
  }
}
```

- `cloudFunctionIdentifier`: The identifier of the Cloud Function to retry.
- `request`: An object containing:
  - `url`: The URL of the Cloud Function to retry.
  - `headers`: HTTP headers to include in the request.
  - `body`: The JSON body of the request to be retried.

## 🔄 How It’s Used in the System

Whenever a POST request to a Cloud Function fails, this retry function can be triggered (e.g., via a Pub/Sub or error handler). It ensures reliability by backing up the request and scheduling a retry with Cloud Scheduler, helping to guarantee delivery and execution of important requests even in the event of transient failures.
