---
name: implement
description: "Implement a piece of work from its spec."
disable-model-invocation: true
---

The third stage of a fixed chain: `grilling → to-spec → implement → code-review`. Run it after a spec exists and you want the work built.

Implement the work described by the spec. The spec was written to `.scratch/<feature-slug>/spec.md` by `to-spec`; read it from there (or use the path the user passes).

Use /tdd where possible, at pre-agreed seams — the seams were agreed during `to-spec`.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit your work to the current branch.
