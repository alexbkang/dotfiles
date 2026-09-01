# My Agent Skills

Personal agent skills (slash commands and behaviors) loaded by my coding agents. The `~/.agents/skills` directory is a symlink to this folder, so edits here are live immediately.

## How to use

- **Edit a skill**: change the files in any skill folder here. The skill takes effect on the next session (or immediately for models that hot-reload).
- **Add a skill**: drop a new folder containing a `SKILL.md` here, or install one from elsewhere and move it in.
- **Remove a skill**: delete its folder.

## Provenance

These are my curated, modified copies — not pristine upstream files. Current contents were installed from my fork of [`mattpocock/skills`](https://github.com/mattpocock/skills) (MIT License, © Matt Pocock) on 2026-09-01, then changed to suit how I work. I may add skills from other sources over time; each one may carry its own origin.

Anything in here is mine to edit, break, and rework. No updates arrive behind my back — if I want upstream changes, I merge them in deliberately.

## Skills

- **code-review** — two-axis review of a diff: standards vs. spec
- **codebase-design** — deep-module vocabulary and discipline
- **diagnosing-bugs** — disciplined loop for hard bugs and regressions
- **domain-modeling** — sharpen the project's domain model and glossary
- **grill-me** — relentless interview about a plan or design
- **grill-with-docs** — grilling plus CONTEXT.md and ADR building
- **grilling** — the reusable interview primitive
- **handoff** — compact a conversation into a handoff document
- **implement** — build work from a spec or tickets
- **improve-codebase-architecture** — survey a codebase for deepening opportunities
- **research** — investigate against high-trust primary sources
- **teach** — teach me a skill over multiple sessions
- **to-spec** — turn a conversation into a spec
- **to-tickets** — break a plan into tickets
