---
layout: default
title: Competitive
nav_order: 6
parent: Versions
grand_parent: Game
---

# exp-competitive - Competitive Study Experiment

The competitive study version of the Coop Game is designed to explore competitive dynamics and decision-making under competitive pressure.

## Access Information

- **Game URL**: [https://exp-competitive-791222378113.europe-central2.run.app](https://exp-competitive-791222378113.europe-central2.run.app){:target="_blank"}
- **Repository Branch**: `prod-competitive`
- **Repository**: [CO-OP-client (competitive branch)](https://github.com/CoOp-World/CO-OP-client/tree/prod-competitive){:target="_blank"}

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

1. **Login Phase**: Child enters their assigned User ID. The system validates the ID and loads the configured session parameters for the `exp-competitive` variant.
2. **Gender Selection**: Child selects the genders of the player characters/avatars.
3. **Introduction**: A brief text and audio-based introduction outlining the competitive format.
4. **Controls Tutorial**: A step-by-step tutorial explaining controls (arrows/WASD) and competitive scoring.
5. **Tutorial Level (Level 0)**: Practice round to learn how to move, collect coins, and interact.

### Phase 2: Gameplay Phase

* **Real Levels**: Participant plays Levels 21-27 (7 core levels).
* **Game Session Finish**: The game finishes when the child completes the last level (index 7) and clicks the `Finish` button on the level selection screen, transitioning to the `End` scene.

---

## Specific Competitive Gameplay Mechanics

### 1. Dual Score Tracker (Human vs. Virtual)
Unlike all other variants of the game, the gameplay toolbar contains **two score counters** displayed at the top:
* **Human Player Score**: Tracked via `this.score` (grid index 32).
* **Virtual Player Score**: Tracked via `this.scoreVirual` (grid index 36).
The score of the virtual player is updated dynamically whenever they collect regular/special collectibles or pay the lock penalty (`openLockCost = -5` points).

### 2. Win / Loss Feedback Screen
At the end of each level, the [MidScore.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/scenes/MidScore.js) screen compares the child's score against the virtual player's score:
* If the child's score is **greater than or equal to** the virtual player's score, the screen displays a customized **"Won"** star banner (`-won.png`).
* If the child's score is **lower**, it displays a **"Loss"** star banner (`-loss.png`).

### 3. Star Scoring Thresholds
* **1 Star**: Score of `0` to `25`
* **2 Stars**: Score of `26` to `49`
* **3 Stars**: Score of `50` or higher

---

## Differences from the Main Branch

Beyond the competitive elements, the `prod-competitive` branch differs from the `main` branch in the following ways:

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
- **Score Comparisons**: Saves both human and virtual player scores per level.
- **Help Requests**: Saves the acceptance rate, asking/answer timestamps, and scores.
- **Performance / FPS**: Monitors average FPS (asserts >= 30 FPS).
- **Time Metrics**: Records response times for decisions.

---

## Deployment

This version is deployed from the `prod-competitive` branch to Google Cloud Run (Gen 2) in the `europe-central2` region.
