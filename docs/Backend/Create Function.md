---
layout: default
title: Create Function
nav_order: 3
parent: Backend
---

# Create Function

## 📦 Recommended: GitHub-Based Function Deployment

All backend functions are now developed and deployed through the central GitHub repository:  
👉 [CoOp-World/CloudFunctions](https://github.com/CoOp-World/CloudFunctions)

Each function is managed in its own subfolder within this repo and deployed automatically via GitHub Actions to GCP Cloud Run (Gen 2).

---

## 📁 Structure of Each Function

Each function folder should include the following files:

```
functions/
├── my-function-name/
│   ├── main.py             # Python logic
│   ├── requirements.txt    # Dependencies
│   ├── Dockerfile          # Container definition
│   └── config.json         # Metadata for deployment
```

---

## 🛠️ Steps to Create a New Function

### 1. Create a Folder

Inside the [CloudFunctions GitHub repo](https://github.com/CoOp-World/CloudFunctions), create a new folder for your function, for example:

```
/functions/my-new-function/
```

### 2. Add the Required Files

- **`main.py`** – Your Python function logic
- **`requirements.txt`** – List of required Python packages
- **`Dockerfile`** – Defines how to build and run your container (see template below)
- **`config.json`** – Metadata for deployment (example below)

### 3. Create the `config.json`

This file defines how your function is deployed. Place it **inside the function's folder**.

Example:

```json
{
  "name": "create-sessions-order",
  "region": "europe-central2",
  "runtime": "python312",
  "entry_point": "create_sessions_order_endpoint",
  "trigger": "http",
  "allow_unauthenticated": true,
  "env": {
    "MONGO_CONNECTION": "mongodb+srv://...",
    "MONGO_DB_NAME": "DatabaseName",
    "MONGO_COLLECTION_NAME": "collectionName"
  },
  "gen": 2
}
```

**Explanation of keys:**

| Key                       | Description                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------- |
| **name**                  | Unique name for the Cloud Run service                                                             |
| **region**                | GCP region for deployment (`europe-central2`, etc.)                                               |
| **runtime**               | Python version to use (`python311`, `python312`, etc.)                                            |
| **entry_point**           | Name of the function to invoke (defined in `main.py`)                                             |
| **trigger**               | `http` for publicly accessible APIs                                                               |
| **allow_unauthenticated** | `true` if no auth is required (public API)                                                        |
| **env**                   | Dictionary of environment variables (e.g., DB credentials)                                        |
| **gen**                   | `2` for Cloud Run deployment Gen 2 (recommended), `1` for legacy Gen 1 Cloud Functions Deployment |

---

## 🚀 Deploying the Function

Once your folder and files are ready:

1. **Commit and Push** the changes to the `main` branch of the GitHub repo.
2. GitHub Actions will automatically build and deploy your function using the `deploy.yml` workflow.

You can monitor the deployment in:

- The **GitHub Actions tab** of the repo
- The **Cloud Run** section of GCP console

---

## ✅ Verifying Deployment

After deployment, verify:

- The function appears under **Cloud Run** in your GCP project.
- The endpoint is accessible using the deployed URL.
- Environment variables are correctly passed and used.
- Logs (via **Cloud Logging**) do not contain errors.

---

## 🧠 Notes & Best Practices

- **Each function runs independently** in its own container with isolated environment.
- **Avoid hardcoding secrets** — use environment variables from `config.json`.
- **Use `functions-framework`** for handling requests. It provides a simple way to wrap your function for HTTP serving.
- **Make sure `PORT=8080`** is exposed and used in Dockerfile (Cloud Run requires it).
- **Always include a `startupProbe`** if your function takes time to initialize.

---

## 🧪 Example: `main.py`

```python
import os, json
from pymongo import MongoClient, errors
from flask import make_response, request
from functions_framework import http

@http
def create_sessions_order_endpoint(request):
    client = MongoClient(os.environ.get("MONGO_CONNECTION"))
    db = client[os.environ.get("MONGO_DB_NAME")]
    collection = db[os.environ.get("MONGO_COLLECTION_NAME")]

    body = request.get_json(silent=True)
    if not body:
        return make_response(("Missing data", 400))

    collection.insert_one(body)
    return make_response(("Inserted", 200))
```

---

## 📦 Example: `requirements.txt`

```
functions-framework==3.*
pymongo
flask
```

---

## 🐳 Example: `Dockerfile`

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

ENV PORT=8080

CMD exec functions-framework --target=${FUNCTION_TARGET} --port=${PORT}
```

🟡 **Tip:** Make sure the python version is the same as `runtime`

---

## ⚠️ CORS Support

If your function is used by a web frontend:

- Add CORS headers in the Python response handler
- Configure the **allowed origins** in your **API Gateway** settings (if applicable)

---

## 🔄 Migrating from Manual GCP UI

If you previously created functions using the "Write a function" button in the GCP UI:

> 💡 Those are now deprecated in favor of GitHub-based, CI/CD-managed functions. This ensures:
>
> - Version control
> - Automatic deployment
> - Consistency across environments
