---
layout: default
title: Autistic
nav_order: 5
parent: Versions
grand_parent: Game
---

# exp-autistic - Autistic Study Experiment

The autistic study version of the Coop Game is designed with specific considerations for autistic participants.

## Access Information

- **Game URL**: [https://exp-autistic-791222378113.europe-central2.run.app](https://exp-autistic-791222378113.europe-central2.run.app){:target="_blank"}
- **Repository Branch**: `prod-Autistic-exp`
- **Repository**: [CO-OP-client (autistic branch)](https://github.com/CoOp-World/CO-OP-client/tree/prod-Autistic-exp){:target="_blank"}

## Game Details

| Property | Value |
|----------|-------|
| **Levels Available** | `0, 21-27` (8 levels total including Intro) |
| **Supported User IDs** | Any (registered via MongoDB) |
| **Default Language** | Hebrew (`heb`) |
| **Supported Languages** | Hebrew (`heb`), English (`en`), Arabic (`ar`) |
| **Region** | Europe Central 2 |
| **Status** | Production |

---

## Complete Game Flow

### Phase 1: Onboarding and Tutorial

1. **Login Phase**: Child enters their assigned User ID. The system validates the ID and loads the configured session parameters for the `Autistic` variant.
2. **Gender Selection**: Child selects the genders of the player characters/avatars.
3. **Introduction**: A brief text and audio-based introduction to the game.
4. **Controls Tutorial**: A step-by-step onboarding tutorial to teach the movement controls (arrow keys or WASD) and cooperation mechanics.
5. **Tutorial Level (Level 0)**: Introductory level to practice controls in a sensory-adapted game environment.

### Phase 2: Gameplay Phase

* **Real Levels**: Participant plays Levels 21-27 (7 core levels).
* **Game Session Finish**: The game finishes when the child completes the last level (index 7) and clicks the `Finish` button on the level selection screen, transitioning to the `End` scene.

---

## Specific Gameplay Mechanics

### 1. Active Help Requests
Unlike some other versions (such as the Felix variant), the help request system is **fully active** in the Autistic study.
* **Help Request Count**: The QA system expects a total of 8 help requests per level (4 initiated by the human player, 4 initiated by the virtual player).
* **Interaction**: The player can ask for help via the help icon in the toolbar, and the virtual player can trigger popups asking the player for help.

### 2. Noisy TFT Strategy
The virtual player's behavior strategy uses a `ProbabilisticTFT` (Noisy Tit-For-Tat) strategy, meaning there is a probabilistic chance of cooperation or rejection, which simulates more natural social dynamics.

### 3. Star Scoring Thresholds
The star calculations shown in the mid-score popup are customized as follows:
* **1 Star**: Score of `0` to `25`
* **2 Stars**: Score of `26` to `49`
* **3 Stars**: Score of `50` or higher

---

## Differences from the Main Branch

Beyond the absence of the AI/LLM-generated feedback system, the `prod-Autistic-exp` branch differs from the `main` branch in the following ways:

### 1. Absence of AI/LLM Decision Feedback
* In the `main` branch, the virtual player utilizes LLM-based custom explanations and plays dynamic spoken voice audio when agreeing or declining to help. 
* In this branch, [VirtualPlayer.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/objects/players/VirtualPlayer.js) does not contain the `#getGeneratedExplanation()` or `#playExplanationAudio()` methods. The help request resolves directly to a boolean value, prompting only standard, local animations.

### 2. No Defensive Phaser Scene Safeguards
* The `main` branch contains duplicate-rendering guards in [SelectLevel.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/scenes/SelectLevel.js) (such as the `_created` flag and checking children lists at creation) to avoid duplicate button grids, as well as double-tick timer safeguards in [WatchLabel.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/objects/WatchLabel.js). 
* These safeguards are not present in this branch.

### 3. Cleaned-Up Macedonian Localization
* All Macedonian localization assets (such as `-mk.mp3` and `-mk.png` files) and their references in [KeyValueAssets.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/consts/KeyValueAssets.js) are completely removed from this branch.

---

## Research Data Collection

### Tracked Metrics
- **Help Requests**: Saves the acceptance rate, asking/answer timestamps, and game scores during requests.
- **TFT Compliance**: Captures cooperation matches to measure behavioral patterns.
- **Performance / FPS**: Monitors average FPS (asserts >= 30 FPS).
- **Time Metrics**: Records response times for decisions.

---

## Deployment

This version is deployed from the `prod-Autistic-exp` branch to Google Cloud Run (Gen 2) in the `europe-central2` region.
