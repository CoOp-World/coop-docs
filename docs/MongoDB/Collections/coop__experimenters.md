---
layout: default
title: coop/experimenters
parent: Collections
nav_order: 3
grand_parent: MongoDB
---

# `coop/experimenters` Collection

This collection stores documents related to the experimenters involved in the game. It includes information about the experimenters' names and a description of the experiment.

## Schema

| Field                | Type   | Purpose                                                     |
| -------------------- | ------ | ----------------------------------------------------------- |
| `_id`                | string | Unique identifier for the document                          |
| `description`        | string | A description of the experimenter or experiment             |
| `experimenter_names` | array  | An array of names of the experimenters involved in the game |
