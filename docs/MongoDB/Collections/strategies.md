---
layout: default
title: strategies
parent: Collections
nav_order: 12
grand_parent: MongoDB
---

# `strategies` Collection

This collection stores documents related to the strategies used in the application. Each document represents a strategy category, including its label, unique identifier, and translations for the strategy label and its parameters names.

## Schema

| Field          | Type     | Purpose                                                              |
| -------------- | -------- | -------------------------------------------------------------------- |
| `__v`          | int      | Version key, used by Mongoose for versioning                         |
| `_id`          | objectId | Unique identifier for the document                                   |
| `createdAt`    | date     | Timestamp of document creation                                       |
| `label`        | string   | Human-readable label for the strategy category                       |
| `strategyId`   | string   | Unique identifier for the strategy                                   |
| `translations` | array    | List of translations for the strategy label and all parameters names |
| `updatedAt`    | date     | Timestamp of last document update                                    |
