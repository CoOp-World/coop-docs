---
layout: default
title: coop/games
parent: Collections
nav_order: 4
grand_parent: MongoDB
---

# `coop/games` Collection

This collection stores documents related to the general game information of a player, about the game they are playing, and the client environment. It is used to track the game session details, including the application version, client dimensions, user agent, and other relevant metadata.

## Schema

| Field                | Type         | Purpose                                                         |
| -------------------- | ------------ | --------------------------------------------------------------- |
| `__v`                | int          | Version key for the document, used by Mongoose                  |
| `_id`                | objectId     | Unique identifier for the document                              |
| `app_code_name`      | string       | The code name of the application                                |
| `app_name`           | string       | The name of the application                                     |
| `app_version`        | string       | The version of the application                                  |
| `client_height`      | int          | The height of the client window in pixels                       |
| `client_width`       | int          | The width of the client window in pixels                        |
| `exception`          | null         | Exception details, if any                                       |
| `infrastructure`     | string       | The infrastructure used by the game, e.g., "web", "mobile"      |
| `is_cookies_enabled` | bool         | Indicates if cookies are enabled in the client                  |
| `is_java_enabled`    | bool         | Indicates if Java is enabled in the client                      |
| `name`               | string       | The name of the game or session                                 |
| `platform`           | string       | The platform on which the game is played, e.g., "web", "mobile" |
| `query_string`       | string       | The query string of the game session URL                        |
| `scroll_left`        | int          | The horizontal scroll position of the client window in pixels   |
| `scroll_top`         | int          | The vertical scroll position of the client window in pixels     |
| `time_stamp`         | string       | The timestamp when the game session was recorded                |
| `user_agent`         | null, string | The user agent string of the client, if available               |
| `user_id`            | null, string | The ID of the user playing the game, if available               |
