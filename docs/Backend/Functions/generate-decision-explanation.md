---
layout: default
title: generate-decision-explanation
parent: Functions
grand_parent: Backend
nav_order: 22.5
---

# `generate-decision-explanation` Function

## 🔗 Name and URL

- **Function Name:** `generate-decision-explanation`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/generate-decision-explanation`

## 🛠️ What the Function Is Doing

The function is used in the game itself to get AI-generated responses on behalf of the virtual player (NPC) to the
child's requests for help. The decision of when to use the static messages or the AI-generated explanation is made by
the game itself at frontend (more on that in the LLM section). If it decides to use a generated explanation, it sends a
request to this function with the relevant data.

The function accepts session identifiers, fetches the game context saved in Firestore that corresponds to the caller's
current session, and evaluates LLM configurations (like persona adjustments). It then constructs a prompt to generate a
text explanation via Gemini, subsequently passing that text to a Gemini TTS model to generate a matching audio to the
text response. Both text and audio are returned to the client.

## Shared Modules & Deployment

This function relies on Shared Modules (`decision_explanation` and `validation`) located in the repository's `shared`
folder. More on that in the [Shared Modules section)]({% link /docs/Backend/SharedModules.md %}).

Note that the Shared Module defines base abstract classes `LLMTextProvider` and `LLMAudioProvider` for text and audio
generation, respectively. This is so switching between different LLM providers will be as simple as creating new
implementations of these abstract classes. Currently, the Gemini API is used for both text and audio generation, with
the `GeminiTextProvider` and `GeminiAudioProvider` classes that inherit from the base provider classes.

## Environment Variables

The function's behavior is configurable via environment variables defined in its config.json:

* `GEMINI_TEXT_MODEL` (e.g., `gemini-3.5-flash`): Specifies the text generation model.
* `GEMINI_AUDIO_MODEL` (e.g., `gemini-2.5-flash-tts`): Specifies the Text-to-Speech generation model.
* `INSTRUCTIONS_FILE` / `PROMPT_FILE`: Paths to the `.txt` templates used to construct the system instructions and user
  prompts dynamically.
* `FIRESTORE_DATABASE` / `FIRESTORE_COLLECTION`: Define where the session contexts are stored and retrieved from.
  Currently points to our `decision-contexts` Firestore database, which is updated mid-game with game events that this
  function is using.

## 📥 Expected Input

### Supported methods:

- `POST`

### JSON body parameters

- `user_id` _string_: The user ID of the player in the current session.
- `level_num` _string_: The number of the current level being played, zero-based (e.g. for level 1 it's 0, level 2 is
  1). Must be non-negative.
- `session_id` _string_: ID of the current session.
- `decision` _boolean_: The NPC's decision regarding the current user request for help (`true` if willing to help,
  `false` if rejected).
- `request_num` _integer_ (optional): The sequential number of the current request. Used to fetch specific persona
  configurations if defined in the level's LLM config.
- `is_debug` _boolean_ (optional, default `false`): Provide this with a `true` value to bypass the Gemini API call and
  receive static dummy messages. Used for debugging connections. Should not be used in production.

### Example request body

```json
{
  "user_id": "1234",
  "level_num": 1,
  "session_id": "1234567890123_67a01bc",
  "decision": true,
  "request_num": 2,
  "is_debug": false
}
```

## 🔄 How It’s Used in the System

Each time the user asks the NPC for help, the game's strategy decides whether to accept or reject the request.
The client then checks in the level's LLM config (if it exists) if it should use a generated explanation for the current
NPC's request. If so, it sends a `POST` request to this function with the decision and session details.

The function operates in the following sequence:

1. Validates the incoming parameters using the injected `shared.validation` module.
2. Queries the `decision_contexts` Firestore database using this document ID: `{user_id}_{level_num}_{session_id}`.
3. Retrieves game context from that document (e.g., past events, strategy, language, genders) and determines the
   appropriate virtual persona.
4. Replaces placeholders in the `INSTRUCTIONS_FILE` and `PROMPT_FILE` templates with the retrieved context.
5. Calls the Gemini Text API (`GeminiTextProvider`) to generate the NPC's text response.
6. Calls the Gemini TTS API (`GeminiAudioProvider`) to generate audio of the response.
7. Returns both the text and audio payload to the client.

### Example Successful Response

Upon success, the payload will contain the generated text and the encoded audio.
The audio file is a MP3, base64-encoded string.

**Note:** If audio generation fails, no error is returned. `audio` will be `null` in the response, and only the text
response will be returned. This is because audio is not as important as the text itself, and to avoid unnecessary
fallback to the default response.

```json
{
  "text": "I need to save my ice cubes since I helped you last time and you didn't help me before.",
  "audio": "<base64_encoded_audio_string>",
  "is_debug": false
}
```

With `is_debug` on:

```json
{
  "text": "I will help you.",
  "audio": null,
  "is_debug": true
}
```
