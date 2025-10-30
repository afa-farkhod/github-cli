# github-cli
GitHub CLI — query a release by tag

- Use this tiny script, reliable snippet when you want to fetch the facts for a specific release tag—exactly what GitHub shows on the release page—without scraping HTML or looping through every release.

## What this does

- Queries the GitHub REST API for `REPO`’s release with exact tag `TAG`.
- Prints a clean JSON with only the important fields:
  - `tag` — the tag name you asked for
  - `draft / prerelease` — release state flags
  - `created_at` — when the release record was created (often when the draft was opened)
  - `published_at` — when it became public; GitHub UI “X hours ago” is based on this
  - `html_url` — direct link to the release page

