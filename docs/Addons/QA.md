---
layout: default
title: QA Analysis
nav_order: 7
parent: Addons
---

# Co-Op QA

The Co-Op QA website runs automatic validation tests on saved game sessions **after the fact** to ensure all session data is correct, complete, and meets experiment-specific expectations.

## How It Works

1. **Select a test suite** corresponding to the experiment or study the user participated in (e.g., Macedonian Study, Felix Version).
2. **Choose user IDs** or a range of users to validate.
3. **Run the tests** — the system fetches their session data and runs all checks for that suite.
4. **View feedback** — results display per-level, showing which tests passed (green), passed with warnings (yellow), or failed (red).

**Understanding Results:**
- **Green (Pass)**: Test passed all checks.
- **Yellow (Warning)**: Test passed but with a minor issue detected (e.g., low FPS duration, timing just below threshold). Session is still usable.
- **Red (Fail)**: Test failed a critical check (e.g., level too short, FPS below minimum, data corruption). Session may need to be excluded from analysis.


## Why Use It

- Verify session data integrity after gameplay (no missing events, corrupted saves, or anomalies).
- Validate that session outcomes match expected behavior for the study.
- Quickly spot outliers and problematic sessions before analysis.

## Access Information

- **Repository**: [Co-Op QA](https://github.com/CoOp-World/Co-Op-QA){:target="_blank"}
- **Dashboard URL**: [https://co-op-qa-791222378113.europe-west1.run.app/](https://co-op-qa-791222378113.europe-west1.run.app/){:target="_blank"}

## Test Suites — Summary of which tests are run on each test suite

## Macedonian Study

- **Description:** Intro + 7 levels; checks help-request counts, TFT behavior, timing, FPS, and level consistency.
- **Tests run:**
  - **Help Requests:** verifies `help_requests` array exists, total count, human vs virtual counts (expects 8 total; 4 human, 4 virtual).
  - **TFT (Tit For Tat):** for each virtual help request, records the human's response; compares the next human request’s acceptance to that prior human response (counts matches and reports %). Should be fluctuating and not 100% always.
  - **Timestamps & Timing:** parses asking/answer/start/end timestamps, ensures `answer >= asking`, `asking >= level start`, `answer <= level end`, computes level duration and average response time.
    - If `end_time` is before `start_time`, it shows a warning and uses `0s` duration instead of falling back silently.
    - If the level duration is under 2 minutes, the test fails.
    - If the level duration is under 2.5 minutes, it shows a warning.
  - **Performance / FPS:** asserts `fps_info.avg_fps >= 30` (fail if below), and scans `fps_info.arr` for sustained low-FPS runs (shows warnings for long runs below threshold).
  - **Level Consistency:** basic validation that `level_key`, `level_num`, and `map_name` are present; if frontend level configs are available, validates they match the expected background/level number.

## Autistic Study

- **Description:** Identical to the Macedonian suite.
- **Tests run:**
  - **Help Requests:** verifies `help_requests` array exists, total count, human vs virtual counts (expects 8 total; 4 human, 4 virtual). (same as Macedonian)
  - **TFT (Tit For Tat):** for each virtual help request, records the human's response; compares the next human request's acceptance to that prior human response (counts matches and reports %). Should be fluctuating and not 100% always. (same as Macedonian)
  - **Timestamps & Timing:** parses asking/answer/start/end timestamps, ensures `answer >= asking`, `asking >= level start`, `answer <= level end`, computes level duration and average response time.
    - If `end_time` is before `start_time`, it shows a warning and uses `0s` duration instead of falling back silently.
    - If the level duration is under 2 minutes, the test fails.
    - If the level duration is under 2.5 minutes, it shows a warning.
    (same as Macedonian)
  - **Performance / FPS:** asserts `fps_info.avg_fps >= 30` (fail if below), and scans `fps_info.arr` for sustained low-FPS runs (shows warnings for long runs below threshold). (same as Macedonian)
  - **Level Consistency:** basic validation that `level_key`, `level_num`, and `map_name` are present; if frontend level configs are available, validates they match the expected background/level number. (same as Macedonian)

## Full TFT

- **Description:** Same checks as Macedonian but enforces 100% TFT.
- **Tests run:**
  - **Help Requests:** verifies `help_requests` array exists, total count, human vs virtual counts (expects 8 total; 4 human, 4 virtual). (same as Macedonian)
  - **TFT (100%)**: requires all comparable virtual→human comparisons to match (100% matches expected).
  - **Timestamps & Timing:** parses asking/answer/start/end timestamps, ensures `answer >= asking`, `asking >= level start`, `answer <= level end`, computes level duration and average response time.
    - If `end_time` is before `start_time`, it shows a warning and uses `0s` duration instead of falling back silently.
    - If the level duration is under 2 minutes, the test fails.
    - If the level duration is under 2.5 minutes, it shows a warning.
    (same as Macedonian)
  - **Performance / FPS:** asserts `fps_info.avg_fps >= 30` (fail if below), and scans `fps_info.arr` for sustained low-FPS runs (shows warnings for long runs below threshold). (same as Macedonian)
  - **Level Consistency:** basic validation that `level_key`, `level_num`, and `map_name` are present; if frontend level configs are available, validates they match the expected background/level number. (same as Macedonian)

## Deaf Study

- **Description:** Same checks as Full TFT, but with intro + 6 levels total.
- **Tests run:**
  - **Help Requests:** verifies `help_requests` array exists, total count, human vs virtual counts (expects 8 total; 4 human, 4 virtual). (same as Macedonian)
  - **TFT (100%)**: requires all comparable virtual→human comparisons to match (100% matches expected). (same as Full TFT)
  - **Timestamps & Timing:** parses asking/answer/start/end timestamps, ensures `answer >= asking`, `asking >= level start`, `answer <= level end`, computes level duration and average response time.
    - If `end_time` is before `start_time`, it shows a warning and uses `0s` duration instead of falling back silently.
    - If the level duration is under 2 minutes, the test fails.
    - If the level duration is under 2.5 minutes, it shows a warning.
    (same as Macedonian)
  - **Performance / FPS:** asserts `fps_info.avg_fps >= 30` (fail if below), and scans `fps_info.arr` for sustained low-FPS runs (shows warnings for long runs below threshold). (same as Macedonian)
  - **Level Consistency:** basic validation that `level_key`, `level_num`, and `map_name` are present; if frontend level configs are available, validates they match the expected background/level number. (same as Macedonian)
- **Suite-level expectations:** `expectedLevelCount: 7` (intro + 6 levels).

## Felix Version

- **Description:** Felix-specific checks — expects 10 levels including intro, no help requests, and decision timing/choice fields.
- **Tests run:**
  - **No Help Requests:** asserts `help_requests` is empty.
  - **Decision Choice & Timing:** checks `decision_start_time` and `decision_end_time` parse to valid timestamps, ensures `decision_end_time >= decision_start_time`, and validates `choice` is `slow` or `fast`.
  - **Performance / FPS:** asserts `fps_info.avg_fps >= 30` (fail if below), and scans `fps_info.arr` for sustained low-FPS runs (shows warnings for long runs below threshold). (same as other suites)
  - **Level Consistency:** basic validation that `level_key`, `level_num`, and `map_name` are present; if frontend level configs are available, validates they match the expected background/level number. (same as other suites)
- **Suite-level expectations:** `expectedLevelCount: 10`; derives whether intro exists and skips intro-level tests.
