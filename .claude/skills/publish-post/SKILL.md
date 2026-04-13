---
name: publish-post
description: Publish a Jekyll draft post. Use when the user wants to publish, ship, or go live with a draft article from _drafts/.
allowed-tools: Bash(git *) Bash(gh *) Bash(date *) Bash(mkdir *) Read Edit Write Glob
---

Publish a draft post from `_drafts/` to `_posts/`. Follow these steps exactly:

## 1. Identify the draft

Infer which draft to publish from the conversation context (e.g., the file being edited). If not obvious from context, check `$ARGUMENTS` for a filename. If still ambiguous, list `_drafts/` and ask.

## 2. Create a publish branch

```
git checkout master
git pull
git checkout -b post/<slug>
```

Where `<slug>` is the filename without extension.

## 3. Place the article

- Copy the file from the `drafts` branch: `git show drafts:<path> > <destination>`
- The destination is `_posts/{year}/{date}-{slug}.markdown` (e.g., `_posts/2026/2026-04-13-my-post.markdown`). Create the year directory if needed.
- Add a `date:` field to the frontmatter using the current timestamp (`date +"%Y-%m-%d %H:%M:%S %:z"`). Tell the user what timestamp you used so they can ask to change it before committing.

## 4. Commit, push, and open a PR

- Commit message: `Publish "<post title>"`
- Push with `-u`
- Open a PR against `master` with a one-line summary. No test plan, no AI attribution.
- Any last-minute edits to the article should happen on this branch / PR.

## 5. Remove the draft

Once the article is on the post branch, delete it from `drafts`:

- `git checkout drafts`
- `git rm` the draft file
- Commit with message: `Remove published draft: <filename>`
- Push
