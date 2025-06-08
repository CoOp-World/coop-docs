---
layout: default
title: coop/config
parent: Collections
nav_order: 2
grand_parent: MongoDB
---

# `coop/config` Collection

This collection stores documents related to the configuration settings for the co-op game environment. It includes a boolean field indicating whether the website is currently active or not.

## Schema

| Field           | Type     | Purpose                                      |
| --------------- | -------- | -------------------------------------------- |
| `_id`           | objectId | Unique identifier for the document           |
| `website_is_on` | bool     | Indicates if the website is currently active |
