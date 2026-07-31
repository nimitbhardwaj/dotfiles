## Commit policy

**Don't commit on your own.** Stage with `git add`, ask before `git commit` or `git push` — even for typo fixes. No exceptions.

Local-only dev tweaks: prefer CLI flags over config edits (e.g. `bun run dev --host 0.0.0.0`, `PORT=4000 bun run dev`).

## Branch and push policy

**Never push to `master` (or whatever the default branch is — check with `git symbolic-ref refs/remotes/origin/HEAD`).** Always: feature branch → push → open/update PR for the user to review and merge.

## Real-account testing (Pairly)

- Phone: `8894169073`
- OTP: `999999` (dev backdoor — never commit)
- Tokens expire every ~5 min; re-login if `agent-browser` reports an expired session. Don't leave `agent-browser` open across turns.
