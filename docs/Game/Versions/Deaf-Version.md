---
layout: default
title: Deaf Version
nav_order: 2
parent: Versions
grand_parent: Game
---

# Deaf Version

The first study version of the game, for Deaf and hard-of-hearing children. It runs on the multi-tenant `main` client (see [Main Game]({% link docs/Game/Versions/Main-Game.md %})); there is no separate branch or URL today.

## Current configuration

| Property | Value |
|---|---|
| **Session name** | `Deaf-Version` (also the default session order when none is selected) |
| **Levels** | `0` (intro) + `1-6` |
| **Virtual player strategy** | TFT (not noisy) |
| **Language** | Hebrew, with sign-language video overlays |

See [Users]({% link docs/Users/Summary.md %}) and [Sessions]({% link docs/Game/Sessions.md %}).

## Sign-language requirements (historical, Dec 2024 – Jan 2025)

Recorded in the team's weekly meetings while the version was built. They are requirements as discussed then; the client code is the authority on what was actually implemented.

- Sign-language videos and voice recordings are added to the client; the pop-up sentences follow the file supplied by the psychology team.
- While a sign-language video is playing, the game is paused until it ends.
- The video plays once, then a **replay button** appears (Weekly 12).
- A hand-shaped button stops the sign-language videos (Weekly 10).
- A language indicator was requested on the URL sign (Weekly 12).
- A demo with video compression was to be created and sent to the team (Weekly 10).
- The records were to be sent again when there is no internet connection (Weekly 12; see the `post-retry-worker` function).

Options evaluated for generating sign language automatically, and why pre-recorded videos were used, are in [Languages, Sign Language and TTS]({% link docs/Game/Localization.md %}).

## Build history

- Release `1.0.0` was the first version with sign-language support, text embedded in images, and sessions (see [Experiment Versions]({% link docs/Project History/Experiment Versions.md %})).
- Pre-release checklist (Nov 2024), with status at the time: done — new-record pop-up only when the best score across all levels is broken, voice-over, level info served from the server, master users who can repeat a level, Hebrew support, basic user management, intro connected to the first level; open — sign-language support, replay/"video" of a game from the log, QA.
