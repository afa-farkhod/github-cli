set -euo pipefail
REPO= "" # ex: MystenLabs/walrus
TAG= ""  # ex: mainnet-v1.35.2

if ! out="$(gh api "repos/${REPO}/releases/tags/${TAG}" 2>/dev/null)"; then
  echo "Release tag not found: ${REPO}@${TAG}" >&2
  exit 1
fi
jq '{tag: .tag_name, draft, prerelease, created_at, published_at, html_url}' <<<"$out"
