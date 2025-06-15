---
layout: default
title: Data Flow
nav_order: 2
parent: Architecture
grand_parent: Game
---

# Game Data Transfer Diagram

![Co-Op Data Transfer](../../../assets/Co-Op%20data%20transfer.png)

This sequence diagram shows the flow of data between the Client, Server, DB, and HTTP microservices. Two key service clusters are highlighted:

## 🎮 Game Services

| Step               | Description                                             |
| ------------------ | ------------------------------------------------------- |
| `getwebsitestatus` | On website load, fetch current system state             |
| `getuser`          | Client validates user ID                                |
| `Games`            | Client sends game object on session start               |
| `RegisterUser`     | Registration metadata sent when user chooses characters |
| `LevelStart`       | Called at the beginning of each level                   |
| `Levels`           | Called at the end of each level to submit results       |

Each of these steps involves:

- `GET` for reading user/status info (black arrows)
- `POST` for submitting state/updates (blue arrows)

## 🛠️ Server Additional Services

| Function             | Role                              |
| -------------------- | --------------------------------- |
| `backupMongoToGCS`   | Daily backups to Cloud Storage    |
| `bug_reports`        | Capture and log bugs              |
| `createUsers`        | Generate users on-the-fly         |
| `createUsersFromIDs` | Bulk user creation                |
| `PDFGenerator-1`     | Generate and export PDF summaries |
| `resetUser`          | Clear and reset user state        |
