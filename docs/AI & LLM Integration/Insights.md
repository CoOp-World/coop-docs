---
layout: default
title: Insights & Maintenance
nav_order: 5
parent: AI & LLM Integration
---

# Insights & Maintenance
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

This page centralizes knowledge and insights regarding AI & LLM integration in the system. It documents the reasoning
behind key architectural decisions, the hurdles encountered during development, and the maintenance workflows required
to keep AI-related components running smoothly.

If you are a future developer taking over this project, read this page before altering the LLM logic or updating models.
You might save time and headaches. Keep in mind that things written here are correct as of the time of writing, so they
might not be the most up to date. You are also welcome to expand this and the other pages with ideas and insights you
got when working.

## The Switch from GPT to Gemini

Initially, the system used GPT models for generating the text explanations. However, a strategic decision
was made to migrate entirely to Gemini, as we wanted to use its TTS models too.

Why we made the switch:

* **Ecosystem Unification:** We needed high-quality Text-to-Speech (TTS) alongside text generation. Keeping both the
  text and
  audio models within the same LLM type (Gemini) made it easier.
* **Performance:** We noticed that some lightweight GPT models answered fast, but their answers were pretty repetitive
  and not diverse enough. Gemini appeared to be pretty good at creative and diverse responses. The caviate was that
  for some reason Gemini took a long time to respond compared to GPT (that's where the preloading mechanism came in).
* **Future-Proofing for Multimodal:** Gemini appears to plan having models that can output text and audio in a single
  API call. By migrating now, the infrastructure is prepped to adopt a single-call text/audio model as soon as one
  becomes available, which will cut latency even further. Note that currently we do have to make two separate API calls
  to get the text and audio, but thanks to preloading, it managed to return in time so the user experience feels
  instant.

## Working with Gemini and LLMs

* **Context Window & Cost:** Both GPT and Gemini have caching mechanisms. It means that if the system instructions
  remain the same across multiple calls, the API caches the instructions tokens. This reduces the cost and latency of
  the API calls. However, currently our instructions are not cached, mainly because they are too short (each model has
  its own min token limit for caching). More info about caching in
  Gemini [here](https://ai.google.dev/gemini-api/docs/caching).

* **Upgrade Backend Infrastructure:** The `generate-decision-explanation` Cloud Function wasn't structured very well
  when GPT was used. Transitioning to Gemini required restructuring many parts of the code to switch to the new API.
  We took the opportunity to refactor the entire function's infrastructure to be more modular and maintainable.
  Most of the code was transferred to the `decision_explanation` [Shared Module]({% link docs/Backend/SharedModules.md %}).
  In addition, text and audio generation logic was extracted to abstract classes `LLMTextProvider` and
  `LLMAudioProvider` respectively. That way, switching a text or audio model is as simple as creating a new class
  that implements `LLMTextProvider` or `LLMAudioProvider`. Many helpers and helper services were also extracted to
  make the code more modular. Becuse both `generate-decision-explanation` and `mock-decision-explanation` use the same
  LLM logic, they just call methods from the Shared Module, and the main file is kept clean and short.

## Prompt Engineering & Tone Adjustments

Getting an LLM to sound like a natural and human requires extensive trial and error. The prompts where re-written and
revised multiple times. Below is a summary of what worked and what didn't, but you are encouraged to look in the prompts
themselves in the `decision_explanation` Shared Module in the Cloud Functions repo
(`CloudFUnctions/shared/decision_explanation/prompts/`).

### What Worked
{: .no_toc }

* Explain the game rules, context, and the AI's role clearly and concisely. It's good to start the instructions with
  a sentence that sets the role of the AI, like "You are the voice of a virtual player ...".
* Define clear DO and DON'T rules. It's important to define what the AI CAN do and not just give restrictions. Strict
  rules you may use are limit the AI to one short sentence, natural language, simple language, etc.
* Instruct it precisely how to treat the persona and how it affects its responses.

### What Didn't Work
{: .no_toc }

* Sometimes it was "too creative" and deviated from the intended language. For example, it once used nicknames like
  "buddy" and "pal" to refer to the child, which we didn't want. Sometimes rephrasing the instructions helped.
  but sometimes you may need to prohibit this explicitly in the instructions.
* Sometimes its responses weren't diverse enough. The reason for that may be too many restrictions in the instructions.
  It's important to not restrict it too much and give it some room for creativity; it can cause it to give repetitive
  responses. In addition, the instructions shouldn't dictate too much HOW it should respond; this is the role of the
  persona and the LLM itself.

## Update and Maintain Models

As new LLM models gets released and updated, the old ones eventually get deprecated in the API (this is true for every
LLM, not just Gemini). You may get an email notification from the company itself, notifying you of the deprecation, but
you need to keep an eye on the official documentation to make sure you are not caught off guard.

When upgrading to a new model, do not just blindly increment the version number in `config.json`. Updating models, at
least in Vertex AI (what is used now for Gemini), requires verifying regional availability and SDK compatibility.

When a new Gemini model is released (e.g., moving from `gemini-3.5-flash` to a newer version), follow these steps:

1. **Check Regional Availability:** Not all models are available in all regions immediately upon release. Check the
   [official model availability documentation](https://docs.cloud.google.com/gemini-enterprise-agent-platform/resources/locations)
   to ensure the target model is available in our deployed region. It's preferred that the region will be the same or as
   close as possible to the region of the cloud function (`europe-central2`). Sometimes models are first launched in
   "multi region" regions, like `eu` instead of specific regions in Europe. Multi regions have different API endpoints
   that require some minor modifications to the Vertex AI Client initialization.

   If a new model is only available in a specific region, you must update the `location` parameter in the `Client()`
   initialization inside `main.py`, and potentially the `http_options={"base_url": ...}` if routing through a specific
   regional endpoint.

   If you get stuck or if a model isn't working (e.g., the API call returns 404) you can google it or ask help from your
   favorite LLM. Just keep region availability in mind.

2. **Verify Recommended Upgrade Paths:** As said before, Google and other companies occasionally deprecate older
   models. Always check official documentation to see if there are any recommended models to upgrade to from your
   current model. For example, from `gemini-2.5-flash` it is recommended to upgrade to `gemini-3.5-flash` or
   `gemini-3.5-flash-lite` according to Google's documentation. So check what is the recommended model to upgrade to
   from your current model.

   In addition, check official documentation to see if there are specific migration guides or parameter
   changes required for the new model (like a new way to configure thinking level).

3. **Test Before Deploying:** When upgrading a model, test its performance - responses and response times, to make sure
   it's working as expected and similar to the old model so the game's experience won't change significantly. Only
   when you're sure that the new model is working as expected, you can deploy it.

## Supporting New Languages

If you want to support more languages in the game and in LLM responses in particular, the system must be updated to
support that. Languages are saved on user creation when you create users in the User Management website. When a user
enters the game, the game client loads the user data along with the user's language, and that is used to display
language-specific sprites and voice recordings in the game, but also used in the backend to generate LLM responses in
that language.

### 1. Update Cloud Functions
{: .no_toc }

In the `CloudFunctions` repo, in `shared/decision_explanation/providers/llm_audio_provider/gemini_audio_provider.py`,
under the `GeminiAudioProvider` class you'll see two maps related to languages: `VoiceMap` and `LanguageToCodeMap`.
* `LanguageToCodeMap` maps between language name (what is used in the User Management website and what is saved in the
  DB) and the language code. For example, "English" → "en-us". Add an entry with the new language and its code.

  The language must be supported by the Gemini TTS model that the backend uses (model names are in the cloud function's
  `config.json` file). You may visit [this website](https://docs.cloud.google.com/text-to-speech/docs/gemini-tts)
  for the list of supported languages by model. Check the language code of the language you want to support.
* `VoiceMap` maps between language code and voice names to be used in Gemini TTS. It allows us to have different voices
  for each language and gender.
  Add an entry with the new language code and two male and female voice names. Gemini's voice names can be found
  [here](https://ai.google.dev/gemini-api/docs/speech-generation#voices).
  You can also listen to each voice before deciding,
  [here](https://docs.cloud.google.com/text-to-speech/docs/gemini-tts#voice_options).

  Note that the language and gender are resolved dynamically at runtime. When creating users, you set their language
  via the dropdown. When a new user enters the game, they are prompted to choose their gender and virtual gender
  (NPC's gender). Those are saved as strings "male" or "female" and the _virtual gender_ is used here to resolve the
  voice name that we give to Gemini TTS.

It is important that the language name and code you define in those maps will match the ones defined in the User
Management website and the language codes that Gemini supports. The code passes the language **code** to the Gemini TTS
API, and the prompts we give to the text model instruct it to answer in the desired language (it gives it the language
**name** saved in the DB), so any mismatch will cause an error or an unexpected response.

### 2. Update User Management website
{: .no_toc }

In the User Management website, in the main tab `Create Users`, there is a `Language` dropdown that contains all the
supported languages for creating users. Add the new language to the list in the code.

It is also recommended to add the language to the `Prompt Playground` tab (there is a `Language` dropdown there too),
so you can also test the LLM responses in that language.

As said, the language name you put here must match the one you put in the `LanguageToCodeMap` map in the cloud function.
The language name is also what the code passes, as it is, to Gemini when instructing it in what language to answer.

### 3. Game Client (optional)
{: .no_toc }

The game client displays sprites and voice recordings in multiple languages. It's important to know that the game
automatically detects the language based on location (and not from the user's saved language). Thus, when adding a new
language for LLM responses, the game shouldn't break as it uses its own auto-resolved **display language** for
displaying sprites and messages. However, if you want to support a new **display language** in the game, it involves
messing with the `i18next` library and adding new sprites and recordings in the appropriate language. There is some
work there and it has to be done carefully.

### 4. Testing in Prompt Playground (optional)
{: .no_toc }

When updating languages or making any change to the LLM infrastructure, it is important to test them before pushing them
to the main game. The two recommended ways to test are either running/debugging locally, or testing in the Prompt
Playground on the User Management website.

An extended guide about using the Prompt Playground can be found
[here]({% link docs/Addons/User Management.md %}#-prompt-playground).

## Known Limitations & Future Upgrades

### Two-Step Latency
{: .no_toc }

As mentioned, we are currently bound by the latency of sequential calls (Text -> Audio). The game client handles this
by preloading the server call, so it has plenty of time to respond, and the user sees it instantly.

Keep an eye on Gemini release notes for unified text and audio endpoints to resolve this. It should significantly
improve latency and cost.

### Game Expansion
{: .no_toc }

If more events are added to the game, you might want to let the LLM that responds in behalf of the NPC to know about
them. It will allow the AI to have more reasons and explanations to generate, but you will need to update the code
(and maybe prompts) to make it work.

Maybe the LLM-related code can be upgraded so events will be modularized so it will be easy to feed the LLM with
different kinds of game events.

### Voice Commands
{: .no_toc }

Currently, the "persona" are instructions that are given only for the text generation model. With Gemini TTS it is
possible to give instructions to the TTS model as well. They make it very easy to control various things like tone and
voice when requesting audio synthesizing. This means that we can have a "voice persona" that controls the was it speaks
the generated explanations.
