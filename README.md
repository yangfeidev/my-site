# bsdnme.me

一个可直接部署到 `Cloudflare Pages` 的简洁个人首页。暗色主题、完全响应式、纯静态、无框架，轻量且快。

## 本地预览

在当前目录执行：

```bash
python3 -m http.server 4173
```

然后打开 [http://localhost:4173](http://localhost:4173)。

## 页面结构

- **Hero**：大标题、一句话简介、状态徽章、CTA 与个人资料卡
- **About**：自我简介 + 快捷信息（专注 / 年限 / 工作方式）
- **Stack**：按「应用 / 平台 / 工具」分组的技术标签
- **Now**：最近在做的事（博客 / 开源 / 接项目）
- **Contact**：邮箱 CTA + 社交链接

文件说明：

| 文件 | 作用 |
| --- | --- |
| `index.html` | 页面结构与内容 |
| `styles.css` | 全部样式（含响应式与 `prefers-reduced-motion`） |
| `script.js` | 渐进增强：移动端导航、滚动头部、区块显现、页脚年份 |
| `deploy.sh` | 本地一键部署（走本机代理） |
| `.env.deploy` | 本地部署凭证（**git 忽略，勿提交**） |

## 修改内容

当前文案是**示例内容**，替换成你自己的信息即可：

- 在 `index.html` 里改：姓名、简介、技术栈标签、近况卡片、邮箱、社交链接（`GitHub / X / Email / Blog` 这些 `href`）。
- 页脚年份会自动更新，无需手动改。
- 配色：改 `styles.css` 顶部的 `:root` 变量（如 `--primary`、`--bg`）。

## 发布到 Cloudflare Pages

### 首选：push 自动部署（GitHub Actions）

仓库里已有 `.github/workflows/deploy-pages.yml`。**push 到 `main` 分支会自动触发部署**，只需把 Cloudflare 凭证存在 GitHub Secrets 里即可：

- `CLOUDFLARE_API_TOKEN`：一个**不带 IP/地区限制**的 token（Account → Cloudflare Pages → Edit）。
- `CLOUDFLARE_ACCOUNT_ID`：你的 Cloudflare 账号 ID。

工作流只会部署公开站点文件（`index.html` / `styles.css` / `script.js` / `assets/`），不会把 `.env.deploy`、`deploy.sh`、`.github/` 等带上线。

### 备选：本机一键部署

```bash
./deploy.sh
```

脚本从 `.env.deploy` 读取凭证，**只上传公开站点文件**，绝不把含机密的文件带上线。默认走本机代理 `http://127.0.0.1:7890`（可在 `.env.deploy` 改 `DEPLOY_PROXY`；token 无地区限制时其实可省略代理）。

## 配置说明

- **代理**：确保本机代理在运行（脚本默认连 `127.0.0.1:7890`）。这是 token 能认证的前提。
- **凭证**：`.env.deploy` 已通过 `.gitignore` 排除，不会被 git 提交。

## 安全提醒

`.env.deploy` 里是敏感 token，请勿提交、勿外传。若曾泄露（例如被公网访问到），建议**立即在 Cloudflare 后台吊销并重新生成**。
