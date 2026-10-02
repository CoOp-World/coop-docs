---
layout: default
title: Meeting Decisions
nav_order: 1
parent: Project History
---

# Meeting Decisions (Weekly 1–13, Oct 2024 – Apr 2025)

Distilled from the Notion weekly-meeting pages kept by the main developer. These are discussion outcomes and to-dos, not verified facts about the system. Items marked *(implemented)* are visible in the current docs.

## Weekly 1 (Oct 2024) — kickoff

- Replace the Windows VM on GCP with a Linux VM running Flask (later superseded by serverless Cloud Run Functions).
- Client: React + Phaser.js. Get game video clips and the original developer's documentation; get GCP and MongoDB permissions.
- Open question: language switching in Phaser.

## Weekly 2

- Grid adjusts to resolution; circle physics body with rectangular collection shape *(see [Grid and Bounding Boxes]({% link docs/Game/Architecture/Grid and Bounding Boxes.md %}))*.
- Sign language and TTS options researched *(see [Languages, Sign Language and TTS]({% link docs/Game/Localization.md %}))*.
- API: two API gateways, `COOPGAMEAPI` (`POST /Games`, `/Levels`, `/RegisterUser`, `/Users`; `GET /GetUser`, `/GetWebsiteStatus`) and `USERUTILITIESAPI` (`GET /GetExperimenter`; `POST /CreateUsers`, `/ResetUser`), created 12/09/2023 (day/month order not stated; current gateway: [API Gateway]({% link docs/Backend/API Gateway.md %})).
- First estimate for a rebuilt app: 10–13 weeks at 15 hours/week (login 1–2 wks, multi-language 2–3, sign language 2–3, client–server connection 2, server to Flask 2, plus testing).

## Weekly 3

- Architecture and data-flow diagrams created; MongoDB structure documented; decisions on the grid/bounding boxes, multi-language/sign-language/TTS and the all-sentences list documented; TTS samples sent to the psychology team; the sign-language video request sent.

## Weekly 4–5

- **Replay:** decided to record a snapshot every millisecond *(replay itself is still open; see the replay guide attachment, not yet migrated)*.
- Plans: website, open-source release, beta version for the psychology team on Cloud Run *(implemented)*; build a login in the client; ask how to add videos in Phaser.

## Weekly 6 (Nov 2024)

- Architecture and data-flow documents; code documentation.
- Game objects configurable per user, so therapists can design level flow, background and sound.
- Server sends the set of levels to the client, which builds the game dynamically *(implemented; see [Adding a Level]({% link docs/Game/Adding a Level.md %}))*.
- Error-report button that sends screenshot/log/location/score with an optional description, with an option to disable it *(see the `bug_reports` function)*.
- Make the PI (Dudi) GitHub admin.

## Weekly 7

- Teams to propose missions; working plan, needed system changes and technologies to be presented *(see [Roadmap and Ideas]({% link docs/Project History/Roadmap and Ideas.md %}))*.
- Change the level configuration object and user level array *(implemented)*.

## Weekly 8 (Dec 2024)

- User guide to be written for research assistants.
- Logger spec: an object per level including coin appearance and collection time/location, key presses and durations, and human and virtual player positions every half second.
- Idea: automatic import of Qualtrics data into the database (see [Prolific and Qualtrics]({% link docs/Addons/Prolific and Qualtrics.md %})).

## Weekly 9

- Check full English support.
- **Experiment ideas with the American partner** (all design proposals, not necessarily built):
  - *Group reciprocity:* two virtual players with ProbabilisticTFT, each looking different and collecting a different collectable; each player can ask any other for help; when a virtual player asks another virtual player the game pauses so the human sees the request and answer.
  - *Helpfulness vs capabilities:* two virtual players, one always helps and the other helps with probability p, the human does not know this; the always-helping player gives x coins and the other y > x.
  - *Competitive game:* show the virtual player's score and the winner at level end, and the win ratio, to see whether the human still helps *(a competitive version exists: [Competitive]({% link docs/Game/Versions/Competitive.md %}))*.
- Option to play part of the levels; document version control for 2+ experiments with different versions *(see [Experiment Versions]({% link docs/Project History/Experiment Versions.md %}))*; Hebrew-only text on the site.

## Weekly 10 (Dec 2024)

- Third group: before showing virtual players, filter which virtual players can open which lock (only some kinds of virtual player may open a given lock); option to show but disable the others, or hide players that cannot open the lock.
- Three user documents: experiment protocol, game explanation, user creation guide.
- Sign-language requirements (see [Deaf Version]({% link docs/Game/Versions/Deaf-Version.md %})); pop-up sentences follow the file from the psychology team; recordings added; parts of levels, two levels at a time.
- Weekly Sunday update.

## Weekly 11 (Jan 2025)

- UML class diagram; session creation and order in the user-creation interface *(implemented)*; strategy per level *(implemented)*.
- **Intervention plan:** an option per user to have help requests or not *(implemented as `request_enable` on `coop/users`; when false requests do not appear)*.
- Check that the parents' report still works; shallow dashboard with reciprocity calculations *(see [Parents Dashboard]({% link docs/Addons/Parents Dashboard.md %}))*.

## Weekly 12

- Sign-language video tweaks (play once, replay button, URL language indicator); resend records when there is no internet *(see `post-retry-worker`)*; have a participant play with screen recording and database check; check why Prolific tasks are hard to start; evaluate a Wix site for the project.

## Weekly 13 (Apr 2025)

- **Felix version:** give the researcher control over the elements and decisions available; send an intermediate version without the character-introduction scene, dubbing and separation scene (all text voice-over-ready, automated dubbing, texts adjusted to the virtual character's name); then share the proposed introduction flow for feedback.
- **Strategy version:** ask the psychology team whether each version should be self-explanatory or the website should state the version in use; review all texts; implement the changes requested by the PI.
- General: create game-based chat stickers (check the platform's requirements).

## Group 1 meetings

Notes of 5.1.25, 6.1.25 (file dated 1.6.25), 12.1.25 and 20.4.25 existed only as PDF attachments in Notion and are not reproduced here.
