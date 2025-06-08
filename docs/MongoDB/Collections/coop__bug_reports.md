---
layout: default
title: coop/bug_reports
parent: Collections
nav_order: 1
grand_parent: MongoDB
---

# `coop/bug_reports` Collection

This collection stores documents related to bug reports submitted by users in the co-op game environment. Each document contains a description of the bug and an optional image URL for further context.

## Schema

| Field             | Type     | Purpose                                               |
| ----------------- | -------- | ----------------------------------------------------- |
| `_id`             | objectId | Unique identifier for the document                    |
| `bug_description` | string   | A description of the bug reported by the user         |
| `image_url`       | string   | An optional URL to an image related to the bug report |
