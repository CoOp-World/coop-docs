---
layout: default
title: Architecture Diagram
nav_order: 1
parent: Architecture
grand_parent: Game
---

# System Architecture

![Co-Op Architecture](../../../assets/Co-Op%20architecture.png)

This diagram outlines the overall system architecture of the Co-Op platform, broken into three key layers:

### 🗄️ DB (MongoDB)

- Stores all persistent data.
- **Users**:
  - System admins
  - Kids (players)
- **Collected game data**:
  - Events
  - Level progress
  - Performance metrics

### ☁️ Server (GCP)

- Hosts backend logic and APIs.
- Components:
  - `Client code`: Backend support for game client
  - `Within-game support`: Real-time events, session control
  - `Users management`: Registration, login, role handling
  - `Analysis & Reports`: Session summaries, performance metrics

### 🖥️ Client (Browser)

- User interface for players and admins.
- Key interactions:
  - `Play game`: Accessing levels, tutorials, and feedback
  - `Manage`:
    - Game build setup
    - Replay access
