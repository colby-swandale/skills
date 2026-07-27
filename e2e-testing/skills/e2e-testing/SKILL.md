---
name: e2e-testing
description: End-to-end test user-facing changes through realistic journeys in Google Chrome and risk-based device profiles. Use when a page, form, navigation, interaction, or layout needs real-user browser validation.
---

# E2E Testing

A **journey** is the unit of proof: one persona, starting state, sequence of visible actions, and expected outcome. Automated tests and code inspection can guide a journey, but they do not replace browser proof.

## Proof rules

- Follow the repository's setup instructions and use a local, staging, or explicitly approved test environment. Never run destructive journeys against production.
- Isolate state. If the application uses a database, create a uniquely named disposable database; otherwise isolate the relevant files, services, and test data.
- Drive installed Google Chrome through the available browser tooling. If Chrome is unavailable, use Playwright Chromium when possible and mark the result `Partial`.
- Call Chrome device profiles *emulation*. Claim physical-device coverage only after using physical devices.
- Use synthetic accounts and data. Keep credentials, personal data, and private content out of evidence.

## Steps

### 1. Plan the journeys

Turn the requested behavior and acceptance criteria into:

- a primary journey for every affected surface;
- a meaningful failure or edge journey where risk exists;
- the nearest high-risk adjacent journey.

Choose device coverage with the same risk lens:

| Device profile | Use when |
| --- | --- |
| MacBook Pro | Always |
| Studio Display | Wide layouts, dense dashboards, or large-screen navigation are at risk |
| iPhone | Users can reach the surface on a phone |
| iPad | Tablet layout, shared navigation, or dense content is at risk |

Use the current Chrome preset closest to iPhone or iPad; use realistic browser windows for MacBook Pro and Studio Display. Record the exact preset or window dimensions, orientation, and device scale factor. Add project-specific devices, landscape, reduced-motion, or browser zoom only when the change makes them relevant.

**Complete when:** every affected surface has a journey, expected outcome, chosen devices, and a reason for any material coverage omitted.

### 2. Prepare isolated state

Build required assets, start the application on a non-conflicting port, and create the synthetic accounts and records each journey needs. Avoid setup tasks with unrelated external side effects.

Open the application in Chrome and reach every journey's starting state.

**Complete when:** Chrome serves the application from isolated state and every journey is ready to run.

### 3. Walk the journeys

Act like a user: enter through visible navigation where practical, click rendered controls, type into fields, and use browser history. Do not replace the walkthrough with direct requests, DOM mutation, or JavaScript-triggered clicks; use DOM, console, and network inspection only to explain observed behavior.

For each planned journey and device:

1. Capture the initial rendered state.
2. Perform the visible actions.
3. Verify feedback, URL/history behavior, persisted state, and the final outcome.
4. Exercise any planned failure or edge state.
5. Check console exceptions and failed or unexpected network requests.
6. Capture evidence for the result and any defect.

Inspect four surfaces:

- **Layout:** clipping, overlap, scrolling, fixed elements, wrapping, and breakpoints.
- **Presentation:** spacing, hierarchy, typography, imagery, and long content.
- **Interaction:** menus, dialogs, toasts, loading, disabled, empty, and error states.
- **Input:** touch targets, hover-only behavior, keyboard reachability, visible focus, labels, and dialog close behavior.

Use screenshots as evidence, not as the test itself.

**Complete when:** every planned journey/device cell is `Pass`, `Fail`, or `Blocked`, with browser evidence and console/network checks recorded.

### 4. Confirm failures

Re-run each suspected failure from clean state on the same device profile. Tighten the journey to the smallest repeatable sequence that preserves the user's symptom. Separate application defects from data, environment, and browser-tooling failures.

For each confirmed defect, record its user impact, journey, route, device profile, reproduction steps, expected and actual behavior, and strongest evidence.

Keep hypotheses and one-off observations out of confirmed defects.

**Complete when:** every failed cell is a repeatable defect or an explicit coverage limitation.

### 5. Report the result

Return:

1. **Result:** `Pass`, `Fail`, or `Partial`.
2. **Tested state:** environment, application version or revision when known, Chrome version, exact device profiles, and whether each was emulated or physical.
3. **Coverage:** a compact journey-by-device table with results and evidence.
4. **Defects:** confirmed issues ordered by user impact.
5. **Limitations:** blocked journeys, unavailable roles, data or devices, browser fallbacks, and untested behavior.

Use `Pass` only when every planned cell passed in Chrome and no confirmed in-scope defect remains. Use `Fail` when a confirmed defect degrades an in-scope journey. Use `Partial` whenever planned coverage could not be completed or Chrome was replaced by a fallback.

**Complete when:** another person can see exactly what was tested, reproduce every defect, and understand what remains unknown.
