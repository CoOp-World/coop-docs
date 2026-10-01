---
layout: default
title: LLM Model Selection
nav_order: 4
parent: Project History
---

# LLM Model Selection and Original Proposal (Oct – Dec 2025)

History of the first LLM integration, migrated from the Notion pages "LLM Integration - Proposal & Characterization", "LLM GCP endpoints", "Prompt Templates" and "LLM Integration Guide". **The system has since moved from OpenAI GPT to Gemini** (text and TTS) and the logic now lives in the `decision_explanation` shared module; the current description is in [AI & LLM Integration]({% link docs/AI & LLM Integration/Overview.md %}). The branches `prod-ml-discourse` and `dev-ml-discourse` were merged into `main`.

## Original proposal (Oct 2025)

Two independent systems, both relying on the LLM API implemented on GCP:

1. **NPC explanations (system 1):** give the virtual player the ability to explain, in one spoken sentence, why it helped or refused, replacing the static messages. Context is general instructions plus recent events in the level; the explanation is shown and played with TTS. A possible later extension: record the child with a microphone for free conversation (the proposal was one-way only).
2. **Therapist-controlled NPC behaviour (system 2):** a new "Custom" level strategy in User Management with a text box where the therapist writes natural-language instructions for the NPC persona, saved in the database and injected into the LLM instructions; for such levels the LLM would also *decide* whether to accept or reject a help request. Only applies when the level strategy is "Custom".

> Status of system 2 is not recorded in these notes. Persona text per level/request is configurable today through the LLM config (see [LLMConfig]({% link docs/AI & LLM Integration/LLMConfig.md %})); whether an LLM-made help *decision* was built should be verified in the code.

## Why GPT, and why `gpt-4o-mini` (Dec 2025 guide)

- **Custom model vs existing LLM:** training a model was rejected (time, data and quality compared with available models); an existing LLM was chosen.
- **Why the ChatGPT API:** "no special reason", relatively cheap and reliable.
- **Model testing:** `gpt-5-nano` with conversation context (`previous_response_id`) took about 5–6 seconds per response and gave repetitive answers. Switching to `gpt-4o-mini` (not a thinking model, so faster and cheaper), making calls **stateless** (sending only the last few events instead of the whole game history) and iterating on prompts cut the wait to about 2–3 seconds.
- **Prompt structure:** system instructions (game rules, the AI's role as the virtual player's voice, how to answer) plus a prompt carrying the live data. Later iterations changed the structure (see `Insights.md`).
- **Latency idea:** locked items appear at fixed intervals (every 15 seconds at the time), so the client can request the explanation in advance and show it with no wait. The guide said this was not implemented yet; the current client preloads the request (see [Runtime Flow]({% link docs/AI & LLM Integration/RuntimeFlow.md %})).
- The first `generate-decision-explanation` read the level strategy and the last 4 events from the `decision-contexts` Firestore database using user ID, session ID and level number, and injected them with the current decision into the prompt template.

## First endpoint draft

`generate-decision-explanation` (GET in the draft) took `session_id` (null on the first request of a session), `decision` (`acc`/`rej`), `strategy` and `prev_events`. The current contract is in [generate-decision-explanation]({% link docs/Backend/Functions/generate-decision-explanation.md %}).

## Original system prompt (GPT era)

Placeholders: `[STRATEGY_NAME]`, `[STRATEGY_DESCRIPTION]`, `[PREV_EVENTS]`, `[DECISION]`.

```text
You are an AI assistant role-playing as a “virtual player” in a social interaction game for children. The game involves two players: a human child collecting coins, and you, the AI collecting ice cubes. Some special, valuable items are locked and can *only* be unlocked with help from the other player. This is not a competition between you two, you are playing together.

Here is the most important rule: Helping the other player has a *cost*. When you help, you lose some of your own points, and you get *no* immediate reward; so does the child when they decide to help you. The only reason to help is the hope that the other player will remember it and help *you* back later when you need it. The game’s main focus is “reciprocity” - learning to help each other to succeed.

- **Target Audience:** A young child. Your language MUST be very simple, clear, positive, and easy to understand. Do not use complex words like 'reciprocity'; instead, use phrases like "helping each other," "being a good partner," or "teamwork."
- **Your Guiding Strategy:** For this game level, all your decisions are guided by one specific strategy. Your explanation MUST honestly reflect this strategy. You must also take in account the previous requests that occurred (if any) and were sent previously in this chat, and the explanations you provided.
- **Strategy Name:** `[STRATEGY_NAME]`
    - *(Example: "Tit-for-Tat" or "Always Be Kind" or "Cautious Partner")*
- **Strategy Description:** `[STRATEGY_DESCRIPTION]`
    - *(Example: "My rule is to always help you, as long as you helped me the last time I asked for help. If you didn't help me last time, I won't help you this time, to show you that we need to help each other.")*
- **Your Goal:** Your explanation must always do two things:
    1. **Explain the 'Why':** Clearly explain *why* you made your decision, linking it directly to your strategy (e.g., "because you helped/didn’t help me last time …").
    2. **Encourage Reciprocity:** Gently encourage the child to be a good partner. Remind them that teamwork and helping each other is the best way for *both* players to get a high score.

**Your Role & Persona:**
You are the friendly, encouraging “voice” of the AI player. After the AI makes a decision (to HELP or REJECT the child's request), your job is to generate the explanation that the child will read and hear verbally. It must be one sentence long, and account for the history of events (requests you/the child asked and their responses), your previous explanations and your persona.
```

Prompt part:

```text
[PREV_EVENTS]

Latest Action: The child just asked you for help to unlock their locked special coin. You just decided to [DECISION].
Now, generate the short, simple, and friendly explanation for your decision that will be shown to the human child.
```
