# 我的工作台部署包（PWA + 云同步 + 自动更新）

这个版本可以部署成手机和电脑都能“添加到桌面”的工作台应用。只要以后继续部署到同一个线上链接，已经添加到桌面的工作台会自动检查新版本并更新；数据通过 Supabase 云同步。

## 文件说明

- `index.html`：工作台主页面，部署入口。
- `manifest.webmanifest`：让浏览器识别为可安装应用。
- `sw.js`：离线缓存与自动更新脚本。
- `icons/`：桌面与手机图标。
- `supabase-schema.sql`：Supabase 建表脚本。

## 你真正需要的使用方式

1. 部署 `deploy` 文件夹到 Netlify / Vercel / Cloudflare Pages 等平台。
2. 得到一个固定公网链接，例如 `https://your-workbench.netlify.app`。
3. 手机和电脑都打开这个链接。
4. 浏览器菜单中选择“添加到主屏幕 / 安装应用 / 创建快捷方式”。
5. 打开桌面上的“我的工作台”，点击右下角云同步，输入同一个个人访问码。
6. 以后你让我修改工作台后，只要把新版重新部署到同一个链接，桌面入口会自动更新；数据继续云同步。

## Supabase 云同步配置

1. 打开 https://supabase.com 并创建项目。
2. 进入 SQL Editor，运行 `supabase-schema.sql`。
3. 进入 Project Settings > API，复制 Project URL 和 anon public key。
4. 打开 `index.html`，搜索并替换：

```js
var SUPABASE_URL = '请填入你的_SUPABASE_PROJECT_URL';
var SUPABASE_ANON_KEY = '请填入你的_SUPABASE_ANON_PUBLIC_KEY';
```

## 重要规则

- 想让已添加到桌面的工作台持续更新，必须始终部署到同一个网址。不要每次换新链接。
- 如果用了 Netlify Drop，每次拖拽可能会生成新链接；更推荐登录 Netlify 后创建一个固定站点，以后覆盖部署同一个站点。
- 安装到桌面后，工作台会每隔一段时间检查更新；发现新版会自动刷新到最新代码。
- 数据同步依赖 Supabase 和个人访问码；代码更新依赖同一个部署链接和 `sw.js`。这两件事缺一不可。

## 手机添加到桌面

- iPhone Safari：打开链接 > 分享按钮 > 添加到主屏幕。
- Android Chrome / Edge：打开链接 > 菜单 > 安装应用或添加到主屏幕。

## 电脑添加到桌面

- Chrome / Edge：打开链接后，地址栏右侧通常会出现安装图标；也可以菜单 > 应用 > 将此站点作为应用安装。

## 注意

个人访问码不会明文写入数据库，会转换为哈希 workspace_id。当前方案适合个人使用，不建议保存身份证号、银行卡号等高敏感信息。
