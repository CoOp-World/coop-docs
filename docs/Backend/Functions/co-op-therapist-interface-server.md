---
layout: default
title: co-op-therapist-interface-server
parent: Functions
grand_parent: Backend
nav_order: 8
---

# `co-op-therapist-interface-server` Container

## 🔗 Name and URL

- **Function Name:** `co-op-therapist-interface-server`
- **Region:** `europe-central2`
- **URL:** `https://co-op-therapist-interface-server-791222378113.europe-central2.run.app`

## 🛠️ What the Function Is Doing

This container serves as the backend for the Co-op Therapist Interface, providing a web interface for therapists to manage and monitor co-op therapy sessions. It handles user authentication, session management, and data storage.
It is built using Node.js and Express, and it connects to a MongoDB database to store session data and user information. The container is deployed on Google Cloud Run, allowing it to scale automatically based on demand.

## 📥 Expected Input

The container expects HTTP requests with JSON payloads for various operations, such as creating a new therapy session, updating session details, and retrieving session data. The requests should include authentication tokens to ensure secure access.

## 🔄 How It’s Used in the System

The Co-op Therapist Interface is used by therapists to manage therapy sessions for co-op players. It allows therapists to create and monitor sessions, track player progress, and provide feedback. The interface is designed to be user-friendly, enabling therapists to easily navigate through different sessions and access relevant data.
The co-op therapist interface is available here:
[Co-op Therapist Interface](https://co-op-therapist-interface-791222378113.europe-central2.run.app){:target="\_blank"}.
