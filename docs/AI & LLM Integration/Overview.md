---
layout: default
title: Overview
nav_order: 1
parent: AI & LLM Integration
---

# Overview

This page overviews how AI & LLMs are integrated in the system, briefing through their usage in the system. The other
pages in this section expand on that in detail.

**If you make any changes regarding AI/LLM integration, please update the pages in this section accordingly.**

## Introduction

Previously, the virtual player (NPC) responded to help requests using static, pre-recorded audio and
text (e.g., "I agree to help" or "Sorry, I cannot help").

Using LLMs, we upgraded these static responses with dynamically generated text and audio, currently powered by Gemini
API. This allows the NPC to have specific, customizable responses using custom "personas", opening up new experimental
avenues.

It allows testing how a child's cooperative behavior changes depending on whether the NPC sounds scared, impatient,
cheerful, selfish, etc. Personas allow not only setting the tone of the NPC's responses, but also how it reacts to
different situations (e.g., we can tell it that if it helped the child more than the child helped itself, it will
mention it if it refuses to help).

The use of LLM-generated responses is dynamic, meaning we can control when we want LLM responses and when we want the
static responses. It's done by providing an LLM configuration file when creating custom session orders in
the [User Management website]({% link docs/Addons/User Management.md %}). There are thorough explanations about
the [LLM Config]({% link docs/AI & LLM Integration/LLMConfig.md %}) and the
[Runtime Flow]({% link docs/AI & LLM Integration/RuntimeFlow.md %}) in the appropriate pages.

---

## Core Architecture

The integration touches several systems:

* **User Management Website:** The starting point. You can upload an LLM Configuration (YAML) file when
  creating a custom "Session Order". The website parses this file and saves it in MongoDB alongside the user data.
* **Game Client (Phaser Frontend):** When the user logs in, the game loads the LLM configuration that is saved in the
  user's data. It is responsible for checking if an AI response should be triggered for a specific level or request (the
  LLM config dictates that), playing the resulting audio, and rendering the text.
* **Context Storage (Firestore):** A dedicated database (`decision-contexts`) that holds the live state of the game. The
  game client continuously commits events (like past help requests, the strategy in use, and genders) to this database
  so the backend has the context needed to prompt the AI.
* **GCP Backend Functions:** Cloud Functions (specifically `generate-decision-explanation`) act as the bridge. They
  receive a trigger from the game client, pull the level's context from Firestore, apply the correct persona from the
  LLM config, and communicate with the Gemini Text and Audio APIs to generate the final response.

---

## Maintenance (Important)

Currently, the generated responses are powered by Gemini text and TTS models. The models are updated periodically,
and as a result, old models are getting deprecated (for example, with the launch of Gemini 3 series, series 2.5 is
getting deprecated a few months afterward). That's why we need to keep an eye on the models and update them in the
appropriate Cloud Functions. Currently, the relevant functions are `generate-decision-explanation` and
`mock-decision-explanation`. The models they use are defined as ENV variables in `config.json`.

**Model updates need to be done with care**, it's not just changing version numbers.
More details and insights about updating the models can be found in the
[Insights Page]({% link docs/AI & LLM Integration/Insights.md %})
