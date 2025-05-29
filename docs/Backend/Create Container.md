---
layout: default
title: Create Container
nav_order: 4
parent: Backend
---

# Create Container

To create a container you need to have the following files in the repository:

- Dockerfile
- cloudbuild.yaml
- nginx.conf

To connect the gcp project to the github repository, you need to go to GCP cloud run and then click on the "Connect repo" button.

![Connect repo](../../assets/connect_repo.png)

Click on the "Set up with Cloud Build" button.

![Set up with Cloud Build](../../assets/set_up_with_cloud_build.png)

Choose the repository you want to deploy. If you dont see the repository you need to click on the "Manage connected repositories" button. After you selected the repository you need to click on the "Next" button.

![Select repository](../../assets/select_repository.png)

Now you choose the branch you want to deploy, And choose Dockerfile and click on the "Save" button.

![Dockerfile](../../assets/dockerfile.png)

Now you choose the region you want to deploy the repo to and choose Allow unauthenticated invocations.

![Region](../../assets/region.png)

Now you need to change the port (if you use the ngnix in the co-op-client) to port 80 then click on the "Create" button.

![Deploy](../../assets/deploy.png)

Then after some time you will see the repo deployed and you can access it from the url.
