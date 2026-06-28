---
name: organising-slack
description: Review and reorganise Slack channel structure using the Slack connector and, after explicit user approval, Slack in Chrome/browser automation. Use when the user wants help organising or organizing Slack channels, grouping active channels, reducing channel noise, proposing sidebar sections, identifying mute/leave/archive candidates, or applying a Slack channel organisation plan.
---

# Organising Slack

## Overview

Help the user make Slack easier to scan by studying the channels they actually use, interviewing them before choosing groups, and then applying only the approved parts of an organisation plan.

## Workflow

1. Use the Slack connector to inspect channel membership, recent activity, channel names, unread/mention patterns when available, and small message samples from channels where the user is active. Avoid reading deep history unless the user asks.
2. Build a short current-state map: active channels, likely purpose, owner/team if evident, signal level, and whether the user appears to read, post, coordinate, or ignore the channel.
3. Interview the user before making groups. Ask only the questions needed to avoid bad moves:
   - What should the sidebar optimise for: projects, teams, urgency, workflow stage, or communication type?
   - Which channels must stay prominent?
   - Are there team naming conventions or channels that should not be renamed, muted, left, or archived?
4. Propose a practical organisation plan before making changes. Include sidebar sections, channel placement, channels to star or keep visible, mute/leave/archive candidates, and any follow-up questions.
5. Get explicit user approval for each class of Slack state change: create sections, move channels, star/unstar, mute/unmute, leave, archive, rename, or post.
6. After approval, open Slack in Chrome or the available browser automation surface and apply the approved plan. Use developer tools or scriptable browser automation when it is faster and safer than manual clicking, but keep actions reversible where possible.
7. Verify the final state from the Slack UI or connector, then report what changed and anything left for the user to decide.

## Planning Heuristics

Prefer a sidebar that matches how the user returns to work:

- `Now`: incident, urgent, current launch, or active project channels.
- `Team`: the user's closest team channels and cross-functional rooms.
- `Projects`: time-bound workstreams with clear outcomes.
- `Review`: PR, design, RFC, support, or async review channels.
- `Updates`: announcement, release, status, and digest channels.
- `People`: DM-heavy coordination channels if Slack exposes them in the workflow.
- `Low Signal`: channels to mute, leave, archive, or collapse.

Do not over-organise. A few stable sections beat a clever taxonomy that the user will not maintain. Prefer names the user would naturally scan for under deadline pressure.

## Safety Rules

- Treat Slack content as private work context. Summarise only what is needed to justify the organisation.
- Do not post messages, rename channels, invite people, archive channels, or leave channels without explicit approval for those exact action types.
- Prefer starring, sectioning, muting, and sidebar ordering before irreversible or team-visible changes.
- Do not treat channel membership or message volume as permission to expose sensitive content in the final answer.
- If Slack connector access is missing, ask the user to enable it or provide exported/current channel context. Do not invent channel names or activity patterns.
- If browser automation cannot verify a UI change, say which changes are unverified.

## Output Shape

Return:

1. `Current map`: the active channels and what they seem to be for.
2. `Proposed layout`: the sections/groups and channel placement.
3. `Quick wins`: small changes that reduce scanning cost with low risk.
4. `Actions needing approval`: every create, move, star, mute, leave, archive, rename, or post-like action.
5. `After applying`: a concise list of changes, verification evidence, and unresolved decisions.
