---
layout: default
title: Runtime Flow
nav_order: 4
parent: AI & LLM Integration
---

# Runtime Flow

This document traces the step-by-step lifecycle of an AI-generated NPC response during live gameplay. It outlines how
the LLM integration touches the Game Client, Firestore, and GCP Backend interact from the moment the game loads to the
moment the child hears the NPC speak.

**If you make any changes regarding AI/LLM integration, please update the pages in this section accordingly.**

---

## Phase 1: Initialization and Config Loading

When a child logs into the game using their user code, the Game Client (Phaser) retrieves the user's data from the
backend. If their user was created with a Session Order that includes
[LLM Config]({% link docs/AI & LLM Integration/LLMConfig.md %}) (originally uploaded as a YAML file), it is included in
the user data and loaded as well as. The client holds this configuration in memory to evaluate future interactions.

## Phase 2: Context Committing

For the AI to generate a logical explanation, it needs to know what is happening in the game. At the start of, and
during each level, the Game Client commits game events to a dedicated GCP function (`storeDecisionContext`). This
function saves the state into the `decision-contexts` Firestore database. The Firestore DB can be inspected in the GCP
Console.

Data saved includes:

* Static level data:
  * User ID
  * Level Number
  * Session Number
  * The current NPC strategy (e.g., TFT)
  * Language and genders of the child and the NPC
* History of previous help requests and decisions (the `decisions` field). This is updated during the level on every
  request.

## Phase 3: The Help Request evaluation

At each request that the child makes to the NPC (each locked special coin), we want to evaluate the NPC's decision and
decide whether to use the AI or not. However, each call to the server (`generate-decision-explanation`) takes some time
because the LLM API (currently Gemini) takes a few seconds to respond. To minimize latency and improve the user
experience, we've introduced a preloading mechanism in the game client to fire the heavy server call in advance (a few
seconds before the locked coin appears and the child clicks the help button).
Then, when the coin appears, the NPC's generated response is ready to be displayed.

### Generated Explanation Preloading

The preloading mechanism happens in the game client (Phaser), specifically in `Level.js`. We introduced the
`PromiseHolder` class to hold the server call's Promise. Because requests in the game alternate between the NPC and the
child, and there is a fixed delay between each request (15 seconds), we have that much time to preload the response.

After a child request (NPC asks the child), we call the `preloadNPCExplanation` function. It calls the `shouldUseLLM`
function that uses the in-memory LLM configuration to determine whether the AI should be used. If the function returns
`true`, we fire a call to the `generate-decision-explanation` Cloud Function, and save its Promise in a `PromiseHolder`
object. If the function returns `false` we don't fire the request.

When the special coin appears and the child clicks the help button, we call the `humanAskForHelp` in the `VirtualPlayer`
class. It calls the `shouldUseLLM` function again. If it returns `false`, it displays the static response and audio.
Otherwise, it checks the `PromiseHolder` object to see if it has resolved already, or awaits it if not (although 15
seconds is almost always enough for the server to respond). Once it gets the response, it displays the text and audio
it got from the server (which the LLM generated). Note that upon any error, it falls back to the static response
(because it's preferred over crashing or not showing any response at all).

With that mechanism in place, the AI response is displayed instantly (in most cases) after the child clicks the help
button.

## Phase 4: Backend Processing (GCP & Gemini)

The `generate-decision-explanation` function receives the request payload containing the `user_id`, `level_num`,
`session_id`, the calculated `decision` and the `request_num` (request number 1 for the first request the NPC gets,
2 for the second, etc.).

1. **Context Retrieval:** The function queries the `decision-contexts` Firestore database to retrieve the live game
   state saved during Phase 2.
2. **Persona Extraction:** The function identifies the correct `persona` string based on the provided LLM config and the
   current request/level parameters.
3. **Prompt Construction:** The retrieved context (past events, strategy, genders) and the extracted persona are
   injected into the pre-defined system instruction templates (`INSTRUCTIONS_FILE` and `PROMPT_FILE`).
4. **LLM Generation:** The function calls the `GeminiTextProvider` to generate the textual response.
5. **TTS Generation:** The generated text is passed to the `GeminiAudioProvider` model to synthesize the spoken audio
   file.

_(More details about `generate-decision-explanation` can be found in its
[documentation]({% link docs/Backend/Functions/generate-decision-explanation.md %}))_

## Phase 5: Rendering and Playback

The Cloud Function returns a JSON payload to the Game Client containing the generated text string and a base64-encoded
string of the MP3 audio file. The Game Client decodes the audio and plays it through Phaser's audio engine.
The generated text is simultaneously rendered in a dialog box.
