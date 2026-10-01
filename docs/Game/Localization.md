---
layout: default
title: Languages, Sign Language and TTS
nav_order: 5
parent: Game
---

# Languages, Sign Language and Text-to-Speech

Research notes and tooling from the first development phase (Sept–Dec 2024), migrated from Notion. For the current LLM/TTS language setup see [AI & LLM Integration → Insights]({% link docs/AI & LLM Integration/Insights.md %}).

## Multi-language text

- **Original approach:** text is part of the images, so a new language needs Photoshop work for every image.
- **Alternative proposed (Sept 2024):** one JSON file per language with the sentences, switched at runtime with [i18next](https://react.i18next.com/) without preloading images for every language. Downside noted at the time: the text looks less integrated with the artwork.
- **Current state (per `Insights.md`):** the client uses `i18next`, detects the display language automatically from location (not from the user's saved language), and shows language-specific sprites and voice recordings.

The full legacy Hebrew sentence list is in [Legacy Game Text]({% link docs/Game/Legacy Game Text.md %}).

## Sign language

Status in Sept 2024 (no text-to-sign-avatar solution was suitable):

- AWS GenASL avatar generator ([blog](https://aws.amazon.com/blogs/machine-learning/genasl-generative-ai-powered-american-sign-language-avatars/), [repo](https://github.com/aws-samples/genai-asl-avatar-generator)) — American Sign Language only, no API found.
- [sign.mt](https://sign.mt/) / [sign/translate](https://github.com/sign/translate) — American, German and French sign language, skeleton avatar only.
- Each spoken language has its own sign language, so videos have to be produced per language.

The decision was to use **pre-recorded sign-language videos** supplied by the psychology team and played in the game. See [Deaf Version]({% link docs/Game/Versions/Deaf-Version.md %}).

## Text-to-speech and voice-over

Options considered (Sept 2024): record every line, or use a cloud TTS. Google Cloud Text-to-Speech and Azure speech both supported Hebrew and male/female voices, **but not boy/girl voices**. Three Hebrew/English TTS samples were sent to the psychology team (Weekly 3). Pre-recorded voice-over was used for the main game texts ("text, voice-over" markers in the legacy list). For LLM-generated explanations the system now uses Gemini TTS (see `Insights.md`).

## Translating the sentence list with a script

A helper script (Oct 2024) translates a `.docx` of sentences into several languages with Google Translate. Machine translation is only a first draft; have a native speaker review.

1. Install: `pip install python-docx googletrans==4.0.0-rc1`
2. Prepare a `.docx` with one sentence per paragraph (bulleted or plain).
3. Run: `python script.py <input_file> <src_lang> <dest_lang1> <dest_lang2> ...` (ISO-639 codes, see the [Google language list](https://cloud.google.com/translate/docs/languages)).
4. Output: `translated_output_<lang>.docx` for each language (about a minute per language), each paragraph as `Original:` / `Translated:`.

```python
import sys
from docx import Document
from googletrans import Translator

if len(sys.argv) < 4:
    print("Usage: python script.py <input_file> <src_lang> <dest_lang1> <dest_lang2> ...")
    sys.exit(1)

input_file = sys.argv[1]
src_lang = sys.argv[2]
dest_langs = sys.argv[3:]

doc = Document(input_file)
translator = Translator()

for dest_lang in dest_langs:
    translated_doc = Document()
    for para in doc.paragraphs:
        text = para.text.strip()
        if text:
            try:
                translation = translator.translate(text, src=src_lang, dest=dest_lang)
                translated_doc.add_paragraph(f"Original: {text}")
                translated_doc.add_paragraph(f"Translated: {translation.text}\n")
            except Exception as e:
                translated_doc.add_paragraph(f"Original: {text}")
                translated_doc.add_paragraph(f"Error translating: {e}\n")
    output_filename = f'translated_output_{dest_lang}.docx'
    translated_doc.save(output_filename)
    print(f"Translation to {dest_lang} completed and saved as '{output_filename}'!")
```
