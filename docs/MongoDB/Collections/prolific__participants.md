---
layout: default
title: prolific/participants
parent: Collections
nav_order: 11
grand_parent: MongoDB
---

# `prolific/participants` Collection

This collection stores documents related to the participants in Prolific studies. Each document represents a participant's information, including their unique identifiers, answers to study questions, expected completion code, feedback time, number of tries, play duration, status, and other relevant details.

## Schema

| Field                      | Type         | Purpose                                                           |
| -------------------------- | ------------ | ----------------------------------------------------------------- |
| `PROLIFIC_PID`             | string       | Unique identifier for the participant in Prolific                 |
| `SESSION_ID`               | string       | Identifier for the session in which the participant is involved   |
| `STUDY_ID`                 | string       | Identifier for the study associated with the participant          |
| `_id`                      | objectId     | Unique identifier for the document in MongoDB                     |
| `answers`                  | object       | Object containing answers to the study questions                  |
| `expected_completion_code` | int          | Expected completion code for the study                            |
| `feedback_time`            | string, null | Time taken to provide feedback, if applicable                     |
| `number_of_tries`          | int          | Number of attempts made by the participant                        |
| `play_duration`            | string, null | Duration of play, if applicable                                   |
| `status`                   | string       | Status of the participant in the study (e.g., completed, pending) |
| `survey_duration`          | null         | Duration of the survey, if applicable                             |
| `timestamp`                | string       | Timestamp of when the document was created or last updated        |
| `user_id`                  | string       | Identifier for the user associated with the participant           |
