---
layout: default
title: Roadmap and Ideas
nav_order: 2
parent: Project History
---

# Roadmap and Ideas ("Future missions", Nov 2024)

A wish list of project missions written by the main developer (last edited Apr 2025). **A list of ideas, not commitments or current facts.** Checked items were done by Apr 2025.

## Done by April 2025

- Level info comes from the server instead of local storage.
- New-record pop-up only when a record is set across all levels.
- Sign-language support; instruction sounds.
- Master IDs that can redo a level.
- Reconnect and continue from the next level.
- A website presenting the project.

## Open ideas

| Idea | Description (condensed) |
|---|---|
| Multi-language support | Support more languages (partly addressed through i18next and Gemini TTS). |
| Replay | Replay a game with fast-forward and jump-to-event; ideally a hierarchy of significant events. |
| Prediction models | Predict whether the child will help given the history. |
| Gamification | Make the game more attractive (animations, break a record each time) and measure how many levels children play. |
| Competitive settings | Show other players' points, a different end screen and virtual-player logic *(a competitive version exists)*. |
| Multi-virtual-player games | Several virtual players; who to ask for help; what each collects. |
| Multi-human games | Several human users playing together (synchronisation, connection loss). Marked difficult. |
| Discourse while playing | Talk to the virtual player with a language model fed with what changed since the last exchange. |
| Therapist behaviour generator | Interface to create and test new levels and behaviours, ideally from natural language, e.g. "the child experiences five consecutive refusals". |
| Therapist/teacher dashboard | Reports, comparisons between children, pattern analysis, unusual-game flags. |
| Parents' feedback | Compare a child to others, progress over time, decision times, confidence. |
| Other social skills | Cooperation in tasks, handling disappointment, group skills; make instructions dynamic. |
| Virtual player explanations | Explain why it helps or refuses, to teach reciprocity *(first version built; see [AI & LLM Integration]({% link docs/AI & LLM Integration/Overview.md %}))*. |
| Clustering behaviours | Learn 4–5 clusters of behaviour with a visual interface. |
| Bug management | Bug tracking with status and date, tied to replay and logging, with logs at several levels of detail. |

## Proposed team split (Nov 2024)

- **Team 1 — build on the system:** bug reporting + replay + logging; virtual-player strategies and social situations including a therapist interface; discourse while playing (text from logged events, TTS, microphone recording, a language model to explain decisions); virtual-player explainability.
- **Team 2 — data:** prediction, clustering and analysis with a subsystem to run it; parents' feedback and dashboard. Noted problem: not enough data, so propose a budget to collect data on Prolific, which requires Prolific infrastructure.
- **Team 3 — code and design:** other social skills, multi-virtual players, competitive games, gamification.
