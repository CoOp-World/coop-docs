---
layout: default
title: Code Details
nav_order: 3
parent: Architecture
grand_parent: Game
---

# Code Details

## Scene Flow Logic

![Co-Op Scene Flow](../../../assets/Scenes%20Flow.png)

This flowchart represents the user's navigation through the various scenes within the game:

### 🔄 Initial Flow

- `Loader`: Loads assets and game setup
  - If success → `Main`
  - If failure → `StatusError`, `Off`, or `TooManyCon`
- `Main`: Landing scene with "To the Game" button
- `Registration`: Prompt for user ID

### 📋 Conditional Scene Routing

- If invalid user ID → `InvalidCode`
- If valid:
  - No levels played → `Welcome`
  - 1+ level played → `Home`

### 🕹️ Gameplay Loop

- `Home`: Hub for navigating levels
- `Introduction`: First-level tutorial
- `SelectPlayer`: Choose human and virtual players
- `SelectLevel`: Choose available level
- `Level`: The core game experience
- `MidScore`: Scoreboard after each level
- `End`: Final report when game is finished

### 🧭 Transitions

- Scene transitions occur based on button clicks and internal flags (e.g., levels played, player choice).
- Persistent nodes like `Screenshot` run in the background throughout gameplay.

## The Level in Detail

he `Level` class is a core component of the game, responsible for managing the gameplay elements, interactions, and overall flow of a level. It extends the `Phaser.Scene` class, leveraging Phaser's game framework capabilities.

### Overview

The `Level` class handles:

- Initialization and setup of the level.
- Creation and management of collectibles, obstacles, and players.
- Interaction logic between players and game elements.
- Displaying messages and handling tasks.
- Managing timers and game state transitions.

### Key Methods

#### Initialization

- **`init(data)`**: Prepares the level with the provided data.
- **`create()`**: Sets up the level elements, including players, collectibles, obstacles, and UI components.
- **`update()`**: Continuously updates the game state during gameplay.
- **`destroy()`**: Cleans up resources when the level ends.

#### Collectibles

- **`createRegularCollectible(typeClass, group, sprite = null)`**: Creates a collectible of the specified type and adds it to the given group.
- **`createSpecialCollectible(classType, group)`**: Creates a special collectible and assigns it to a random virtual player or the regular player.
- **`createCoin(delayTime)`**: Creates a new coin for the regular player.
- **`createSpecialCoin(delayTime)`**: Creates a special coin for the regular player, either directly or using a timer.
- **`createIceCube(virtualPlayer, delayTime)`**: Creates an ice cube for a specific virtual player.
- **`createTaskCoin(taskName)`**: Creates a task coin for the regular player if none exists.

#### Tasks

- **`showTaskAccomplishedMessage()`**: Displays a message indicating task completion.
- **`showTaskFailedMessage()`**: Displays a message indicating task failure.
- **`takeawayTaskFee(fee = -5)`**: Deducts a fee from the regular player when a task starts.
- **`giveawayTaskReward(reward = 10)`**: Rewards the regular player for completing a task.
- **`giveBackPartOfFee(reward = 2)`**: Returns part of the task fee to the regular player.
- **`showChooseTaskPartnerScene(taskName)`**: Displays a scene for selecting a task partner.
- **`cancelTask(taskName)`**: Cancels the specified task.
- **`abortTask(taskName)`**: Aborts the specified task.

#### Player Interaction

- **`getRegularPlayer()`**: Returns the regular player instance.
- **`getPlayerCollectibleGroup(player)`**: Retrieves the collectible group associated with a player.
- **`askForHelp(virtualPlayerIndex)`**: Handles the regular player asking a virtual player for help.
- **`virtualPlayerOverlapLock(virtualPlayerCollector, lock)`**: Manages interactions when a virtual player collides with a lock.

#### Game State Management

- **`pauseGameForMessage()`**: Pauses the game to display a message.
- **`resumeGame()`**: Resumes the game after a pause.
- **`getTimeLeftToPlay()`**: Retrieves the remaining playtime.

#### UI and Visuals

- **`createToolbar()`**: Sets up the toolbar for UI elements.
- **`createTaskIconInToolbar(icon, position)`**: Adds a task icon to the toolbar.
- **`destroyTaskIconsInToolbar()`**: Removes all task icons from the toolbar.
- **`destroyChooseTaskPartnerSceneVisuals()`**: Cleans up visuals from the task partner selection scene.

#### Obstacles

- **`createObstacles()`**: Creates all obstacles for the level based on predefined configurations.

#### Timers

- **`Timer(callback, delay)`**: A custom timer implementation for managing delayed actions.

### Class Properties

- **`regularPlayer`**: The main player controlled by the user.
- **`virtualPlayerArray`**: Array of virtual players in the level.
- **`coinsGroup`**: Group containing all coin collectibles.
- **`arrayRegularCollectiblesGroup`**: Groups for regular collectibles associated with virtual players.
- **`toolbar`**: UI toolbar for displaying score, time, and other elements.
- **`levelInfo`**: Object containing information about the level.
- **`enableRequest`**: Boolean indicating whether requests for help are enabled.

### Interaction Logic

The `Level` class defines various interactions between players and game elements:

- Regular players collect coins and task coins.
- Virtual players interact with locks and their respective collectibles.
- Players can ask for help from virtual players or other human players.

### Example Usage

```javascript
const level = new Level();
level.init({ levelData });
level.create();
level.update();
level.destroy();
```

### Notes

- The class heavily relies on Phaser's physics and scene management.
- Timers and asynchronous methods are used for delayed actions and user interactions.
- Localization is supported for displaying messages in different languages.

This documentation provides a high-level overview of the `Level` class and its functionality. For detailed implementation, refer to the source code.
