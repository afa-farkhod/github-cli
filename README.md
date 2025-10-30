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

## 📝 Summary:

- When to use this approach?
  - You already know the tag and want to verify details (draft/prerelease status, publish time).
  - CI notifications: confirm a tag is published before posting to Slack/Discord.
  - Release audits: compare `created_at` vs `published_at` to understand why UI ordering looks “off” (draft created earlier, published later).
  - Idempotent checks: use it in cron or workflows; it’s a constant-time single API call.

- Why `created_at` vs `published_at` matters?
  - check relevant issue at [Stackoverflow](https://stackoverflow.com/questions/59319281/github-action-different-between-release-created-and-published)
  - `created_at`: when the release record (often a draft) was created.
  - `published_at`: when the release was made public.
  - 💡 GitHub’s UI ordering and `X hours ago` are based on `published_at`, not `created_at`. This explains cases where a testnet release appears newer despite an older `created_at`.
