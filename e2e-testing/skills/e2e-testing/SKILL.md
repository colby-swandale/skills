---
name: e2e-testing
description: Run end-to-end browser testing for UI/UX changes by walking realistic user journeys in Google Chrome, checking responsive behavior across representative viewports, and reporting reproducible results. Use when a change needs real-user validation of pages, forms, navigation, interactions, styling, accessibility, or device layouts.
---

# E2E Testing

Treat the browser as the source of truth. Automated tests and code inspection do not prove what a user sees or can complete.

## Guardrails

- Follow the repository's setup instructions. Use a uniquely named, disposable database and isolated test data.
- Use a local, staging, or explicitly approved test environment. Never run destructive journeys against production.
- Drive installed Google Chrome through the available browser tooling. If Chrome is unavailable, use Playwright Chromium when possible and mark the result `Partial`.
- Call resized viewports or DevTools profiles *emulation*. Do not claim physical-device coverage without physical devices.
- Use synthetic accounts and data. Keep credentials, personal data, and private content out of screenshots and reports.

## Workflow

### 1. Define the journeys

Turn the requested behavior and acceptance criteria into user journeys. For each journey, record:

- persona and starting state;
- entry point;
- user actions;
- expected visible result;
- an important alternate state, such as validation failure, empty data, permissions, loading, or retry.

Include the primary happy path for every affected surface, relevant failure behavior, navigation into and out of the flow, and the nearest high-risk adjacent journey.

**Complete when:** every affected surface maps to a journey with a clear starting state and expected result.

### 2. Prepare isolated state

Create a disposable database and test data, build required assets, and start the application on a non-conflicting port. Avoid setup tasks with unrelated external side effects.

Open the application in Chrome and confirm every persona can reach the starting state.

**Complete when:** the application loads in Chrome with isolated data and every journey is ready to run.

### 3. Build the coverage matrix

Use the application's supported devices when specified. Otherwise test:

| Profile | Viewport | Purpose |
| --- | --- | --- |
| Desktop | 1440 × 900 | Full navigation and primary layout |
| Mobile | 390 × 844 | Touch-sized narrow layout |
| Tablet | 768 × 1024 | Intermediate breakpoint and wrapping |

Run every primary journey on all three profiles. Run alternate and adjacent journeys on desktop and the riskiest narrow profile. Add small-mobile, landscape, high-DPI, hover, reduced-motion, or browser-zoom coverage when relevant.

**Complete when:** every journey has explicit viewport coverage.

### 4. Walk the journeys in Chrome

Act like a user. Enter through visible navigation where practical, click rendered controls, type into fields, use browser history, and observe feedback. Do not replace the walkthrough with direct HTTP requests, DOM mutation, or JavaScript-triggered clicks. Use DOM, console, and network inspection only to explain observed behavior.

For each journey:

1. Capture the initial rendered state.
2. Perform the planned actions.
3. Verify visible feedback, URL/history behavior, persisted state, and the final outcome.
4. Exercise the alternate state.
5. Check console exceptions and failed or unexpected network requests.
6. Capture evidence for the result and any defect.

On each required viewport, inspect:

- clipping, overflow, overlap, unexpected scroll, and fixed or sticky elements hiding content;
- spacing, alignment, hierarchy, typography, image quality, wrapping, and breakpoint transitions;
- menus, dialogs, tooltips, toasts, loaders, disabled states, empty states, errors, and long content;
- touch targets on narrow profiles and hover-only behavior on desktop;
- keyboard reachability, visible focus, logical focus movement, labels, and dialog close behavior.

Use screenshots as evidence, not as the test itself.

**Complete when:** every matrix cell has `Pass`, `Fail`, or `Blocked`, with browser evidence and console/network checks recorded.

### 5. Confirm failures

Re-run suspected failures from a clean starting state. Separate application defects from test-data, environment, or browser-tooling failures.

For each reproducible defect, record:

- user impact;
- journey, route, and viewport;
- exact reproduction steps;
- expected and actual behavior;
- screenshot, recording, console, DOM, or network evidence.

Keep hypotheses and one-off observations out of confirmed defects.

**Complete when:** every failed cell is a reproducible defect or an explicit coverage limitation.

### 6. Report the result

Return:

1. **Result:** `Pass`, `Fail`, or `Partial`.
2. **Tested state:** environment, application version or revision when known, Chrome version, and whether devices were emulated or physical.
3. **Coverage:** a compact journey-by-viewport table with results and evidence.
4. **Defects:** reproducible issues ordered by user impact.
5. **Limitations:** blocked journeys, unavailable roles/data/devices, browser fallbacks, and untested behavior.

Use `Pass` only when every required cell passed in Chrome and no confirmed in-scope defect remains. Use `Fail` when a confirmed defect degrades an in-scope journey. Use `Partial` whenever required coverage could not be completed or Chrome was replaced by a fallback.

**Complete when:** another person can see exactly what was tested, reproduce every defect, and understand what remains unknown.
