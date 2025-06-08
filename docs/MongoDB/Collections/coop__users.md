---
layout: default
title: coop/users
parent: Collections
nav_order: 9
grand_parent: MongoDB
---

# `coop/users` Collection

This collection stores documents related to users in the co-op game, including their game progress, preferences, and other relevant information. It is used to manage user data such as levels played, items owned, and user settings.

## Schema

| Field               | Type         | Purpose                                                                                                    |
| ------------------- | ------------ | ---------------------------------------------------------------------------------------------------------- |
| `Excluded`          | string       | Indicates if the user is excluded from the experiment                                                      |
| `Notes`             | string       | Additional notes about the user                                                                            |
| `_id`               | objectId     | Unique identifier for the document                                                                         |
| `current_balance`   | double, int  | Current balance of the user in the game, can be a double or int                                            |
| `current_session`   | int          | Current session number the user is in                                                                      |
| `equiped_items`     | array        | List of items currently equipped by the user                                                               |
| `experimenter`      | string       | Identifier for the experimenter managing the user                                                          |
| `grade`             | string       | Grade of the user, if applicable                                                                           |
| `high_score`        | int          | User's high score in the game                                                                              |
| `human_gender`      | string, null | The gender the user identifies with, can be null if not connected to the game ever                         |
| `language`          | string       | Language preference of the user                                                                            |
| `levels`            | array        | List of levels the user needs to play including their IDs and separation to sessions                       |
| `levels_played`     | int          | Number of levels the user has played                                                                       |
| `master`            | bool         | Indicates if the user is a master user (e.g., can play level more than once)                               |
| `name`              | string       | Name of the user in the game (not implemented yet)                                                         |
| `owned_items`       | array        | List of items owned by the user, including their IDs and types                                             |
| `randomize`         | bool         | Indicates the user is in Felix experiment and indicating which player play first in the introduction level |
| `registration_time` | string, null | Timestamp of when the user registered, can be null if not registered yet                                   |
| `request_enable`    | bool         | Indicates if the user has request in the game                                                              |
| `user_id`           | string       | Unique identifier for the user in the game, used to connect with other collections and connect to the game |
| `virtual_gender`    | string, null | The gender of the virtual player the user plays with, can be null if not connected to the game ever        |
| `was_activated`     | string       | Indicates if the user was activated in the game (e.g., entered the user id)                                |
| `was_registered`    | string       | Indicates if the user was registered in the game (e.g., selected the player gender)                        |
