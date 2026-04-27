---
layout: default
title: Summary
nav_order: 1
parent: Users
---

# Users

This page documents the different user types we currently support and the session order that should be selected when creating each user. **Note**: Noisy TFT means the virtual player has a 70% chance to follow tit-for-tat strategy and a 30% chance to do the opposite.

## User Types

Currently, there are four user variants:

| User Type | Description | Notes |
| --- | --- | --- |
| Felix | No help requests; the player only chooses the virtual player. | Most minimal interaction flow. |
| Deaf | Non-noisy TFT with an introduction level plus 6 regular levels. | Use for the deaf version of the game. This is also the default session order if none is selected. |
| Macedonia - Anna | Noisy TFT with an introduction level plus 7 regular levels. | Use for Anna's Macedonia setup. |
| Full TFT | Non-noisy TFT with an introduction level plus 7 regular levels. | Default full TFT version. |

## Session Orders

When creating a user, you must select a session order. Each user type corresponds to specific session orders, so choose the correct one during user creation.

The current session orders shown in the UI are:

| Session Order | Levels Played | Virtual Player Strategy |
| --- | --- | --- |
| Default (No Custom Order) | 0, 1-6 | TFT |
| exp-competitive | 0, 21-27 | ProbibalisticTFT |
| test | 0, 28 × 7 | Alternate, Altruism, Cooperating |
| custom | 10, 5, 13 | ProbabilisticTFT, TFT, ProbabilisticTFT |
| Deaf-Version | 1-6 | TFT |
| FullTFT | 0, 1-7 | TFT |
| Macedonia - Anna | 0, 21-27 | ProbibalisticTFT |
| exp-felix-with-backgrounds | 0, 30-36 | - |
| exp-felix-one-background | 0, 13 × 7 | - |
| exp-felix-short | 0, 13 × 2 | - |

## Notes

If the user type or the session type changes in the game, update this page so the documentation stays aligned with the available options in the UI.
