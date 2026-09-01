---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets. The spec was written to `.scratch/<feature-slug>/spec.md` by `/to-spec`; the tickets were written to `.scratch/<feature-slug>/issues/` by `/to-tickets`.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit your work to the current branch.
