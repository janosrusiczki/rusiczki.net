#!/usr/bin/env bash
# Full microblog rebuild and deploy.
#
# Run this when:
#   - Deploying the Twitter archive for the first time.
#   - CSS, JS, or layout changes should propagate to the Twitter archive pages.
#
# Usage:
#   DEPLOY_USER=user DEPLOY_HOST=host DEPLOY_PATH=/path/to/webroot \
#     _support/scripts/redeploy_microblog.sh
#
# The daily Mastodon sync workflow does NOT use _config_twitter_output.yml,
# so Twitter pages are never rebuilt by CI after this initial deploy.

set -euo pipefail

: "${DEPLOY_USER:?DEPLOY_USER not set}"
: "${DEPLOY_HOST:?DEPLOY_HOST not set}"
: "${DEPLOY_PATH:?DEPLOY_PATH not set}"

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$REPO_ROOT"

echo "==> Building full microblog (including Twitter pages)..."
bundle exec jekyll build \
  --config _config.yml,_config_microblog.yml,_config_twitter_output.yml

echo "==> Deploying _site/microblog/ to ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/microblog/"
rsync -avz --delete \
  _site/microblog/ \
  "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/microblog/"

echo "==> Done."
