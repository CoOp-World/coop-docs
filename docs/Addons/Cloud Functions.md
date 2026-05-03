---
layout: default
title: Cloud Functions
nav_order: 9
parent: Addons
---

# CloudFunctions

The CloudFunctions repository contains the central backend services for the Co-Op platform.

It is the main home for serverless backend logic and is deployed to GCP using GitHub Actions. Each backend function lives in its own subfolder, which keeps the codebase modular and makes it easier to deploy and maintain individual services. See [Backend]({$ link docs/Backend/index.md %}) for more info about the function.

## What It Does

- Hosts the backend APIs and utility functions used by the platform.
- Provides the server-side logic for data creation, updates, validation, and reporting.
- Supports automatic deployment to Cloud Run Gen 2.

## Access Information

- **Repository**: [CloudFunctions](https://github.com/CoOp-World/CloudFunctions){:target="_blank"}
- **Google Cloud Platform**: [Cloud Services](https://console.cloud.google.com/run/services?project=co-op-world-game)

## Key Components

- Individual function folders.
- `main.py` for function logic.
- `requirements.txt` for Python dependencies.
- `Dockerfile` for container packaging.
- `config.json` for deployment metadata.
- GitHub Actions workflow for automated deployment.

## How It Works

When a function is added or updated, the code is committed to the repository. GitHub Actions builds the container image and deploys it to GCP. Each function runs independently, which makes the backend easier to scale and reduces coupling between services.
