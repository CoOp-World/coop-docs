---
layout: default
title: Prolific and Qualtrics
nav_order: 10
parent: Addons
---

# Prolific and Qualtrics

How game data is linked to the questionnaire platforms. Migrated from the Notion page "qualtrics & prolific" (Dec 2024, written from the original developer's memory — verify details against the code before relying on them).

## The join key: `user_id`

The `user_id` created for each participant in the game database is the key for cross-referencing game data (MongoDB) with Qualtrics and Prolific data. The cross-reference is **not automatic**; it depends on how you analyse the data (an Excel lookup, Python, etc.).

## Qualtrics

- There is no direct interface between Qualtrics and the game database.
- Every questionnaire has a field where the respondent enters the participant number — this is the game `user_id`.
- Working practice: create `user_id`s, give each experimenter a list, and have her assign them to the participants she is responsible for. The participant uses the same `user_id` in the game and in every questionnaire. For parent questionnaires the experimenter enters the child's `user_id`.
- `user_id`s must be unique. Qualtrics does not validate the number; any value is accepted and the questionnaire continues, so typos silently break the join.
- An automation that pulls Qualtrics responses into the project database was an open idea (Weekly 8, Dec 2024); no evidence it was built.

## Prolific

Each Prolific participant has a `PROLIFIC_PID`, but the game needs a `user_id` registered in the database, and the system keeps a mapping from `PROLIFIC_PID` to `user_id`. A separate system handles this: a React site with Python server functions, both hosted on GCP (the Prolific survey template site linked from the docs home page; the original note says its repository was shared on GitHub, but the location was not recorded).

Flow:

1. The participant lands on the site with `PROLIFIC_PID`, `STUDY_ID` and `SESSION_ID` as URL parameters (`prolific-welcome-page-started` / `prolific-start`).
2. A `user_id` is created, written to the database and shown to the participant.
3. The participant plays the game with that `user_id`.
4. At the end of the game the participant receives an **end code** and enters it back on the site (`prolific-first-page-finished` verifies it against `expected_completion_code` and counts invalid attempts). The original note says the code is "I think `user_id`/120, as an integer"; this is unverified.
5. A feedback page collects feedback on the game experience and bugs (`prolific-study-finished`, `prolific-updatefeedback`).
6. Everything except gameplay data is stored in the dedicated `prolific/participants` collection; gameplay data goes to the normal collections.

Related pages: [prolific-start]({% link docs/Backend/Functions/prolific-start.md %}), [prolific-welcome-page-started]({% link docs/Backend/Functions/prolific-welcome-page-started.md %}), [prolific-first-page-finished]({% link docs/Backend/Functions/prolific-first-page-finished.md %}), [prolific-study-finished]({% link docs/Backend/Functions/prolific-study-finished.md %}), [prolific/participants]({% link docs/MongoDB/Collections/prolific__participants.md %}).
