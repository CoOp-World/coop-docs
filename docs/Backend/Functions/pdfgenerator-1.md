---
layout: default
title: pdfgenerator-1
parent: Functions
grand_parent: Backend
nav_order: 27
---

# `pdfgenerator-1` Function

## 🔗 Name and URL

- **Function Name:** `pdfgenerator-1`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/PDFGenerator-1`

## 🛠️ What the Function Is Doing

This function generates personalized PDF reports for each user ID provided in the request. Each report visually summarizes help interactions in a game called _Co-Op World_.

- Connects to MongoDB to fetch session data for each user.
- Creates a multi-page PDF using `reportlab`:
  - Includes title, legend, timestamp, and level-by-level breakdown of requests.
  - Displays "V" or "X" images depending on whether help was accepted or denied.
- Aggregates all PDFs into a `.zip` archive.
- Uploads the archive to a Cloud Storage bucket.
- Makes the file public and returns the download URL.

## 📥 Expected Input

### Request Method

- `POST`

### Request Body (JSON)

```json
{
  "user_ids": ["user_1", "user_2", "user_3"]
}
```

- `user_ids`: An array of user IDs for which the PDF reports should be generated.

## 🔄 How It’s Used in the System

This function is used to generate comprehensive reports for users in the _Co-Op World_ game. It allows administrators or therapists to review user interactions and help requests in a structured format, facilitating better understanding of user engagement and support needs.
