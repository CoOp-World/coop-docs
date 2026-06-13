---
layout: default
title: Persona Guide
nav_order: 3
parent: AI & LLM Integration
---

# Persona Guide

## Introduction

The `persona` field in your LLM Configuration acts as the "director" for the AI. It dictates not only what the NPC says,
but how it sounds, its personality, and its underlying behavioral rules.

Because the backend passes this persona to the LLM, writing a clear, accurate persona is the most important step in
generating high-quality NPC responses that match your intention.

## Best Practices for Writing Personas

To ensure the AI strictly follows your intent while maintaining enough flexibility to sound natural, follow these core
principles:

* **Be descriptive yet concise:** You may use strong to describe the vibe, age, and energy level. Short, descriptive
  sentences work best.
* **Tone and sound:** Explicitly describe the acoustic qualities you want. Use phrases like "Your voice feels bouncy",
  "Speak in short, punchy sentences", or "You sound annoyed".
* **Set behavioral rules:** You can instruct the AI to react to specific game states. If you want to enforce
  reciprocity, explicitly state it. For example if you want it to focus on who helped more, write:
  "If you helped the child more than they helped you, mention that when rejecting".
  If you want it to verbally say that it mimics the last child's response, you can write: "Refer to the last child's 
  response - mention that you help/reject because, or despite the child helped/rejected you last time."
* **Leave Room for Creativity:** Give the AI the rules and the tone, but let it choose the exact words. Avoid forcing it
  to say one specific, hardcoded sentence every time.
* **Try Different Phrasings:** If a persona doesn't work as you expect, try slightly different variations and phrasings.
  Use the "Prompt Playground" tab in the User Management website to test you personas.

**Note:** The LLM is familiar with the game, so you shouldn't explain the game or include technical details in the
persona. Your persona is not sent as-is to the LLM, but rather wrapped with a prompt that explains the game rules, which
language to answer in, which gender to use, and all the necessary context. You should focus on the personality and the
behavioral rules that the LLM should follow when answering.

## Entity Naming Convention

To prevent the LLM from inaccurately referring to items in the game, use the exact game terminology in your persona
instructions. The LLM is instructed to understand these entities:

* **The Players:** "child" (the human player) and "NPC" or "virtual player".
* **Regular Collectibles:** "coin" (for the child) and "ice cube" (for the NPC). So don't write "item" or "thing", use
  the exact term.
* **Special Locked Items:** "special coin" (child's locked item) and "special ice cube" (NPC's locked item).
* **Actions:** A player **request** the other player for help, the player being asked can **help** or **reject**.

---

## Examples of Good Personas

Below are examples of well-written personas and the specific experimental intent behind them. Notice that personas can
be even shorter than the ones below. Even one or two sentences (like in the third example) can be sufficient.

### Example 1: Cheerful and Overly Positive
The LLM is instructed to be overly positive and excited, even when rejecting.

**Intent:** To test if an overwhelmingly positive and gentle tone encourages the child to cooperate more often.

> "You are super cheerful, zippy, and excited. You sound like a playful child and use bright, lively, excited words.
> Your voice feels bouncy and enthusiastic. You are always seeing the bright side of things, and gently encourage
> cooperation and helping, even when you reject the child's requests."

### Example 2: Direct and Confident
The LLM is instructed to be very clear and direct, and with short and direct sentences.

**Intent:** To test if a firm, no-nonsense approach drives higher reciprocity from the child.

> "You are bold, confident, and very clear. You sound like a strong child who talks in simple, punchy, very short
> sentences. You speak straight to the point, serious and not showing excitement. Your voice feels sure of itself, but
> never mean. You strongly encourage reciprocity and cooperation, even when you reject the child's requests."

### Example 3: Anxious About Ice Cubes
The LLM is instructed to be very anxious about its ice cubes and to watch how many times they each helped each other.

**Intent:** To test how the child reacts when explicitly called out on uneven cooperation ratios, and also how the child
deals with a player that doesn't feel so happy to let go of their ice cubes and be reciprocal, even when willing to help.

> "You deeply care about equally helping each other. If you reject because you helped the child more than they helped
> you before, you mention it. If you help them, you mention how hard it is for you to give up your ice cubes."
