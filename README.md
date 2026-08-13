# CO-OP World Documentation Repository

This repository contains the documentation, schematics, and configuration logs for the **CO-OP World** pediatric research game platform. It is designed to help researchers, clinicians, and developers manage participant onboarding, database sessions, and experimental variants.

---

## 1. Repository Structure

*   **`docs/`**: The main directory containing Jekyll-compatible markdown documentation pages.
    *   **`docs/Game/Versions/`**: Detailed pages for each active study version (e.g., `Felix.md`, `Competitive.md`, `Autistic.md`, `Summary.md`).
    *   **`docs/Game/Summary.md`**: Main game version summary table.
    *   **`docs/Addons/`**: Documentation for auxiliary tools like User Management and QA.
    *   **`docs/MongoDB/`**: Documentation of the MongoDB collections structure.
*   **`assets/`**: Repository of visual screenshots and system layout diagrams used in grant proposal guides.
*   **`sessions.json`**: Source of truth config file containing active level arrays and strategy attributes defined in the database.
*   **`Coop_Schematics.md`**: The unified guide containing the study design flowchart, database profiles, and the visual assets catalog.
*   **`diagram.md`**: Standalone source code of the unified Mermaid study design flowchart.
*   **`conbine.sh`**: Compilation bash script that concatenates all subfiles in `docs/` into a single unified markdown document.
*   **`combined_documentation.md`**: The generated, compiled file containing all repository documentation.

---

## 2. Session Mapping & Source of Truth

The game client behavior is driven by database-defined sessions. All documentation files **must** align with the settings defined in `sessions.json`:
*   **Active Levels**: The array of level integers (e.g., Levels 21–27 for `exp-competitive`) is defined here.
*   **Strategic Profiles**: Game versions are selected via dropdown configurations matching the session names (like `FullTFT` or `ָAutistic`).
*   **Obsolete User IDs**: Historical user IDs are deprecated. All active research accounts are configured dynamically in the User Management Portal or URL parameters via the matching session configurations.

---

## 3. Rebuilding the Documentation

Whenever you edit files inside the `docs/` folder, regenerate the master document by running the compile script:
```bash
./conbine.sh
```
*(Ensure all local changes are saved before running the compiler).*
