---
layout: default
title: Shared Modules System
nav_order: 6
parent: Backend
---

# Shared Modules System

Cloud Functions are isolated deployment units that cannot naturally import code from parent directories. However,
there is shared code that multiple functions may use, like logging, CORS handling, or database connections.
Without a shared mechanism, developers are forced to duplicate that code across every function.

Our **Shared Modules System** solves this via **Deployment-Time Injection**. Shared code is maintained in a central
directory and automatically injected into the required function directories during deployment (and locally via a sync
script).

Right now, not many cloud functions are adapted to use Shared Modules. However, you are encouraged to use them in new
functions you write and (carefully) convert existing functions to use them too (notice many old functions have
duplicated code in them).
In addition, after finish reading this manual, you may look at `generate-decision-explanation` and
`mock-decision-explanation` as an example of functions that already use Shared Modules.

---

## Repository Structure

The top-level `shared/` directory holds the shared modules. Each directory in `shared` is a Shared Module.
The `common` module is a special module that is automatically injected into **every** function (explained below).

```text
CloudFunctions/
├── shared/                 # Shared Modules directory
│   ├── common/             # Copied to EVERY function automatically
│   │   ├── __init__.py
│   │   └── logging.py
│   ├── validation/         # Custom Module
│   │   ├── __init__.py
│   │   └── parameter_validation.py
│   └─ ...
├── functions/
│   ├── func_a/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── config.json     # Shared Modules are requested here
│   └─ ...
└── .gitignore              # Ignores functions/*/shared/
```

## Types of Shared Modules

It is critical to inject to each cloud function only code that it actually uses to prevent deployment bloat.

That's why there are two types of Shared Modules:

* **`common` Module:** A special Shared Module that is automatically copied to all functions. Reserve this for universal
  utilities that nearly every function requires, such as standardized logging formatters, global error handlers, or CORS
  utilities. You may look at what is already in `common` as an example.
* **Custom Modules:** Code that is shared among several functions, but not all. Each directory inside `shared` is a
  module. Functions must explicitly **request** these modules (besides `common` that doesn't need to be requested and
  injected automatically to all functions). It is explained below how a function requests a module and how to use it.

---

## How to Use Shared Modules (Step-by-Step)

### 1. Identify and Create the Module

When you notice duplicated logic across functions, extract it into the `shared/` directory. First, look for a module
that already exists where it may make sense to put it.

If there is no existing module where it makes sense, create a new module:
1. Create a new folder: `shared/your_module_name/`
2. Add your Python files.
3. Ensure the folder contains an `__init__.py` file so Python treats it as a package. In the init file, you may also
   put a short explanation of what the module contains or what the code in it does. See existing modules for examples.

### 2. Declare the Module in config.json

If you want to use a custom module (anything other than `common`), you must explicitly request it in the cloud function
that uses it, in it's `config.json` file. This tells the deployment script (`deploy.yml`) to inject that module into
the function's directory on deployment.

Open the function's `config.json` and add the module name to a `shared_modules` array field:

```json
{
  "name": "my-function",
  "entry_point": "main",
  "runtime": "python311",
  "shared_modules": ["validation", "decorators"],
  ...
}
```
Here we are requesting the `validation` and `decorators` modules, as an example.

_(Note: You do not need to list `common`; it is injected automatically)_

### 3. Import the Module

Inside your Cloud Function, import the code using the `shared.` namespace. The import paths assume the code exists
within the function's own directory.

```python
# Importing from the universal common module
from shared.common.logging import log_details
```

```python
# Importing from a custom module
from shared.validation.parameter_validation import validate_parameters, Parameter
```

---

## Local Development Setup

Because your Python code imports from a local `shared/` directory (`from shared...`), your imports will break during
local development unless that directory actually exists inside your function's folder.

The CI/CD deployment script handles this injection in the cloud, but for local development, you must use the provided
sync script.

### Using `sync_shared_modules.sh`

Whenever you are working on a cloud function that uses a shared module, and that module's code gets updated (e.g.,
pull new changes, or modify code yourself inside the shared module's directory), you must run the sync script.
That keeps those changes in sync, so local testing will contain the updated shared module's code.
This script reads the `config.json` of each function and copies the appropriate modules into their respective
directories, similar to how the deployment script does it.

The script is located at the top-level directory: `CloudFunctions/sync_shared_modules.sh`. It contains its own
documentation, but here is a quick summary:

**To sync all functions:**
```bash
./sync_shared_modules.sh
```

**To sync specific function(s):** provide the function name(s) as arguments.
```bash
./sync_shared_modules.sh func_a func_b
```

**To clean up from all functions (remove injected folders):**
```bash
./sync_shared_modules.sh --clean
```

**To clean up from specific function(s):** provide the function name(s) as arguments in addition to the `--clean` flag.
```bash
./sync_shared_modules.sh --clean func_a func_b
```

### Git Integrity

You do not need to worry about accidentally committing the files generated by the sync script. The root `.gitignore`
contains the rule `functions/*/shared/`. This ensures that all code injected by the local sync script remains strictly
local and is never pushed to the repository.

Ensure dependencies required by your shared modules are added to the function's `requirements.txt`.

