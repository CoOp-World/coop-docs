---
layout: default
title: Backup
nav_order: 3
parent: MongoDB
---

MongoDB Backup Process

This document outlines the process for performing daily backups of MongoDB collections to Google Cloud Storage (GCS). The backup process is automated using Google Cloud Scheduler, which triggers the `backupMongoToGCS` function.

## Backup Schedule

The MongoDB backup process is scheduled to run daily at 2:00 AM Israel Daylight Time (IDT). The schedule is defined in the Google Cloud Scheduler as follows:

- **Region**: europe-west1
- **Description**: Saving DB backup daily
- **Frequency**: `0 2 * * *` (Every day at 2:00 AM)
- **Timezone**: Israel Daylight Time (IDT)
- **Target Type**: HTTP
- **URL**: [https://europe-central2-co-op-world-game.cloudfunctions.net/backupMongoToGCS](https://europe-central2-co-op-world-game.cloudfunctions.net/backupMongoToGCS)
- **HTTP Method**: POST
- **HTTP Headers**:
  - `User-Agent: Google-Cloud-Scheduler`

## Backup Process

1. **Environment Variables**:

   - `MONGO_CONNECTION`: MongoDB connection string.
   - `MONGO_DB_NAME`: Name of the MongoDB database.
   - `BACKUP_BUCKET_NAME`: Name of the GCS bucket where backups will be stored (`mongo-backup-coopdb`).

2. **Function Execution**:
   - The `backupMongoToGCS` function connects to the MongoDB database using the provided connection string.
   - It retrieves all collections from the database.
   - Each collection is converted into a JSON string.
   - The JSON string is uploaded to the specified GCS bucket in a folder named with the current timestamp.

## Example Request

```bash
curl -X POST   https://europe-central2-co-op-world-game.cloudfunctions.net/backupMongoToGCS
```

## Backup Storage

Backups are stored in the `mongo-backup-coopdb` bucket in Google Cloud Storage. Each backup is organized into folders named with the timestamp of when the backup was created (e.g., `20230711-020000/`).

## Restoring a Backup

To restore a backup from GCS to MongoDB, follow these steps:

1. **Download the Backup**:

   - Navigate to the GCS bucket `mongo-backup-coopdb`.
   - Locate the folder with the desired timestamp.
   - Download the JSON files for each collection.

2. **Restore to MongoDB**:

   - Connect to your MongoDB instance.
   - For each downloaded JSON file, use the MongoDB `mongoimport` tool to import the data back into the respective collections. Example command:

   ```bash
   mongoimport --uri <your_mongo_connection_string> --db <your_db_name> --collection <collection_name> --file <path_to_json_file>
   ```
