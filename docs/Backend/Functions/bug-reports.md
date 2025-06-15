---
layout: default
title: bug-reports
parent: Functions
grand_parent: Backend
nav_order: 6
---

# `bug-reports` Function

## 🔗 Name and URL

- **Function Name:** `bug-reports`
- **Region:** `europe-central2`
- **URL:** `https://europe-central2-co-op-world-game.cloudfunctions.net/bug_reports`

## 🛠️ What the Function Is Doing

This function is designed to handle bug reports submitted by users. It processes incoming HTTP requests that contain details about the bug, such as the description, steps to reproduce, and any relevant screenshots or logs. The function validates the input data and stores the bug report in a designated database collection for further review and action and save the screenshot to a Google Cloud Storage bucket.

## 📥 Expected Input

You need to send a POST request to the function with the screenshot in the request.files and the bug details in the request.form. The expected structure is stored in the `coop/bug_reports` collection in the database. The request should include the fields mentioned in the collection schema
[here](../../MongoDB/Collections/coop__bug_reports.html).

## 🔄 How It’s Used in the System

In every screen of the game, there is a "Report Bug" button that opens a modal where users can fill out the bug report form. When the user submits the form, the game client sends a request to this function with the bug details and any attached screenshot. The function processes the request, validates the data, and stores the bug report in the database for further review by the development team.
