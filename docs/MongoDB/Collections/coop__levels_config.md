---
layout: default
title: coop/levels_config
parent: Collections
nav_order: 6
grand_parent: MongoDB
---

# `coop/levels_config` Collection

This collection stores documents related to the configuration of levels in the co-op game environment. Each document contains detailed information about the level, including player properties, obstacles, collectibles, and other relevant data.

## Schema

| Field                      | Type     | Purpose                                                                                                      |
| -------------------------- | -------- | ------------------------------------------------------------------------------------------------------------ |
| `_id`                      | objectId | Unique identifier for the document                                                                           |
| `background`               | string   | Background image or theme for the level                                                                      |
| `backgroundSound`          | string   | Sound file associated with the level background                                                              |
| `decision`                 | bool     | Indicates if a decision needed to be made in the start to play with the fast/ slow player (Felix experiment) |
| `defaultPlayer`            | string   | Default player type or character used in the level (Felix experiment)                                        |
| `gap`                      | array    | Array of gap configurations for the level, defining spaces between coins creation                            |
| `levelKey`                 | string   | Key identifier for the level, used to reference the level in the game                                        |
| `levelNum`                 | int      | Number of the level, used to identify the level in the game                                                  |
| `likeHuman`                | bool     | Indicates if the virtual player is designed to be played like a human (Competitive experiment)               |
| `locations`                | array    | Array of locations within the level, defining positions for various elements                                 |
| `obstaclesArray`           | array    | Array of obstacles present in the level, defining their types and positions                                  |
| `playerStartPosition`      | int      | Starting position of the player in the level, used to initialize player state                                |
| `ranges`                   | array    | Array of ranges defining the distribution of collectibles in the level                                       |
| `regularCollectibles`      | array    | Array of regular collectibles type available in the level                                                    |
| `specialCollectibles`      | array    | Array of special collectibles type available in the level                                                    |
| `tasks`                    | array    | Array of tasks or objectives for the level, defining what players need to accomplish                         |
| `time`                     | int      | Time limit for the level, defining how long players have to complete it                                      |
| `velocities`               | array    | Array of velocities defining the speed of virtual players in the level                                       |
| `virtualPlayerSearcher`    | array    | Array of virtual player searcher configurations, defining how virtual players search for collectibles        |
| `virtualPlayerStrategies`  | array    | Array of strategies used by virtual players in the level                                                     |
| `virtualPlayersPosition`   | array    | Array of positions for virtual players in the level, defining where they start                               |
| `virtualPlayersProperties` | array    | Array of properties for virtual players, defining their characteristics                                      |
