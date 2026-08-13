---
layout: default
title: Felix
nav_order: 7
parent: Versions
grand_parent: Game
---

# exp-felix - Felix Experiment

Felix's experimental version of the Coop Game is designed to study children's decision-making patterns when choosing between virtual characters with different cooperation behaviors.

## Access Information

- **Production URL**: [https://exp-felix-791222378113.us-central1.run.app](https://exp-felix-791222378113.us-central1.run.app){:target="_blank"}
- **Production Branch**: `prod-Felix-exp`
- **Development Branch**: `dev-Felix-exp`
- **Repository**: [CO-OP-client (Felix branch)](https://github.com/CoOp-World/CO-OP-client/tree/prod-Felix-exp){:target="_blank"}

## Game Details

| Property | Value |
|----------|-------|
| **Levels Available** | `0, 11-13` or `0, 30-36` (depending on session name) |
| **Region** | US Central 1 |
| **Status** | Production |

### Supported Session Orders
When creating a user, the following session configs are supported:
- **`exp-felix-with-backgrounds`**: Levels `0, 30-36` (Intro + 7 main rounds).
- **`exp-felix-one-background`**: Levels `0, 13` repeated 7 times (Intro + 7 main rounds).
- **`exp-felix-short`**: Levels `0, 13` repeated 2 times (Intro + 2 main rounds).
- **Standard Training Sequence**: Levels `0, 11-13` (Intro + 2 training rounds + repeated main round).

---

## Complete Game Flow

### Phase 1: Onboarding and Tutorial

1. **Login Phase**: Child enters the game portal with their assigned User ID. The system validates the ID and loads session configurations from MongoDB.
2. **Gender Selection**: The child selects the genders of the player characters/avatars before starting.
3. **Game Introduction**: A brief text and audio-based introduction explaining the game setting and goals.
4. **Controls Tutorial**: A step-by-step introduction to the keyboard controls (arrow keys or WASD) and the cooperation mechanics.
5. **Tutorial Level (Level 0)**: Practice basic controls and mechanics in a safe environment. Player moves on the grid, collects coins, and meets the virtual characters.

### Phase 2: Character Speed Training (If levels 11 and 12 are included)

* **Slow Character Practice (Level 11)**: Player experiences working with the slow-moving virtual character.
* **Fast Character Practice (Level 12)**: Player experiences working with the fast-moving virtual character.

### Phase 3: Main Experimental Rounds

This is the core of the study, designed to observe children's character selection patterns over 7 rounds (either levels 30–36 or level 13 repeated).

#### Round Structure:
1. **Character Selection Screen**: Players choose between two virtual characters:
   - **Fair Character**: Splits coins equally with the player (6 for human player and 6 for virtual character).
   - **Unfair Character**: Keeps a larger share of collected coins (6 for human player and 12 for virtual character).
2. **Gameplay Phase**: Player works with their chosen virtual character to collect coins together during the time limit.
3. **Results Display**: Shows coins collected during the round and displays how coins were split.
4. **Ending**: After completing level 10 the game is over and the results screen is shown

### Phase 4: Game Completion

* **High Score Display**: Shows player's accumulated total score across all rounds.
* **Session End & Data Submission**: Results and choices are automatically saved and sent to the MongoDB database for research analysis.

---

## Research Data Collection

### Tracked Metrics
- **Character Selection**: Which character chosen each round.
- **Collection Performance**: Coins collected per round.
- **Time Metrics**: Response times for character selection.
- **Behavioral Trends**: Changes in preferences over rounds.

### Data Structure Example
```json
{
  "user_id": "participant_id",
  "session_data": {
    "rounds": [
      {
        "round_number": 1,
        "character_selected": "fair",
        "coins_collected": 45,
        "coins_received": 23,
        "completion_time": 120
      }
    ],
    "final_score": 185,
    "study_completion": true
  }
}
```

---

## Master User Features

### Enhanced Monitoring (Master Users Only)
- **Level Counter**: Real-time progression display in the top-left corner of the screen.
- **Session Tracking**: Accurate counting of completed rounds.
- **Format**: `"Level: X/Y"` (e.g., `"Level: 3/8"` showing round 3 of 8 total).