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

The function is used by the ML-discourse version of the game. It replaces the static NPC (the virtual player) messages when the user asks it for help. In the regular version, the NPC answers with "I can/can't help" each time. This replaces that by generating the explanation for the NPC's decision using ChatGPT API.

The function accepts `user_id`, `level_num` and `session_id` of the current level played. With that, it accesses the temporary saved data on Firestore to get relevant game context, sends that context to ChatGPT API to get the generated explanation, which is returned to the client as a response.

## 📥 Expected Input

### Supported methods:

- `POST`

### JSON body parameters

- `user_id` _string_: The user ID of the player in the current session.
- `level_num` _string_: The number of the current level being played, zero-based (e.g. for level 1 it's 0, level 2 is 1, etc.)
- `session_id` _string_: ID of the current session.
- `decision` _string_: The NPC's decision of the current user request for help. `"acc"` if willing to help, `"rej"` if rejected.
- `is_debug` _bool_ (optional): Provide this with a `true` value to get static mesages while debugging. It skips calling GPT API and is used to make sure that the connection with the cloud function is correct. Should not be used in production and will probably be removed later.

### Example rquest body

```json
{
  "user_id": "1234",
  "level_num": "1",
  "session_id": "1234567890123_67a01bc",
  "decision": "acc",
  "is_debug": true // this line should be omitted in production
}
```

## 🔄 How It’s Used in the System

Each time the user asks the NPC for help, the strategy decides whether to help or not. Then, a request is sent from the client to this function with the above fields. `decision` is the decision made by the strategy.

The function uses the user_id, level_num and session_id to get the relevant document from the `decision-contexts` Firestore database, builds a prompt and sends a request to GPT API. Finally, if no errors occurred, it returns the GPT's response back to the client.

### Example Successful Response

Upon success:

```json
{
  "explanation": "I need to save my ice cubes since I helped you last time and you didn't help me before."
}
```

With `is_debug` on:

```json
{
  "is_debug": true,
  "explanation": "I will help you."
}
```
