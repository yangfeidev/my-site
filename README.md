# bsdnme.me

这是一个可直接部署到 `Cloudflare Pages` 的最简个人首页。

## 本地预览

在当前目录执行：

```bash
python3 -m http.server 4173
```

然后打开 [http://localhost:4173](http://localhost:4173)。

## 部署到 Cloudflare Pages

如果你使用 Dashboard：

1. 在 Cloudflare 中进入 `Workers & Pages`。
2. 新建一个 `Pages` 项目。
3. 选择 `Direct Upload`。
4. 上传当前目录中的文件，或者上传一个包含 `index.html` 和 `styles.css` 的目录。
5. 部署成功后，把自定义域名绑定到 `bsdnme.me`。

如果你使用 Wrangler：

```bash
npx wrangler pages deploy . --project-name bsdnme-home
```

部署成功后，再到 `Pages` 项目里添加自定义域名 `bsdnme.me`。
