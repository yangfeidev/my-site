#!/usr/bin/env bash
#
# 本地一键部署到 Cloudflare Pages（备用方案，首选 GitHub Actions 自动部署）
#
# 说明：
#   token 没有地区/IP 限制，可直接使用；默认走本机代理只是让连接更顺畅，
#   不设代理也能部署。你平时用 push 自动部署即可，本脚本仅在需要手动尽快
#   发布时使用。
#
# 安全说明：
#   只把公开站点文件（index.html, styles.css, script.js, assets/）复制到临时目录
#   再上传，绝不把 .env.deploy / deploy.sh 等含机密的文件带上线。
#
# 用法：
#   1) 确保本机代理在 127.0.0.1:7890（可在 .env.deploy 里改 DEPLOY_PROXY）
#   2) ./deploy.sh            # 从 .env.deploy 读取凭证
#   或  CLOUDFLARE_API_TOKEN=xxx ./deploy.sh   # 临时指定
#
set -euo pipefail

cd "$(dirname "$0")"

PROJECT="my-site"
BRANCH="main"
WRANGLER="npx -y wrangler@3.90.0"
STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT

# 从 .env.deploy 加载凭证（如果存在）
if [[ -f .env.deploy ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env.deploy
  set +a
fi

: "${CLOUDFLARE_API_TOKEN:?请设置 CLOUDFLARE_API_TOKEN（可写入 .env.deploy）}"
: "${CLOUDFLARE_ACCOUNT_ID:?请设置 CLOUDFLARE_ACCOUNT_ID}"
DEPLOY_PROXY="${DEPLOY_PROXY:-http://127.0.0.1:7890}"

# 走代理访问 Cloudflare
export HTTPS_PROXY="${DEPLOY_PROXY}"
export HTTP_PROXY="${DEPLOY_PROXY}"
export ALL_PROXY="${DEPLOY_PROXY}"
export CLOUDFLARE_API_TOKEN
export CLOUDFLARE_ACCOUNT_ID

# 只复制公开站点文件到暂存目录
cp index.html styles.css script.js "${STAGING}/"
if [[ -d assets && -n "$(ls -A assets 2>/dev/null)" ]]; then
  cp -R assets "${STAGING}/"
fi

echo "→ 通过代理 ${DEPLOY_PROXY} 部署到 Pages 项目 ${PROJECT} （分支 ${BRANCH}）..."
${WRANGLER} pages deploy "${STAGING}" --project-name="${PROJECT}" --branch="${BRANCH}"

echo ""
echo "✅ 部署完成。检查线上: https://${PROJECT}-bpb.pages.dev"
