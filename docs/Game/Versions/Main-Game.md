---
layout: default
title: Main Game
nav_order: 3
parent: Versions
grand_parent: Game
---

# Main Game (Main Branch)

The main production version of the Coop Game is the primary branch for deployment, supporting multiple study cohorts, languages, and advanced technical integrations like AI-driven NPC feedback.

## Access Information

- **Game URL**: [https://co-op-client-791222378113.europe-central2.run.app](https://co-op-client-791222378113.europe-central2.run.app){:target="_blank"}
- **Repository Branch**: `main`
- **Repository**: [CO-OP-client (main branch)](https://github.com/CoOp-World/CO-OP-client){:target="_blank"}

## Game Details

| Property | Value |
|----------|-------|
| **Levels Available** | `0-10` (standard) and custom levels up to `27` (dynamically loaded) |
| **Supported User IDs** | Any (registered via MongoDB) |
| **Default Language** | Hebrew (`heb`) |
| **Supported Languages** | Hebrew (`heb`), English (`en`), Arabic (`ar`), Macedonian (`mk`) |
| **Region** | Europe Central 2 |
| **Status** | Production |

---

## Complete Game Flow & Supported Cohorts

The `main` branch serves as a multi-tenant client that loads different game behaviors and levels depending on the user's configuration in the database:

### 1. Deaf Version
* **Language & Audio**: Played in Hebrew (`heb`) with sign-language video overlays.
* **Levels**: Plays Levels `0, 1-6`.
* **Strategy**: Tit-for-Tat (TFT) cooperation.

### 2. Macedonian Version (Anna's Cohort)
* **Language & Audio**: Played in Macedonian (`mk`) with localized audio voice-overs (`-mk.mp3`) and background graphics (`-mk.png`).
* **Levels**: Plays Levels `0, 21-27` (8 levels total).
* **Strategy**: Noisy/Probabilistic Tit-for-Tat (70% TFT, 30% opposite).

### 3. Full TFT Version
* **Language & Audio**: Played in Hebrew (`heb`).
* **Levels**: Plays Levels `0, 1-7` (8 levels total).
* **Strategy**: Strict Tit-for-Tat (TFT).

---

## Core Technical Features

This branch contains several advanced features not present in other specific study branches (like `prod-Autistic-exp`):

### 1. AI/LLM-Generated NPC Decision Feedback
When a human player asks a virtual player for help:
* **Dynamic Explanations**: The client fetches custom text explanations and spoken audio (base64) from the `generate-decision-explanation` Cloud Function.
* **Audio Voice-Over**: Spoken explanations are played over the game using a decoded audio stream in Phaser, temporarily ducking the background music.
* **Fallback Animation**: If the LLM request fails or is disabled, the game falls back to the standard client-side sprite animations.

### 2. Defensive Rendering & Watchdog Safeguards
To guarantee stability during testing with children, the `main` branch includes defensive checks:
* **Duplicate Render Protection**: [SelectLevel.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/scenes/SelectLevel.js) implements an `_created` flag and children list checks at initialization to prevent duplicate buttons and overlays from rendering if a scene is loaded multiple times.
* **Timer Watchdog**: [WatchLabel.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/objects/WatchLabel.js) implements a tick watchdog (`_lastTickAt`) to detect and report fast/double-ticking timer bugs (warning if tick interval falls below 900ms).

### 3. Dynamic Level Building
* Rather than relying solely on hardcoded `Level1Configuration` classes, [Home.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/scenes/Home.js) preloads and constructs levels dynamically using a generic [LevelTemplate.js](file:///Users/yonitrach/Developer/CoOp/CO-OP-client/src/utilities/configuration/LevelTemplate.js) class based on database configurations (background, obstacles, collectibles, paths). This allows the same branch to run completely different level indices (e.g. 1-7 or 21-27) without code changes.

---

## Deployment

This version is deployed from the `main` branch to Google Cloud Run (Gen 2) in the `europe-central2` region via Google Cloud Build.
