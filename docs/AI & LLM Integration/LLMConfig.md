---
layout: default
title: LLM Configuration
nav_order: 2
parent: AI & LLM Integration
---

# LLM Configuration

## Introduction

The LLM Configuration is a YAML file that controls exactly **when** the game should use AI-generated response for the
NPC, and **what persona** to use. It is uploaded via the User Management website when creating a custom Session Order.

This configuration is written in the **YAML** file format, a highly readable data format even for non-programmers.
This page aims to explain the structure of the config file even for non-programmers.

A template config file can be downloaded in the User Management website: tick the "Use Custom Sessions?" checkbox,
then tick "Use LLM-generated explanations", then press "Download template".

### YAML Basic Rules (for non-programmers)

YAML has formatting rules you must follow for the code to understand it.
It essentially uses indentation (spaces) to define categories and subcategories. In our context, we have a hierarchy
of sessions, levels, and requests. The indentations tell the code which levels are under which session, and what
requests are under which level.

1. **Indentation:** YAML uses indentation to understand the hierarchy (what belongs inside what).
   Every indentation is **2 spaces**. For example, if `levels:` is indented under a session, it will be 2 spaces more;
   that way the code knows those levels belong to that specific session.
2. **Comments (`#`):** Any line that starts with a hashtag (`#`) is a **comment**. The code completely ignores these
   lines. They are purely notes for you or others to explain what a section does. The template file contains many
   comments, for better explanation.
3. **Multi-line Text (`|`):** When writing a `persona`, you usually want to write multiple sentences. Use the pipe
   symbol (`|`) after `persona:` and press Enter. Then, indent the next lines to write your paragraph. The template
   file contains examples of this.

---

## Structure and UI Alignment

The structure of the YAML file perfectly mirrors the user interface of the User Management website used to build Session
Orders.

* **Sessions:** Represent the different sessions/meetings with the child. In the YAML, `session_number` corresponds
  directly to the session block in the UI.
* **Levels:** Belong to a specific session. The `level_number` in the YAML corresponds strictly to the **"Level Index In
  Session"** field in the UI (which dictates the order the levels are played), not the "Level Identifier" (which map is
  loaded).
* **Requests:** Each request within a level corresponds to a request that the NPC gets in that level. The
  `request_number` in the YAML is the request number of a request that the NPC gets (e.g., request 1 is the first time
  the child asks for help, request 2 is the second time).

## The Fallback Hierarchy

No field in the YAML file is strictly mandatory. The system uses a "fallback" mechanism. If a specific behavior is not
defined for a given moment, the system looks up the chain to find the nearest definition. Despite that, it is highly
recommended to define all fields to prevent unexpected game behavior (for example, you might forget to define a
`persona` field for a level and another unintended persona will be used instead according to the fallback hierarchy).

The hierarchy flows from specific to broad:

**Request** -> **Level** -> **Session** -> **Global Defaults** -> **Hardcoded Server Defaults**

For example, if you define a certain persona at the Session level, all levels within that session will use that persona
unless a specific level overrides it with something else.

---

## How to Build a Config File: A Step-by-Step Example

Let's say you built a Session Order in the UI with two sessions.
* **Session 1:** Has 2 levels. You want the first level to use standard static responses (without LLM). You want the
  second level to use AI with a single "friendly" persona.
* **Session 2:** Has 1 level. You want the AI to change its mood every time the child asks for help (different persona
  per request).

Here is how you would structure a config file for this. Notice the comment lines starting with `#` and the indentations.

**Note:** The personas used here are just examples and are not written well. A guide on how to write a good persona can
be found on the [Persona Guide]({% link docs/AI & LLM Integration/PersonaGuide.md %}) page.

```yaml
# Global defaults
use_llm: true
persona: |
   You are a standard, friendly NPC.
   You speak clearly and simply.

sessions:
  # Session 1
  - session_number: 1
    levels:
      # Level 1: the first level in session 1
      - level_number: 1
        # We want static responses here, so we turn LLM off
        use_llm: false
      
      # Level 2: the second level in session 1
      - level_number: 2
        # We turn LLM on and give it a specific persona for the whole level
        use_llm: true
        persona: |
          You are a very friendly and encouraging peer. 
          You always sound happy to be playing.

  # Session 2
  - session_number: 2
    levels:
      # Level 1: the first level in session 2
      - level_number: 1
        use_llm: true
        # Instead of one persona for the level, we define them per request.
        requests:
          - request_number: 1
            persona: |
              You are suspicious and hesitant to help.
          
          - request_number: 2
            persona: |
              You are getting annoyed because they keep asking for help.
              Speak in short, frustrated sentences.
```

---

## The Config Lifecycle
1. You upload the `.yaml` file to the User Management website and create a Session Order with it.
2. When creating the Session Order, the website parses the YAML into a JSON format and attaches it to the Session Order
   in MongoDB.
3. When a user is created under that Session Order, the config is also attached to the user.
4. The Game Client loads this JSON configuration (along with the other user data) upon user login and uses it to
   determine min-game when to use AI-generated responses and when to use static responses. The game client knows what
   session and level the user is on, and it knows the number of requests that the NPC got so far. It uses that
   information in addition to the `use_llm` field in the LLM config, and determines at each NPC request if to send a
   call to the server for an LLM response (the `generate-decision-explanation` function) or to display the static
   recording.

