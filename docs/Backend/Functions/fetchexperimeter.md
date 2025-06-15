---
layout: default
title: fetchexperimeter
parent: Functions
grand_parent: Backend
nav_order: 21
---

# `fetchexperimeter` Function

## 🔗 Name and URL

- **Function Name:** `fetchexperimeter`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/fetchExperimeter`

## 🛠️ What the Function Is Doing

This HTTP Cloud Function retrieves experimenter details from MongoDB based on their `_id`.

- Accepts a `POST` request containing an `id` (experimenter ID).
- Queries MongoDB for a document with `_id` matching the provided ID.
- Returns the full experimenter document if found.
- Supports CORS for cross-origin access.

## 📥 Expected Input

This function expects a `POST` request with the following JSON body:

```json
{
  "id": "experimenter_001"
}
```

- `id`: The unique identifier of the experimenter whose details are being requested.

## 🔄 How It’s Used in the System

This function is used to fetch detailed information about experimenters, including their names, IDs, and associated sessions. It is particularly useful for administrative tasks or user management features in the system. **It is currently not used in the frontend**, but it can be integrated into the admin panel or user management features to provide insights into experimenter data.
