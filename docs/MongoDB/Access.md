---
layout: default
title: Access
nav_order: 1
parent: MongoDB
---

# Access

To connect to MongoDB, ask the project owner (the PI) for a personal read-only or read/write database user. **Credentials, connection strings and passwords are never stored in these docs, in Notion or in Git.**

## Connection Types

There are two types of connection strings:

- **Read-only**: Used to read data from the database
- **Read and write**: Used to read and write data to the database

**Important**: These connection types are for development purposes only. Production functions get the connection string from the GCP Secret Manager secret `MONGO_CONNECTION` (see the CloudFunctions repository). Use [MongoDB Compass](https://www.mongodb.com/products/tools/compass) to browse the database; the game data is in database `coop` and Prolific data in database `prolific`. Never run write operations against live participant data except through the documented functions, and rotate any credential that has been shared in chat, email or a document.
