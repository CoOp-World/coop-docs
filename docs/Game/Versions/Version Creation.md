---
layout: default
title: Version Creation
nav_order: 2
parent: Versions
---

## How to Create a New Version

To create a new version:

1. Create a new branch from the "dev" branch named "prod-version-name" (used for production deployment).
2. Create a development branch from "prod-version-name" and name it "dev-version-name" (used for development only).
3. When deploying, merge "dev-version-name" into "prod-version-name" and then deploy.

**Always work only in the "dev-version-name" branch. Never commit directly to the "prod-version-name" branch.**

## Prerequisites

Before connecting the GCP project to the GitHub repository, ensure you have the following files in the repository:

- `cloudbuild.yaml`
- `Dockerfile`
- `nginx.conf`

## Connect GCP Project to GitHub Repository

To connect the GCP project to the GitHub repository:

1. Go to GCP Cloud Run and click the "Connect repo" button.

![Connect repo](../../assets/connect_repo.png)

2. Click the "Set up with Cloud Build" button.

![Set up with Cloud Build](../../assets/set_up_with_cloud_build.png)

3. Choose the repository to deploy. If you don't see your repository, click "Manage connected repositories" first. Then click "Next".

![Select repository](../../assets/select_repository.png)

4. Select the branch to deploy, choose Dockerfile, and click "Save".

![Dockerfile](../../assets/dockerfile.png)

5. Choose the region for deployment and select "Allow unauthenticated invocations".

![Region](../../assets/region.png)

6. If you're using nginx with co-op-client, change the port to 80, then click "Create".

![Deploy](../../assets/deploy.png)

After a few moments, your game will be deployed and accessible via the provided URL.
