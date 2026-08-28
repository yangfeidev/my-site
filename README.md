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

## 修改内容

当前文案是**示例内容**，替换成你自己的信息即可：

- 在 `index.html` 里改：姓名、简介、技术栈标签、近况卡片、邮箱、社交链接（`GitHub / X / Email / Blog` 这些 `href`）。
- 页脚年份会自动更新，无需手动改。
- 配色：改 `styles.css` 顶部的 `:root` 变量（如 `--primary`、`--bg`）。

## 部署到 Cloudflare Pages

如果你使用 Dashboard：

1. 在 Cloudflare 中进入 `Workers & Pages`。
2. 新建一个 `Pages` 项目。
3. 选择 `Direct Upload`。
4. 上传当前目录中的文件。
5. 部署成功后，把自定义域名绑定到 `bsdnme.me`。

如果你使用 Wrangler：

```bash
npx wrangler pages deploy . --project-name bsdnme-home
```

部署成功后，再到 `Pages` 项目里添加自定义域名 `bsdnme.me`。

> 仓库内已配置 GitHub Actions 自动部署（`.github/workflows/deploy-pages.yml`），推送到 `main` 分支即可。
