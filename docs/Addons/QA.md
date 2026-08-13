---
layout: default
title: QA Analysis
nav_order: 7
parent: Addons
---

# Co-Op QA

The Co-Op QA website runs automatic validation tests on saved game sessions **after the fact** to ensure all session data is correct, complete, and meets experiment-specific expectations.

## How It Works

1. **Select an Input Mode**:
   - **By User IDs**: Input specific user IDs (comma- or space-separated) to run validation tests on them.
   - **By Date Range**: Select a start and end date. This queries the level play records on the backend to fetch all users who played levels during that time. The users are sorted/grouped by their **Experimenter** to execute the correct test suite for each user.
2. **Select Fallback Test Version**: Choose a default/fallback test suite to run in case a user's experimenter is not mapped to a specific suite.
   - **Automatic Suite Mapping**: If the user's experimenter name is recognized (case-insensitively), it automatically runs the mapped suite, overriding the selected fallback:
     - **Zohar Atias** $\to$ Full TFT (`fullTft`)
     - **Full TFT** $\to$ Full TFT (`fullTft`)
     - **Kasia** $\to$ Felix Version (`felix`)
     - **Ana** $\to$ Macedonian Study (`macedonian`)
     - **test** $\to$ Macedonian Study (`macedonian`) & marked as a **Test User**.
3. **Run the tests** — the system initiates data fetching:
   - **Primary Fetch**: It requests the user's sessions from the Parents Dashboard endpoint. It always automatically fetches the full records for all levels to ensure a complete picture of the session data.
   - **Fallback Fetch**: If the Parents Dashboard endpoint returns no requests, it falls back to fetching user records from the `fetchUserInfo` function.
4. **Duplicate Record Check**: If a level query returns multiple records for the same level number, it outputs a warning and automatically uses the latest record for validation.
5. **View feedback**:
   - **Categorization**: Results are grouped and displayed by the specific test suite run.
   - **Target Date Badge**: Levels actually played within the specified date range bounds are marked with a blue **Target Date** badge.
   - **Test User Badge**: Users associated with the experimenter `test` are visually labeled with a purple `Test User` badge next to their User ID in the header.
   - Per-level checks show which tests passed (green), passed with warnings (yellow), or failed (red).

**Understanding Results:**
- **Green (Pass)**: Test passed all checks.
- **Yellow (Warning)**: Test passed but with a minor issue detected (e.g., level completed relatively quickly, duplicate level logs). Session is still usable.
- **Red (Fail)**: Test failed a critical check (e.g., level too short, missing required help requests, invalid TFT behavior, incorrect level count). Session may need to be excluded from analysis.

## Why Use It

- Verify session data integrity after gameplay (no missing events, corrupted saves, or anomalies).
- Validate that session outcomes match expected behavior for the study.
- Quickly spot outliers and problematic sessions before analysis.

## Access Information

- **Repository**: [Co-Op QA](https://github.com/CoOp-World/Co-Op-QA){:target="_blank"}
- **Dashboard URL**: [https://co-op-qa-791222378113.europe-west1.run.app/](https://co-op-qa-791222378113.europe-west1.run.app/){:target="_blank"}

---

## CSV Export Options

After running tests, you can export the analyzed results into two types of CSV reports:

### 1. Download Good CSV
- **Criteria**: Includes level data only for users who have **fully passing** sessions (no failed checks and no warnings in the summary level checks).
- **Structure**: Generates a standard flat list of all level parameters, omitting internal/debug identifiers (like MongoDB IDs, screenshot counts, raw textual outputs).

### 2. Download Problematic CSV
- **Criteria**: Includes data only for users who have **at least one warning or failure** (in their level checks or summary-level validations).
- **Structure**: Includes the same fields as the Good CSV but appends a **Flag_Reason** column detailing exactly which tests or summary checks failed/warned.

### Help Request Expansion in CSVs
If a level contains help requests:
- Instead of exporting one row per level, the export generates **one row per help request** for that level.
- Additional columns prefixed with `HR - ` are appended, containing details about each request (e.g., `HR - Help Asker`, `HR - Was Accepted`, `HR - Help Strategy`, etc.).
- If there are no help requests on a level, a single row is written with empty `HR -` fields.

---

## Test Suites

Here is a summary of the expectations and tests run for each test suite:

### Macedonian Study
- **Level Requirements**: Expected level count is exactly **8** (including introduction). Skips tests on the introduction level.
- **Tests run**:
  1. **Help Requests Check**:
     - Verifies a total of **8** help requests are present.
     - Confirms exactly **4** were asked by the human player and exactly **4** by the virtual player.
  2. **Tit For Tat (TFT)**:
     - For every virtual player's help request, the virtual player's decision should match the human player's response to the previous virtual help request.
     - Calculates TFT adherence percentage. (Fluctuating behavior is normal; should not be 100% all the time).
  3. **Timestamps & Timing Check**:
     - Validates that within each help request, `answer_time >= asking_time`.
     - Validates that help requests happen during the level (`asking_time >= start_time` and `answer_time <= end_time`).
     - **Transition Verification**: Ensures the start time of the current level is **after the end time of the previous level**. This check is skipped for Level 1 (Intro) and Level 2 (since the Intro has no recorded end time). Shows the exact time elapsed between levels.
     - **Level Duration Check**: Confirms level duration is $\ge$ 2 minutes (fails if under 2m) and warns if completed in under 2.5 minutes.
  4. **Level Consistency**:
     - Assures basic fields (`level_key`, `level_num`, `map_name`) are present.
     - If global level configs are loaded in Phaser, verifies the background and level number match the configuration rules.

### Autistic Study
- **Level Requirements**: Expected level count is exactly **8** (including introduction). Skips tests on the introduction level.
- **Tests run**:
  1. **Help Requests Check**:
     - Verifies a total of **8** help requests are present.
     - Confirms exactly **4** were asked by the human player and exactly **4** by the virtual player.
  2. **Tit For Tat (TFT)**:
     - For every virtual player's help request, the virtual player's decision should match the human player's response to the previous virtual help request.
     - Calculates TFT adherence percentage. (Fluctuating behavior is normal; should not be 100% all the time).
  3. **Timestamps & Timing Check**:
     - Validates that within each help request, `answer_time >= asking_time`.
     - Validates that help requests happen during the level (`asking_time >= start_time` and `answer_time <= end_time`).
     - **Transition Verification**: Ensures the start time of the current level is **after the end time of the previous level**. This check is skipped for Level 1 (Intro) and Level 2 (since the Intro has no recorded end time). Shows the exact time elapsed between levels.
     - **Level Duration Check**: Confirms level duration is $\ge$ 2 minutes (fails if under 2m) and warns if completed in under 2.5 minutes.
  4. **Level Consistency**:
     - Assures basic fields (`level_key`, `level_num`, `map_name`) are present.
     - If global level configs are loaded in Phaser, verifies the background and level number match the configuration rules.

### Full TFT
- **Level Requirements**: Expected level count is exactly **8** (including introduction). Skips tests on the introduction level.
- **Tests run**:
  1. **Help Requests Check**:
     - Verifies a total of **8** help requests are present.
     - Confirms exactly **4** were asked by the human player and exactly **4** by the virtual player.
  2. **Tit For Tat (100%)**:
     - For every virtual player's help request, the virtual player's decision should match the human player's response to the previous virtual help request.
     - Enforces exactly 100% TFT adherence (fails if any virtual response does not follow the human player's prior response).
  3. **Timestamps & Timing Check**:
     - Validates that within each help request, `answer_time >= asking_time`.
     - Validates that help requests happen during the level (`asking_time >= start_time` and `answer_time <= end_time`).
     - **Transition Verification**: Ensures the start time of the current level is **after the end time of the previous level**. This check is skipped for Level 1 (Intro) and Level 2 (since the Intro has no recorded end time). Shows the exact time elapsed between levels.
     - **Level Duration Check**: Confirms level duration is $\ge$ 2 minutes (fails if under 2m) and warns if completed in under 2.5 minutes.
  4. **Level Consistency**:
     - Assures basic fields (`level_key`, `level_num`, `map_name`) are present.
     - If global level configs are loaded in Phaser, verifies the background and level number match the configuration rules.

### Deaf Study
- **Level Requirements**: Expected level count is exactly **7** (including introduction). Skips tests on the introduction level.
- **Tests run**:
  1. **Help Requests Check**:
     - Verifies a total of **8** help requests are present.
     - Confirms exactly **4** were asked by the human player and exactly **4** by the virtual player.
  2. **Tit For Tat (100%)**:
     - For every virtual player's help request, the virtual player's decision should match the human player's response to the previous virtual help request.
     - Enforces exactly 100% TFT adherence (fails if any virtual response does not follow the human player's prior response).
  3. **Timestamps & Timing Check**:
     - Validates that within each help request, `answer_time >= asking_time`.
     - Validates that help requests happen during the level (`asking_time >= start_time` and `answer_time <= end_time`).
     - **Transition Verification**: Ensures the start time of the current level is **after the end time of the previous level**. This check is skipped for Level 1 (Intro) and Level 2 (since the Intro has no recorded end time). Shows the exact time elapsed between levels.
     - **Level Duration Check**: Confirms level duration is $\ge$ 2 minutes (fails if under 2m) and warns if completed in under 2.5 minutes.
  4. **Level Consistency**:
     - Assures basic fields (`level_key`, `level_num`, `map_name`) are present.
     - If global level configs are loaded in Phaser, verifies the background and level number match the configuration rules.

### Felix Version
- **Level Requirements**: Expected level count is exactly **10** (including introduction). Skips tests on the introduction level.
- **Tests run**:
  1. **No Help Requests**:
     - Asserts that no help requests were recorded during the level.
  2. **Decision Choice & Timing**:
     - Validates that the level decision start time and end time parse correctly.
     - Confirms `decision_end_time >= decision_start_time`.
     - Validates that the logged `choice` is either `slow` or `fast`.
  3. **Level Consistency**:
     - Assures basic fields (`level_key`, `level_num`, `map_name`) are present.
     - If global level configs are loaded in Phaser, verifies the background and level number match the configuration rules.
