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

## Example output:

```
set -euo pipefail
REPO=MystenLabs/walrus # => example repo
TAG=mainnet-v1.35.2    # => example tag

if ! out="$(gh api "repos/${REPO}/releases/tags/${TAG}" 2>/dev/null)"; then
  echo "Release tag not found: ${REPO}@${TAG}" >&2
  exit 1
fi
jq '{tag: .tag_name, draft, prerelease, created_at, published_at, html_url}' <<<"$out"
```

<img width="657" height="145" alt="image" src="https://github.com/user-attachments/assets/520f730a-a4fb-44ea-bf3d-27e3460ca5ce" />
