---
layout: default
title: Sessions
nav_order: 2
parent: Game
---

# Sessions

When creating a user, you can assign them to different sessions. Each session contains multiple levels. When a user completes all levels in a session, they cannot access the next level until the page is reloaded. In the context of experiments, sessions represent different meetings or study sessions.

For instructions on creating new sessions, refer to the User Management section in the Addons documentation.

## Session definitions by game version

Each game variant uses a specific session definition that determines which levels are played in each meeting with the child. The numbering below uses the game's "intro" level (sometimes numbered `0` or `1`) followed by the regular levels.

- **Deaf version** — intro, then three follow-up meetings
	- Meeting 1: Intro only
	- Meeting 2: Levels 2 and 3
	- Meeting 3: Levels 4 and 5
	- Meeting 4: Levels 6 and 7

- **Macedonian / Anna (Noisy TFT)** — intro, then four follow-up meetings (split across 7 regular levels)
	- Meeting 1: Intro only
	- Meeting 2: Levels 1 and 2
	- Meeting 3: Levels 3 and 4
	- Meeting 4: Levels 5 and 6
	- Meeting 5: Level 7

- **Autistic (same as Anna)** — follows the Macedonian/Anna schedule
	- Meeting 1: Intro only
	- Meeting 2: Levels 1 and 2
	- Meeting 3: Levels 3 and 4
	- Meeting 4: Levels 5 and 6
	- Meeting 5: Level 7

- **Full TFT** — intro plus seven regular levels (same split as Macedonian/Anna)
	- Meeting 1: Intro only
	- Meeting 2: Levels 1 and 2
	- Meeting 3: Levels 3 and 4
	- Meeting 4: Levels 5 and 6
	- Meeting 5: Level 7

- **Felix** — minimal flow (no help requests); typically only intro and custom short sessions are used depending on experiment configuration.

If a study uses a different meeting breakdown, update this document and the selected session order in the UI to keep experiments consistent.
