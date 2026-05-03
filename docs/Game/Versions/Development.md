---
layout: default
title: Development
nav_order: 4
parent: Versions
grand_parent: Game
---

# co-op-client-dev

The development version of the Coop Game, used for testing new features and validating changes before they go to production.

## Access Information

- **Game URL**: [https://co-op-client-dev-791222378113.me-west1.run.app](https://co-op-client-dev-791222378113.me-west1.run.app){:target="_blank"}
- **Repository Branch**: `dev`
- **Repository**: [CO-OP-client (dev branch)](https://github.com/CoOp-World/CO-OP-client/tree/dev){:target="_blank"}

## Game Details

| Property | Value |
|----------|-------|
| **Levels Available** | 0-10 |
| **Supported User IDs** | Any |
| **Region** | Me West 1 |
| **Status** | Development |

## Overview

This is the central development branch where new features are tested and validated before being deployed to production. Use this version to:
- Test new gameplay mechanics
- Validate bug fixes
- Experiment with feature changes
- Run integration tests

## Levels

The dev version includes levels 0-10, matching the main game structure for consistent testing.

## Usage

The dev version accepts any user ID and is intended for:
- Developers testing new code
- QA teams validating releases
- Researchers testing experimental features before production deployment

## Deployment

This version is deployed from the `dev` branch to Google Cloud Run (Gen 2) and is updated frequently as development progresses.
