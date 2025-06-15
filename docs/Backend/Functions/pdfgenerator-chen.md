---
layout: default
title: pdfgenerator-chen
parent: Functions
grand_parent: Backend
nav_order: 28
---

# `pdfgenerator-chen` Function

## 🔗 Name and URL

- **Function Name:** `pdfgenerator-chen`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/PDFGenerator-chen`

## 🛠️ What the Function Is Doing

This function generates visual PDF reports for each provided user ID based on gameplay data from MongoDB. Each report contains:

- User metadata (ID, experimenter, report creation date).
- Help request behavior during each level, represented with "✔" (accepted) or "✘" (denied).
- Reports are constructed using ReportLab and styled with headings, spacing, and tables.
- The generated PDFs are compressed into a ZIP file and uploaded to a Google Cloud Storage bucket.
- The function returns a public URL pointing to the ZIP file for download.

## 📥 Expected Input

### Request Method

- `POST`

### Request Body (JSON)

```json
{
  "user_ids": ["user_1", "user_2"]
}
```

- `user_ids`: An array of user IDs for which the PDF reports should be generated.

## 🔄 How It’s Used in the System

This function is used to generate detailed reports for users in the _Co-Op World_ game, specifically for research or therapeutic purposes. It allows therapists or researchers to analyze user interactions and help request behaviors across different levels, providing insights into user engagement and support needs. The generated reports can be shared with stakeholders or used for further analysis. **This is the latest version of the PDF generator function, which is used to generate reports for users in the _Co-Op World_ game. It is designed to be more efficient and user-friendly, with improved formatting and data handling capabilities.**
