---
layout: default
title: GCP Recovery
nav_order: 5
parent: Backend
---

# GCP Recovery

## Overview

This document outlines the steps to recover a GCP (Google Cloud Platform) environment in the event of a failure or disaster. The recovery process is designed to restore services and data with minimal downtime and data loss.

## Recovery Steps

1. **Fix IAM Permissions**:

   - Ensure that the necessary IAM (Identity and Access Management) permissions are restored. This is crucial for accessing resources and performing recovery operations.
   - Add all required IAM roles to the service accounts and users involved in the recovery process.
   - You can see the list of roles in the [IAM documentation](../Access/).

2. **Restore GitHub-Connected Cloud Functions and Cloud Run Services**:

   - If your GitHub Actions are already configured, recovery is as simple as pushing the relevant code back to the GitHub repo.
   - Ensure that the `config.json`, `deploy.yml`, and `Dockerfile` (if used) are up to date in each function's folder.
   - GitHub Actions will automatically deploy each function or service upon commit.

3. **Restore Secrets and Environment Variables**:

   - Go to **Secret Manager** and ensure all required secrets exist (e.g., database credentials, API keys).
   - Reconnect them to services via environment variables or IAM bindings.

4. **Reconfigure GitHub Actions Deployer**:

   - Ensure the GitHub Actions deployer service account (`gh-actions-deployer@...`) has the following roles:
     - Cloud Run Admin
     - Service Account User
     - Storage Admin (for source uploads)
     - Cloud Build Editor
   - If needed, re-add this service account to your GitHub repository secrets as `GCP_SA_KEY`.

5. **Rebuild Cloud Run Services (if needed manually)**:

   - Use `gcloud run deploy` or rely on the `deploy.yml` GitHub workflow to handle this automatically.
   - Confirm the runtime, function entry point, environment variables, and region are set correctly.

6. **Reconfigure API Gateway (if used)**:

   - Redeploy your API Gateway config using:
     ```bash
     gcloud api-gateway gateways create ...
     ```
   - Make sure to include all paths and methods from your OpenAPI spec.

7. **Restore Databases**:

   - Import backups for Firestore, MongoDB, or Cloud SQL as applicable.
   - Validate connections post-restoration.

8. **Validate System Health**:
   - Run smoke tests on all endpoints and services.
   - Check logs for startup errors or HTTP 500 responses in [Cloud Logging](https://console.cloud.google.com/logs/).
   - Confirm monitoring and alerts are active and accurate.

## Additional Tips

- Maintain up-to-date backups of `config.json`, `deploy.yml`, `.env` or secrets, and Dockerfiles.
- Store service account keys securely and encrypted in GitHub secrets.
- Regularly test recovery steps in a staging environment.
- Consider using GitHub repository tags or branches to organize stable production snapshots.
