---
layout: default
title: Access
nav_order: 1
parent: MongoDB
---

# Access

To connect to MongoDB, refer to the Notion documentation titled "MongoDB connection" for the connection string and credentials.

## Connection Types

There are two types of connection strings:

- **Read-only**: Used to read data from the database
- **Read and write**: Used to read and write data to the database

**Important**: These connection strings are for development purposes only. Cloud Run functions use environment variables for their connection strings (defined individually for each function). The connection strings do not include the password; refer to the Dropbox file linked in the Notion documentation for passwords.
