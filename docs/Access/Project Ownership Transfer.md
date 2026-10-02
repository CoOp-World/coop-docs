---
layout: default
title: Project Ownership Transfer
nav_order: 5
parent: Access
---

# Changing GCP Project Ownership and Billing

Steps to give a GCP project to a new owner and move it to a new billing account. Migrated from the Notion page of Oct 2024 (generic Google Cloud procedure; check the current console wording).

## 1. Transfer ownership

1. In the [Google Cloud Console](https://console.cloud.google.com/), open **IAM & Admin → IAM**.
2. **Add** the new owner's email with the **Owner** role and save.
3. Optionally remove the old owner's Owner role (trash icon).
4. Check that the new account appears under the project owners and has the permissions it needs (for example Editor or Viewer for other aspects).

## 2. Change the billing account

1. Under **Billing → Account management**, open the billing account used by the project.
2. In **Permissions → Manage permissions**, add the new account as **Billing Account Administrator** or **Billing Account User**.
3. In **Billing**, select the project and choose **Change billing account**; pick the new account and confirm.
4. Optionally remove the old account's billing permissions afterwards.
5. Confirm the right billing account is attached to avoid unexpected charges.

## Appendix: moving a Compute Engine VM between organizations (historical)

The original system ran on a Windows VM and the plan in Oct 2024 was to move to Flask on Linux, then to serverless. The backend is now serverless on Cloud Run/Cloud Functions, so this is rarely needed. A VM cannot be transferred directly between organizations:

1. Create an image of the VM, then export it to a Cloud Storage bucket: `gcloud compute images export --destination-uri gs://BUCKET/image.tar.gz --image IMAGE_NAME`.
2. Give the destination project's compute service account (`service-PROJECT_NUMBER@compute-system.iam.gserviceaccount.com`) **Storage Object Viewer** on the bucket.
3. Copy the image to a bucket in the destination organization: `gsutil cp gs://SOURCE_BUCKET/image.tar.gz gs://DEST_BUCKET/image.tar.gz`.
4. Import it: `gcloud compute images import IMAGE_NAME --source-file gs://DEST_BUCKET/image.tar.gz --os=<matching OS>`.
5. Create the VM from the image: `gcloud compute instances create VM_NAME --image IMAGE_NAME --zone ZONE`.
6. Recreate networking, firewall rules, service accounts, IAM roles, static IPs and DNS in the destination project. Google's *Migrate for Compute Engine* is an alternative for complex migrations.

See also: [Manager]({% link docs/Access/Manager.md %}) for adding users, and [GCP Recovery]({% link docs/Backend/GCP Recovery.md %}).
