---
layout: default
title: Adding a Level
nav_order: 4
parent: Game
---

# Adding a Level

> **Status: legacy procedure.** The steps below are from a Notion page of Oct 2024. On the `main` branch levels are now built dynamically from database configuration (`levels_config`) with a generic `LevelTemplate` class (see [Main Game]({% link docs/Game/Versions/Main-Game.md %}) and [coop/levels_config]({% link docs/MongoDB/Collections/coop__levels_config.md %})), so no new class is needed there. The hardcoded-class procedure may still apply to older branches that define `LevelNConfiguration` classes. Verify against the branch you are working on.

## Hardcoded level configuration (older branches)

1. **Add the background** to `levelsBg` in `src/consts/KeyValueAssets.js`:

   ```js
   basicBg: {
       id: "basicBg",
       path: "assets/levelsBg/basicBg.png"
   }
   ```

2. **Add obstacle images** to `levelsObstacles` in the same file:

   ```js
   boxSmall: {
       id: "boxSmall",
       path: "assets/levelsObstacles/boxSmall.png"
   }
   ```

3. **Create a level configuration class** in the `utilities` configuration folder (example for level 10, shortened to two obstacles):

   ```js
   import LevelConfiguration from './LevelConfiguration.js';
   import Obstacle from '../../objects/obstacles/Obstacle.js';
   import * as KeyValueAssets from '../../consts/KeyValueAssets.js';

   class Level10Configuration extends LevelConfiguration {
       constructor(scene) {
           super(scene);
           this.scene = scene;
           this.key = "level10";
           this.bgKey = KeyValueAssets.levelsBg.iceBg.id;
           this.obstaclesArray = this.createObstaclesArray();
       }

       createObstaclesArray() {
           const levelsObstacles = KeyValueAssets.levelsObstacles;
           return [
               new Obstacle(
                   levelsObstacles.iceBigMid.id,   // type
                   undefined,                      // edgeLeftType (defaults to type)
                   levelsObstacles.iceRight.id,    // edgeRightType
                   210,                            // position (grid cell)
                   19                              // amount (obstacles side by side)
               ),
               new Obstacle(
                   levelsObstacles.iceBigMid.id,
                   levelsObstacles.iceLeft.id,
                   levelsObstacles.iceRight.id,
                   259,
                   5
               )
           ];
       }
   }
   export default Level10Configuration;
   ```

4. **Export it** from `src/utilities/configuration/index.js`:

   ```js
   export { default as Level10Configuration } from './Level10Configuration.js';
   ```

5. **Register it in the game**: import it in `src/scenes/Home.js` from `index.js` and add it to the `this.levelConfigurations` array in the constructor.

## Level configuration object (design spec, Nov 2024)

The plan to move level definitions to the server used this object. It is the ancestor of the `levels_config` collection; the live schema is in [coop/levels_config]({% link docs/MongoDB/Collections/coop__levels_config.md %}).

```js
{
  levelKey: "",
  background: key | base64 url | external source,
  obstaclesArray: [{
    obstaclePhoto: key | base64 url | external source,
    obstaclePhotoLeft: ...,
    obstaclePhotoRight: ...,
    startPositionInGrid: int,
    amount: int          // how many times the obstacle repeats side by side; -1 = fill the screen
  }],
  playerStartPosition: int,            // grid position
  virtualPlayersPosition: int,         // grid position
  virtualPlayerStrategies: [...],      // strategy name per virtual player
  virtualPlayerSearcher: ...,          // search algorithm per virtual player
  regularCollectibles: ...,            // per virtual player
  specialCollectibles: ...,            // per virtual player
  virtualPlayersProperties: [...],     // types of virtual players except the first selected one
  reachableLocations: [[...]],         // grid cells players can reach
  backgroundSound: key,
  levelNum: int                        // index in the total levels
}
```

### Level arrangement (design spec)

Each user gets an array of the levels they will see, so that experimenters can assign different level sets. The server function `getConfiguration?val=userId` finds the user's experimenter and level array and returns the matching configurations (default experimenter `""` if none; all of the experimenter's levels if the user has no array). The plan had two parts: (1) configuration objects in Mongo, the GCP function, an empty array for new users, user creation accepting a level array, defaults, and the client reading configurations from the server; (2) management functions (add/remove level) and a management interface.

This was later extended for sessions: each entry in the user's `levels` array is `{ level_num, sessions: [{ session_num, index_in_session, level_strategy }] }` and the user has `current_session`. See [Sessions]({% link docs/Game/Sessions.md %}) and [coop/users]({% link docs/MongoDB/Collections/coop__users.md %}).
