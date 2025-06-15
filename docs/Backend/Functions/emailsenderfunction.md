---
layout: default
title: emailsenderfunction
parent: Functions
grand_parent: Backend
nav_order: 13
---

# `emailsenderfunction` Function

## 🔗 Name and URL

- **Function Name:** `emailsenderfunction`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/EmailSenderFunction`

## 🛠️ What the Function Is Doing

This function listens to a Pub/Sub topic and sends an email using SendGrid when an error log entry is received. It decodes the error message, parses the log details, formats them into a readable message, and emails the configured recipient(s) **specified in the environment variables**. The email includes details such as the service name, request method, request body, status code, and error message.

It is primarily used for **error alerting** and monitoring application failures automatically.

## 📥 Expected Input

The function expects a **Pub/Sub message** with a base64-encoded payload, containing a `textPayload` field with JSON-formatted error log details. Example structure after decoding:

```json
{
  "textPayload": "{\"request_method\": \"POST\", \"request_body\": {...}, \"status_code\": 500, \"error\": \"Something failed\"}",
  "resource": {
    "labels": {
      "service_name": "some-service"
    }
  }
}
```

## 🔄 How It’s Used in the System

The function is used in the Co-op World game backend to monitor for errors and send notifications when issues occur. It helps maintain system reliability by alerting developers or administrators about critical failures that need attention.
