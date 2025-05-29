---
layout: default
title: Access
nav_order: 1
parent: MongoDB
---

# Access

To connect to mongoDB you need to look in the notion docs for document called "MongoDB connection" there you will find the connection string and the credentials.

There two types of connection strings:

- read only
- read and write

The read only connection string is used to read the data from the database and the read and write connection string is used to read and write the data to the database. **This strings are only for dev purposes to the functions in the cloud run there is a string in the the enviroment variables in the cloud run (in each function)**
The strings not have the password in the connection string. The password is in the dropbox file in the document in the notion docs.
