---
layout: default
title: coop/levels
parent: Collections
nav_order: 5
grand_parent: MongoDB
---

# `coop/levels` Collection

This collection stores documents related to the levels played in the co-op game environment. Each document contains detailed information about the level, including player actions, scores, and other relevant data.

## Schema

| Field                       | Type           | Purpose                                                                                 |
| --------------------------- | -------------- | --------------------------------------------------------------------------------------- |
| `_id`                       | objectId       | Unique identifier for the document                                                      |
| `apk_version`               | string         | Version of the game used for the level                                                  |
| `bug_reported`              | bool           | Indicates if a bug was reported during the level                                        |
| `cheat_used`                | bool           | Indicates if a cheat was used during the level                                          |
| `collectible_tracking_data` | array          | Data related to collectibles tracked during the level                                   |
| `comments`                  | string         | Comments or notes about the level                                                       |
| `detailed_player_actions`   | object         | Detailed actions taken by the player during the level                                   |
| `elementCollectionList`     | object         | Collection of elements in the level                                                     |
| `element_collection_list`   | array          | List of elements in the level                                                           |
| `encoded_screenshot`        | null           | Encoded screenshot of the level, if available                                           |
| `end_time`                  | string         | Time when the level ended                                                               |
| `experimenter`              | string         | Name of the experimenter associated with the level                                      |
| `fps_info`                  | object         | Information about frames per second during the level                                    |
| `framework_name`            | string         | Name of the framework used for the level                                                |
| `group`                     | string         | Group identifier for the level                                                          |
| `help_requests`             | array          | List of help requests made during the level                                             |
| `infrastructure`            | string         | Infrastructure used for the level, e.g., "web", "mobile"                                |
| `level_key`                 | string         | Key identifier for the level                                                            |
| `level_num`                 | int, string    | Number of the level played                                                              |
| `level_type`                | string         | Type of the level                                                                       |
| `map_name`                  | string         | Name of the map used in the level                                                       |
| `mute_events`               | array          | List of events that were muted during the level                                         |
| `new_record`                | bool           | Indicates if a new record was set during the level                                      |
| `num_of_stars`              | int            | Number of stars earned in the level                                                     |
| `pause_events`              | array          | List of pause events during the level                                                   |
| `player_gender`             | string, null   | The gender of the player, if specified                                                  |
| `scores`                    | object         | Scores achieved during the level, including individual scores for each player           |
| `screenshots_num`           | int            | Number of screenshots taken during the level                                            |
| `sendingInfo`               | string         | Information about sending data related to the level                                     |
| `start_time`                | string         | Time when the level started                                                             |
| `tablet_id`                 | string         | Not relevent                                                                            |
| `textual_output`            | null, string   | Textual output or logs from the level, if available                                     |
| `timestamp`                 | string         | Timestamp when the level was recorded                                                   |
| `tries`                     | int            | Number of tries taken to complete sending this info                                     |
| `user_id`                   | string         | ID of the user playing the level, must be string                                        |
| `user_name`                 | string         | Name of the user playing the level, must be string (not the real name but the Id again) |
| `virtual_gender`            | string, null   | The gender of the virtual player, if specified                                          |
| `virtual_strategy`          | string, object | Strategy used by the virtual player, if applicable                                      |
