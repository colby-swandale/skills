---
name: writing-ticks
description: Audit and edit drafts for writing patterns that read as AI-generated, generic, over-polished, or unlike the author's voice. Use when reviewing prose, social posts, docs, articles, comments, PR descriptions, public writing, or outbound messages for AI tells, canned structure, weak specificity, style ticks, or when the user asks to make writing sound more natural without flattening their voice.
---

# Writing Ticks

## Overview

Review writing for "ticks" that can make it sound AI-generated, generic, over-smoothed, or less like the author. Use the Wikipedia page "Wikipedia:Signs of AI writing" as a field guide, not as a detector or accusation engine.

## Workflow

1. Read the target text carefully before editing. If the user includes surrounding context, use that to infer audience, medium, and desired voice.
2. Use the built-in checklist for fast reviews. Open `https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing` only when the user asks for a source-backed audit, the draft is high-visibility, or the local checklist feels insufficient.
3. Identify only patterns that actually appear in the draft. Do not force every category.
4. Separate high-confidence issues from taste preferences.
5. Preserve the author's intent, cadence, and useful specificity. Prefer small edits over a full rewrite unless the user asks for one.
6. Return concrete edits, not vague advice.
7. If the user asks for a rewrite, provide a ready-to-send version first, then a short rationale.

## Audit Checklist

Scan for these common categories:

- Generic significance inflation: claims that something is vital, pivotal, enduring, transformative, or part of a broader trend without evidence.
- Canned notability or attribution: repeated references to media coverage, independent sources, experts, or importance that do not add substance.
- Superficial analysis: conclusions that sound polished but do not say anything specific, testable, or useful.
- Promotional language: marketing copy, puffery, and phrases that oversell ordinary facts.
- Vague attribution: "many believe", "experts say", "widely regarded", or broad claims without named people, sources, or examples.
- Future-prospect endings: tidy conclusions about challenges, opportunities, innovation, or continued evolution.
- AI-vocabulary density: clusters of words such as delve, landscape, testament, underscores, showcases, intricate, robust, seamless, foster, leverage, crucial, or transformative.
- Stock rhetorical shapes: "not only X but also Y", forced rule-of-three lists, and contrast structures that sound automatic.
- Over-varied wording: replacing a simple repeated noun with many synonyms that make the prose less clear.
- Formatting tells: excessive bold, title-case headings, inline-header lists, unnecessary tables, thematic breaks, skipped heading levels, or Markdown artifacts in contexts where they do not belong.
- Punctuation tells: overuse of em dashes, curly quotes in otherwise plain text, or punctuation choices that do not match the author's usual style.
- Canned assistant language: collaboration boilerplate, knowledge-cutoff disclaimers, placeholders, or meta-commentary that should not be in final prose.
- Citation and markup errors: broken links, fake-looking references, stray citation placeholders, unused named references, or source details that look invented.

## Output Shape

For quick requests, return the revised text first. For review requests, use this structure unless the user asks for another format:

1. `Strongest ticks`: a short list of the most visible patterns, with quoted snippets when helpful.
2. `Suggested edits`: focused replacements or a clean revised version.
3. `Keep`: anything distinctive, specific, or voice-y that should not be smoothed away.

Keep the tone practical. Do not say the piece "is AI-written" unless the task is explicitly about evidence for authorship and the evidence supports that careful framing.

## Editing Principles

- Increase specificity before changing style: named examples, concrete verbs, and real constraints usually help more than prettier wording.
- Remove generic polish when it hides the point.
- Keep productive messiness: contractions, direct phrasing, plain nouns, and a little asymmetry can make writing feel authored.
- Do not add new facts, citations, claims, or confidence the author did not supply.
- Avoid introducing the same tick you just diagnosed in the replacement text.
