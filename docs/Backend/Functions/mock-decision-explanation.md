---
layout: default
title: mock-decision-explanation
parent: Functions
grand_parent: Backend
nav_order: 26.5
---

# `mock-decision-explanation` Function

## 🔗 Name and URL

- **Function Name:** `mock-decision-explanation`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/mock-decision-explanation`

## 🛠️ What the Function Is Doing

The function is used in the [User Management]({% link /docs/Addons/User%20Management.md %}) website to test and simulate
NPC personas. Instead of creating test users and running the actual game, this function accepts mock game data and
generates an explanation that would have been shown to the player. It currently uses the Gemini API to return a text
explanation and an optional audio response.

This function and `generate-decision-explanation` share the same goal, but this function is used to test personas and
simulate AI responses, while the other is used inside the actual game by the frontend.

### Shared Modules & Deployment

This function utilizes [Shared Modules]({% link /docs/Backend/SharedModules.md %}), specifically `decision_explanation`
and `validation`, located in the `shared` folder. The `validation` module is used to validate the function's parameters,
and the `decision_explanation`module contains the Text and Audio generation framework.

### Environment Variables

The function requires several environment variables to control the AI models and prompt paths:

* **`GEMINI_TEXT_MODEL`** (e.g., `gemini-3.5-flash`): Defines the text generation model.
* **`GEMINI_AUDIO_MODEL`** (e.g., `gemini-2.5-flash-tts`): Defines the Text-to-Speech generation model.
* **`INSTRUCTIONS_FILE` / `PROMPT_FILE`**: File paths to the template `.txt` files used to construct the system
  instructions and user prompts.

**Note:** Because this function and `generate-decision-explanation` are both used to generate AI-generated responses of 
the virual player, just on different parts of the system, they have to use the same models and prompts so their 
behaviors will be consistent.
This is why their environment variables should be the same, as well as the LLM Providers they use.

## 📥 Expected Input

### Supported methods:

- `POST`

### JSON body parameters

- `llm_persona` _string_ (optional): The persona to use for generation. In case it's not provided, a default, hardcoded
  persona is used.
- `events` _list_ (optional): A list of recent events formatted as `{askerType: string, decision: boolean}`.
  The function truncates this to the last 10 events. Defaults to an empty list.
- `decision` _boolean_ (required): The current decision of the NPC (`true` for help, `false` for reject).
- `human_gender` _string_ (optional): Default is `"male"`. Must be `"male"` or `"female"`.
- `virtual_gender` _string_ (optional): Default is `"male"`. Must be `"male"` or `"female"`.
- `strategy` _string_ (optional): The applied strategy name (e.g., TFT). Default is `"unknown"`.
- `language` _string_ (optional): Represents the language of the child user. Default is `"English"`.
- `include_audio` _boolean_ (optional): Whether to generate and include an audio file in the response. Default is `false`.

### Example request body

```json
{
  "decision": true,
  "llm_persona": "You are a grumpy but ultimately helpful wizard.",
  "events": [
    {"askerType": "human", "decision": true},
    {"askerType": "npc", "decision": false}
  ],
  "human_gender": "female",
  "virtual_gender": "male",
  "strategy": "TFT",
  "language": "English",
  "include_audio": true
}
```

## 🔄 How It’s Used in the System

This function acts as a standalone testing utility within the User Management dashboard. When we want to test how a
specific persona or scenario behaves, the dashboard sends a request to this function with the mocked parameters,
simulating a request being sent during a real game.

The function processes the request by:
1. Validating the incoming mock parameters using the `shared.validation` module.
2. Preparing and formatting the context dictionary.
3. Injecting the context data (strategy, genders, language, llm_persona, decision, events) into the placeholders of the
   `INSTRUCTIONS_FILE` and `PROMPT_FILE` templates.
4. Calling the Gemini Text API (`GeminiTextProvider`) to generate the NPC's text response.
5. If `include_audio` is `true`, calling the Gemini TTS API (`GeminiAudioProvider`) to generate audio of the response.
6. Returning the generated text and audio to the client.

### Example Successful Response

Upon success, the function returns the text explanation and the audio file (if requested).

If audio is requested, it is returned as MP3, base64-encoded string. If audio was not requested, or there was an error 
generating it, `audio` will be `null`.

```json
{
  "text": "Fine, I will help you this time. But only because you assisted me earlier.",
  "audio": "<base64_encoded_audio_string>"
}
```



