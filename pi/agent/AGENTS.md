<!-- BEGIN COMPOUND PI TOOL MAP -->
## Compound Engineering (Pi compatibility)

This block is managed by compound-plugin.

Pi extensions used by this plugin:
- Required: `pi-subagents` (by nicobailon) provides the `subagent` tool used by skills that dispatch parallel agents
- Recommended: `pi-ask-user` (by edlsh) provides the `ask_user` tool; skills fall back to numbered options in chat when it is missing

Install with:
  pi install npm:pi-subagents
  pi install npm:pi-ask-user
<!-- END COMPOUND PI TOOL MAP -->

## Commit policy

**Don't commit on your own. Ever.** Stage changes (`git add`) if useful, but stop there and ask before running `git commit` or `git push`. The user owns the commit message, the branch choice, and the timing — pushing unannounced work to a shared branch breaks their review flow.

This applies even for commits that look "obviously safe" — typo fixes, doc tweaks, chore commits. Those are still decisions the user wants to make.

For dev-server / tooling changes (e.g. binding vite to `0.0.0.0`, port changes, env tweaks) that are local-only experiments, prefer one-off flags over config edits:

  bun run dev --host 0.0.0.0   # vite CLI flag overrides config, no file touched
  PORT=4000 bun run dev        # ad-hoc env override

Only modify config files if the user explicitly says the change should stick.

## Branch and push policy

**Don't push directly to `master` (or any default/primary branch).** Always:
  1. Create a feature branch (`git checkout -b feat/<name>` or `fix/<name>`).
  2. Push the branch (`git push origin <branch>`).
  3. Open or update a PR for the user to review and merge.

Even when the user explicitly says "commit and push," do NOT push to `master` without a separate confirmation. The user owns branch choice and PR review flow. If a branch was already created for the work (e.g. `feat/match-notification`), push to that branch — never to `master` directly.

If the user's repo has a different default branch (`main`, `develop`, etc.), apply the same rule — never push to whatever the default branch is. `git symbolic-ref refs/remotes/origin/HEAD` reveals the default if unsure.
