---
layout: default
title: coop/sessions
parent: Collections
nav_order: 8
grand_parent: MongoDB
---

# `coop/sessions` Collection

This collection stores documents related to predefined sessions in the co-op game, including the levels available in each session and the name of the order. It is used to manage the structure of the game sessions that players can participate in. Used in the user management system to define the levels and their order.

## Schema

| Field    | Type     | Purpose                                                                                           |
| -------- | -------- | ------------------------------------------------------------------------------------------------- |
| `_id`    | objectId | Unique identifier for the document                                                                |
| `levels` | array    | List of levels in the session, each level is an object with `level_num` and `sessions` properties |
| `name`   | string   | Name of the sessions order, used to identify the session in the user management system            |
