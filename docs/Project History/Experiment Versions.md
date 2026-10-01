---
layout: default
title: Experiment Versions
nav_order: 3
parent: Project History
---

# Experiment Versions (Oct 2024 – Apr 2025)

## Policy: one frozen version per experiment

Decided Dec 2024. For every experiment that starts, the system is given a version number. The version is uploaded to GCP Cloud Run under that version's name and handed to the experiment team, disconnected from continuing development; a new development line is opened. After the experiment and its analysis are finished, the version is removed from Cloud Run.

This is the origin of the per-experiment production branches (`prod-*`); see [Version Creation]({% link docs/Game/Versions/Version Creation.md %}) for the current branching procedure.

## Version table (Dec 2024 – Mar 2025)

| Experiment | Version |
|---|---|
| Deaf | 1.0.0 |
| Autistic | 1.0.1 |
| Group 3 | 1.0.2 |
| Felix | 1.1.0 |

Version `1.0.0` was described as "the version with sign-language possibility, the text is in the image, with sessions". There is no later version log.

## Early websites and level ranges (Apr 2025)

A snapshot from the main developer's "GCP websites" check list. Test user IDs are omitted. Level ranges here are older than the current [Versions Summary]({% link docs/Game/Versions/Summary.md %}), which is authoritative.

| Website | Description | Levels in Apr 2025 |
|---|---|---|
| co-op-client | Deaf version | 0–10 |
| co-op-client-dev | Dev | 0–10 |
| exp-autistic | Autistic | 0–10 |
| exp-competitive | Competitive | 0, 17–19, 21–27 |
| exp-felix | Felix | 0, 11–13 |
| felix-test-gap-speed | Interface for Felix to change coin gap and virtual-player speed | 16 |
| g3-dev | Group 3 dev | 14–15 |
| g1-dev | Group 1 dev | 20 |

The Felix `0, 11–13` range is the earlier training sequence referred to in [Felix]({% link docs/Game/Versions/Felix.md %}); the current `sessions.json` has no matching session order.
