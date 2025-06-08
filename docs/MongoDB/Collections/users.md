---
title: users
parent: Collections
nav_order: 14
layout: default
grand_parent: MongoDB
---

# `users` Collection

This collection stores documents related to users cretaed for the therapist web application. It includes user credentials and roles.

## Schema

| Field      | Type     | Purpose                                        |
| ---------- | -------- | ---------------------------------------------- |
| `__v`      | int      | Version key, automatically managed by Mongoose |
| `_id`      | objectId | Unique identifier for the document             |
| `admin`    | bool     | Indicates if the user is an admin              |
| `email`    | string   | User's email address                           |
| `fullName` | string   | User's full name                               |
| `localId`  | int      | Local identifier for the user                  |
| `password` | string   | User's password                                |
| `username` | string   | User's username                                |
