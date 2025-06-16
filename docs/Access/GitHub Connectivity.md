---
layout: default
title: GitHub Connectivity
nav_order: 3
parent: Access
---

# GitHub Connectivity

To connect to GitHub repo in GCP, you need to have the following permissions:

- Cloud Functions Admin
- Service Usage Admin
- Viewer

To add the permissions, follow the same steps as for granting access to Cloud Functions.

## Add GitHub Actions Deployer

To deploy from GitHub Actions to GCP (e.g., Cloud Run or Cloud Functions), create a dedicated service account and configure your GitHub repository to use it:

### ✅ Step 1: Create the Service Account

1. Go to [IAM & Admin > Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts){:target="\_blank"}
   - Ensure you are in the correct project.
2. Click **"Create Service Account"**
   - **Name**: `gh-actions-deployer`
   - **ID**: `gh-actions-deployer`
3. Click **"Create and continue"**

### ✅ Step 2: Grant Required Roles

Assign the following roles:

- `Cloud Run Admin`
- `Cloud Functions Developer`
- `Storage Admin` _(for uploading source archives)_
- `Artifact Registry Reader` _(for accessing container images)_
- `Service Account User` _(to deploy with other service accounts)_

These roles can be assigned during creation or later via the IAM panel.

### ✅ Step 3: Create a JSON Key

1. Go to the **“Keys”** tab for the service account.
2. Click **“Add Key” → “Create new key” → JSON**
3. Download and securely store the JSON key file.

### ✅ Step 4: Add the Key to GitHub

1. Go to your **GitHub repository → Settings → Secrets → Actions**
2. Add a new secret:
   - **Name**: `GCP_SA_KEY`
   - **Value**: Paste the entire JSON content from the key file
