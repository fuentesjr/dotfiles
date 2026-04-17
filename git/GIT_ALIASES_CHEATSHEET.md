# Git Review Aliases Cheatsheet

This file documents the review-oriented aliases in `.gitconfig`.

Use these before reading code when you want to identify hotspots, ownership, repair patterns, and branch state quickly.

## Quick Start

Start with these in order:

1. `git recent`
2. `git churn`
3. `git churn-dirs`
4. `git authors-recent`
5. `git repairs`
6. `git hotspot path/to/file_or_dir`
7. `git blame-recent path/to/file`

## Repo Activity

### `git recent`

Question answered: what has been happening in this repo lately?

Example output:

```text
2026-04-10 a1b2c3d Jane Doe revert flaky cache invalidation
2026-04-09 9f8e7d6 John Smith add retry jitter to webhook client
```

How to read it:
- Good for seeing cadence, naming style, revert frequency, and whether bots or release commits dominate the history.
- This is the fastest way to get a feel for the repo's current workflow.

### `git monthly`

Question answered: what does commit volume look like by month?

Example output:

```text
142 2026-03
118 2026-02
167 2026-01
```

How to read it:
- Useful for spotting rough activity patterns.
- Do not treat this as a direct team health metric. Commit volume is heavily shaped by workflow.

## Hotspots

### `git churn`

Question answered: which files change the most?

Example output:

```text
128 app/services/billing/reconciler.rb
94 app/models/invoice.rb
87 config/routes.rb
```

How to read it:
- High churn often points to complexity, instability, or active product work.
- Start by checking whether the top files are real logic files or just expected glue like routes, lockfiles, or generated code.

### `git churn-dirs`

Question answered: which directories or subsystems change the most?

Example output:

```text
402 app/services/billing
276 app/models
190 config
```

How to read it:
- Better than file-level churn in large repos.
- Helps you choose which subsystem to inspect first.

### `git hotspot path/to/file_or_dir`

Question answered: what does the history of one hotspot actually look like?

Example output:

```text
commit a1b2c3d4...
Author: Jane Doe

    retry webhook reconciliation after gateway timeout

 app/services/billing/reconciler.rb | 42 ++++++++++------
```

How to read it:
- Use this after `git churn` or `git churn-dirs`.
- Look for repeated repair work, large edits, or a pattern of small patches over time.

## Ownership

### `git authors-recent`

Question answered: who has been active in the last 6 months?

Example output:

```text
87  Jane Doe
42  John Smith
19  Alex Kim
```

How to read it:
- This is a current activity hint, not bus factor.
- Useful for knowing who is likely to have recent context.

### `git owners path/to/file_or_dir`

Question answered: who has touched this specific area the most?

Example output:

```text
38 Jane Doe
14 John Smith
6  Alex Kim
```

How to read it:
- Use this on a hotspot path to find likely owners or maintainers.
- More useful than repo-wide commit counts when you are already looking at one area.

## Repair Signals

### `git bug-files`

Question answered: which files show up often in repair-shaped commits?

Example output:

```text
14 app/models/invoice.rb
11 app/services/billing/reconciler.rb
8  app/controllers/webhooks_controller.rb
```

How to read it:
- This is a commit-message heuristic based on words like `fix`, `bug`, and `broken`.
- Useful as a rough signal only. It depends on how disciplined commit messages are.

### `git firefights`

Question answered: how often does the history look like incident response or rollback work?

Example output:

```text
9f8e7d6 hotfix rollback webhook retry change
7e6d5c4 revert broken invoice sync
```

How to read it:
- Narrower and more operational than `git bug-files`.
- Good for spotting instability, rushed fixes, or rollback-heavy periods.

### `git repairs`

Question answered: where are repair commits landing, and how often does the repo sound like it is in incident mode?

Example output:

```text
== bug-files ==
14 app/models/invoice.rb
11 app/services/billing/reconciler.rb

== firefights ==
9f8e7d6 hotfix rollback webhook retry change
7e6d5c4 revert broken invoice sync
```

How to read it:
- This is a convenience wrapper around `git bug-files` and `git firefights`.
- Use it when you want both views together without deciding which one to run first.

## Branch State

### `git branches`

Question answered: what is the local branch and upstream status?

Example output:

```text
* feature/cache-fix 1234abc [origin/feature/cache-fix: ahead 2] add retry jitter to webhook client
  main              9f8e7d6 [origin/main] fix flaky billing retry
```

How to read it:
- Good for checking ahead/behind state and branch tracking at a glance.
- Useful before rebasing, pushing, or cleaning up local branches.

### `git incoming`

Question answered: what exists on upstream that I do not have locally?

Example output:

```text
9f8e7d6 (origin/main) fix flaky billing retry
8e7d6c5 improve webhook timeout handling
```

How to read it:
- Shows commits reachable from upstream but not from your current `HEAD`.
- Requires the current branch to have an upstream configured.

### `git outgoing`

Question answered: what do I have locally that is not on upstream yet?

Example output:

```text
1234abc (HEAD -> feature/cache-fix) add retry jitter to webhook client
2345bcd add test coverage for webhook retries
```

How to read it:
- Shows commits on your branch that have not been pushed.
- Requires the current branch to have an upstream configured.

## Tags

### `git tags-recent`

Question answered: what are the most recent tags?

Example output:

```text
v2.14.0
v2.13.1
v2.13.0
```

How to read it:
- Useful in repos that release from tags or track milestones that way.
- Pipe to `head` if the repo has many tags.

## Reading Code After the Git Pass

After the first pass, a good sequence is:

1. Run `git churn` and `git churn-dirs`.
2. Pick one suspicious file or directory.
3. Run `git hotspot path/to/file_or_dir`.
4. Run `git owners path/to/file_or_dir`.
5. Run `git blame-recent path/to/file`.
6. Read the code with some historical context instead of starting blind.
