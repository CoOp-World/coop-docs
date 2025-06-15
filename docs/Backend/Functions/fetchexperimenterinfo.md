---
layout: default
title: fetchexperimenterinfo
parent: Functions
grand_parent: Backend
nav_order: 20
---

# `fetchexperimenterinfo` Function

## 🔗 Name and URL

- **Function Name:** `fetchexperimenterinfo`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/fetchExperimenterInfo`

## 🛠️ What the Function Is Doing

This HTTP Cloud Function retrieves the name of the experimenter associated with a given `user_id`. And accesses the MongoDB database to find the corresponding experimenter information in the collection [`experimenters`](../../MongoDB/Collections/coop__experimenters.html).

- Accepts a `GET` request with a `code` query parameter.
- Searches MongoDB for a document with `user_id == code`.
- If found, returns the experimenter's name under the `db_experimenter` key.
- If no match is found, returns `db_experimenter: "invalid_user"`.

It includes full CORS support for use in browser-based tools.

## 📥 Expected Input

The function expects a `GET` request with the following query parameter:

```plaintext
code=<user_id>
```

- `code`: The user ID of the experimenter whose information is being requested.

## 🔄 How It’s Used in the System

This function is used to fetch information about experimenters, including their names, IDs, and associated sessions. **It is currently not used in the frontend**, but it can be integrated into the admin panel or user management features to provide insights into experimenter data.
