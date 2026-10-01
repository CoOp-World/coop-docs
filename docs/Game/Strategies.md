---
layout: default
title: Virtual Player Strategies
nav_order: 3
parent: Game
---

# Virtual Player Strategies

A *strategy* decides how the virtual player (NPC) answers the human player's requests for help. Strategies are chosen per level (see [Users]({% link docs/Users/Summary.md %}) for the session orders that use them).

> **Provenance.** Migrated from two retired Notion pages: "Virtual Player Strategies" (Oct 2024, client developer) and "Built-in strategies" (Jan 2025, Group 1 therapist-interface team). Behaviour below is as documented there; verify against the client code before relying on a detail.

## Noisy TFT (ProbabilisticTFT) — the 70/30 rule

Confirmed by the project owner on 2026-10-01: **Noisy TFT is 70/30.** On the first request the virtual player gives a predefined "help" answer. On every later request it draws a random number in [0, 1]: below 0.7 it plays Tit-for-Tat (answers the way the human answered the virtual player's last request), otherwise it plays Reversed TFT (answers the opposite way).

The same strategy appears under different names: `ProbabilisticTFT` (client and session orders), "Noisy TFT" (documentation).

> **Unresolved naming/parameter conflict.** The Group 1 "Built-in strategies" spec (below) describes `NoisyTFT` with a configurable `noise` parameter defaulting to `0.1` (10% random choice). That does not match the 70/30 rule above. Treat the 0.1 default as unverified and check the strategies collection / therapist-interface code before using it.

## Strategies in the client (Oct 2024)

| Name | Behaviour |
|---|---|
| `ALLC` | Always accepts. |
| `ALLD` | Always declines. |
| `TFT` | Accepts the first request; afterwards answers the way the human answered the virtual player's last request. |
| `RANDOM` | Random answer. |
| `Alternate` | Accepts the first request, then alternates. Used only in the tutorial. |
| `ProbabilisticTFT` | See the 70/30 rule above. |
| `Delay`, `NoResponse` | Listed as "not relevant". |

### Values stored in the database

In `coop/levels`, each entry of `help_requests` has `chosen_virtual_strategy`. The values used to mark how an answer was produced are:

- `PREDEFINED_HELP` — the first request under TFT or Reversed TFT (predefined "help").
- `TFT` — answered by mirroring the human's last response.
- `REVERSED_TFT` — answered by reversing the human's last response.

The level-level field `virtual_strategy` holds the strategy name (for example `ProbabilisticTFT`). See [coop/levels]({% link docs/MongoDB/Collections/coop__levels.md %}) and the [strategies collection]({% link docs/MongoDB/Collections/strategies.md %}).

## Built-in strategy catalogue (Group 1 spec, Jan 2025)

Implemented for the therapist interface so that clinicians can configure different social scenarios. Each strategy decides how the virtual player responds to help requests.

| # | Strategy | Category | Behaviour | Parameters (default) |
|---|---|---|---|---|
| 1 | Noisy Tit for Tat (`NoisyTFT`) | Mirror | Mostly mirrors the child's previous action with occasional unpredictability. *See the conflict note above.* | `noise` (0.1, unverified) |
| 2 | Full Tit for Tat (`FullTFT`) | Mirror | Mirrors the child's previous action exactly. | none |
| 3 | TFT with Memory (`TFTWithMemory`) | Adaptive | Helps if the child has been more helpful than unhelpful overall; refuses if predominantly unhelpful. | none |
| 4 | TFT Refuses at End (`TFTRefusesAtEnd`) | Mirror | Mirrors throughout but always refuses on the final round. | `totalRounds` (5) |
| 5 | Altruism | Predictable | Always helps. | none |
| 6 | Cooperating | Adaptive | Starts with a high probability of helping and lowers it each time the child refuses. | `initialProbability` (0.8), `decreaseStep` (0.2) |
| 7 | Refusing | Adaptive | Starts with a low probability of helping and raises it each time the child helps. | `initialProbability` (0.2), `increaseStep` (0.2) |
| 8 | Egoism | Predictable | Always refuses. | none |
| 9 | Moving Window | Adaptive | Weighs only the most recent interactions; helps if the weighted score is non-negative. | `windowSize` (3), `weights` ([3, 2, 1], most recent first) |
| 10 | Random | Random | Helps with a fixed probability regardless of the child. | `probability` (0.5) |
| 11 | Reverse TFT (`ReverseTFT`) | Mirror | Does the opposite of the child's previous action, after refusing in the first round. | none |
| 12 | Alternate | Predictable | Alternates help/refuse starting with help, regardless of the child. | none |

Categories: **Mirror** (NoisyTFT, FullTFT, TFTRefusesAtEnd, ReverseTFT), **Adaptive** (TFTWithMemory, Cooperating, Refusing, Moving Window), **Predictable** (Altruism, Egoism, Alternate), **Random** (Random).

### Implementation notes (from the spec)

- All strategies inherit from a base `Strategy` class and can be created through a `StrategyFactory`.
- Descriptions and parameter names are centralised in one file for localisation (they are stored with translations in the `strategies` collection).
- Most strategies support `reset()` to return to their initial state.
- Every strategy implements `answer()` (decide whether to help) and `updateLastResponse()` (record the human's decision).
