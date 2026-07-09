# 厝味・九份山居 — 自助報到系統 UI

民宿自助報到系統的 UI 設計稿預覽。旅客從連結進入即可自助完成報到：確認訂單 → 上傳證件 → 同意住宿須知 → 線上付款 → 取得門禁密碼。

目前這個專案是一個**純靜態網站**，把手機版（9 頁）與電腦版（12 頁）的設計稿排成一個可預覽的畫廊，先給業者看。之後要開發真正的介面時，直接在這個專案往下長即可。

## 專案結構

```
.
├── index.html          # 展示頁（畫廊 + 點圖放大）
├── assets/
│   ├── mobile/         # 手機版 m01–m09.png
│   └── pc/             # 電腦版 p01–p12.png
├── README.md
└── .gitignore
```

> 根目錄那些中文檔名的原始圖（`1.進入頁…​.png`、`前台/pc/…`）是設計來源，保留備查；
> 網站實際用的是 `assets/` 裡改成英數檔名的複本。

## 本地預覽

任選一種，開瀏覽器看 `http://localhost:8080`：

```bash
python3 -m http.server 8080
# 或
npx serve .
```

## 部署到 Zeabur

這是純靜態站，Zeabur 會自動判定為 **Static** 服務（偵測到根目錄的 `index.html`），不需要任何建置設定。

**方式 A — 從 GitHub 部署（推薦，之後 push 就自動更新）**
1. 把這個資料夾推到一個 GitHub repo。
2. Zeabur Dashboard → **Create Project** → **Deploy from GitHub** → 選這個 repo。
3. Zeabur 自動辨識為靜態站並部署，完成後在 **Domains** 綁一個 `*.zeabur.app` 網址即可分享給業者。

**方式 B — 用 Zeabur CLI（不需先開 GitHub）**
```bash
npm i -g @zeabur/cli   # 或 npx @zeabur/cli
zeabur                 # 依指示登入、選 / 建立 project 後部署
```

> 若 Zeabur 沒自動判成靜態站：進該 service 的設定，把類型改成 **Static**、Output Directory 留空（根目錄），重新部署即可。

## 後續開發

要把「預覽畫廊」變成真正的報到流程時，建議路線：
- 先把每一頁設計稿刻成真的頁面（Next.js / Vite + React 皆可），沿用現有暖色調設計 token。
- 串接訂單查詢、證件上傳、金流（設計稿用的是紅陽金流 / Line Pay / TWQR）、門禁密碼發送。
- `index.html` 這個畫廊頁可保留為 `/preview`，方便持續給業者看進度。
