---
layout: default
title: patients
parent: Collections
nav_order: 10
grand_parent: MongoDB
---

# `patients` Collection

This collection stores documents to connect between patients (also the game) and their therapists, including details about the patient's progress, strategies used, and other relevant information.

## Schema

| Field                 | Type         | Purpose                                                  |
| --------------------- | ------------ | -------------------------------------------------------- |
| `__v`                 | int          | Version key, used by Mongoose for versioning             |
| `_id`                 | objectId     | Unique identifier for the document                       |
| `age`                 | int          | Age of the patient in years                              |
| `completedLevels`     | array        | List of completed levels by the patient                  |
| `createdAt`           | date         | Timestamp of when the document was created               |
| `gender`              | string       | The gender of the patient                                |
| `levelNames`          | object       | Object containing level names the therapist named        |
| `name`                | string       | Name of the patient                                      |
| `patientId`           | string       | Unique identifier for the patient in the game            |
| `sessionCount`        | int          | Number of session the patient is in                      |
| `strategies`          | array        | List of strategies used by the patient for each level    |
| `therapistId`         | string       | Unique identifier for the therapist managing the patient |
| `updatedAt`           | date         | Timestamp of when the document was last updated          |
| `virtualPlayerGender` | string, null | The gender of the virtual player, if applicable          |
