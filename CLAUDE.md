# CLAUDE.md

## Publishing workflow

When publishing a post (moving from `_drafts/` to `_posts/`), do NOT commit directly to `drafts` or `master`. Instead:

1. Create a new branch off `master` (e.g., `post/slug-name`)
2. Place the article in `_posts/{year}/` (e.g., `_posts/2026/`), not directly in `_posts/`
3. Add a `date` field to the frontmatter — ask the user what timestamp to use (or use the current time if they say so)
4. Push and open a PR against `master`

This keeps the `drafts` branch safe — the user deletes branches by reflex after merging PRs, and restoring `drafts` from remote is a headache.

## Git conventions

- **Single-file article edits**: commit message is exactly `Update <filename>`, no body, no bullets, no co-author trailer. For new posts, structural changes, plugins, layouts, or multi-file changes, write a normal descriptive message.
- **PRs**: no test plan sections in descriptions, no AI-generated signatures or attribution lines (e.g., no "Generated with Claude Code").

## Romanian writing conventions

When writing in Romanian and using English loanwords, Romanian suffixes are hyphenated:

- popup-uri (not popupuri)
- plugin-uri (not pluginuri)
- screenshot-uri (not screenshoturi)
- email-uri (not emailuri)
