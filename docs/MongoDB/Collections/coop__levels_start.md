---
layout: default
title: coop/levels_start
parent: Collections
nav_order: 7
grand_parent: MongoDB
---

# `coop/levels_start` Collection

This collection stores documents related to the start of a level in th game to check if a player has started a level and did not finish it.

## Schema

| Field        | Type              | Purpose                                  |
| ------------ | ----------------- | ---------------------------------------- |
| `_id`        | objectId          | Unique identifier for the document       |
| `level_num`  | string, int, null | The level number that the player started |
| `start_time` | string            | The time when the level was started      |
| `user_id`    | int, string       | The ID of the user who started the level |
