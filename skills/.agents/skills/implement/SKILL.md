---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the spec and its tickets. The spec was written to `.scratch/<feature-slug>/spec.md` by `/to-spec`, and `/to-tickets` split the work into per-ticket files under `.scratch/<feature-slug>/issues/`; read both from there. Work the frontier: pick any ticket whose blockers are all done.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit your work to the current branch.
