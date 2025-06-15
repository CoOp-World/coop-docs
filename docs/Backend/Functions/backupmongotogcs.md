---
layout: default
title: backupmongotogcs
parent: Functions
grand_parent: Backend
nav_order: 5
---

# `backupmongotogcs` Function

## 🔗 Name and URL

- **Function Name:** `backupmongotogcs`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/backupMongoToGCS`

## 🛠️ What the Function Is Doing

The `backupMongoToGCS` function is designed to back up MongoDB collections to Google Cloud Storage (GCS). It handles HTTP requests and exports the data from MongoDB, saving it as JSON files in a specified GCS bucket.

## 📥 Expected Input

The function does not require a specific payload. It relies on environment variables for configuration.

## 🔄 How It’s Used in the System

Every day at 2 AM, this function is triggered by a Cloud Scheduler job.

## How to Retrieve the Data

To retrieve the data backed up by this function, you can access the GCS bucket `mongo-backup-coopdb`. The data will be stored in JSON format, with each collection saved as a separate file. The folder will be named with the current date in the format `YYYYMMDD-ELSE` (ELSE will be replaced with some numbers).
The files will be named according to the collection names, such as `coop__config.json`, `coop__game.json`, etc.
The data can be downloaded directly from the GCS bucket using the Google Cloud interface. And after downloading, you can import the JSON files into MongoDB using the mongo Compass or the `mongoimport` command.
