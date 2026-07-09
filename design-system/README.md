# 厝味・九份山居 自助報到設計系統

> **一句話：這是開發真正報到介面的視覺基礎。**
> 所有顏色、字體、間距、圓角、陰影、動效都由這裡定義，之後做真正的自助報到頁面時，直接沿用這些變數與元件，不必再從頭調樣式。

---

## 一、這是什麼

**厝味自助報到設計系統** 是「厝味・九份山居 自助報到系統」介面的一套設計語言與可重用樣式。

它把整個產品的視覺決策（用什麼顏色、字多大、圓角多圓、陰影多柔…）收斂成一組**具名的設計變數（design tokens）**，再用這些變數組出一套**元件樣式**。日後不論是純 HTML、還是接 React / Vue / Tailwind，都以同一套視覺基礎為準，確保每一頁長得一致。

**設計風格**：溫暖、編輯感（editorial）的台灣民宿風格。
暖米白底、赭紅重點色、襯線標題＋等寬數字、圓角、柔和暖色陰影、留白充足。
**淺色單一主題，無深色模式。**

---

## 二、包含哪些檔

| 檔案 | 角色 | 說明 |
| --- | --- | --- |
| **`tokens.css`** | 設計變數（唯一真實來源） | 以 CSS 自訂屬性（`--ds-*`）定義所有顏色、字體、字級、間距、圓角、陰影、動效。**改主題只改這個檔。** |
| **`tokens.json`** | 設計變數（機器可讀） | 與 `tokens.css` 同一份資料的 JSON 版，附每個 token 的 `value` 與 `role`。給工具鏈用：接 Tailwind / Style Dictionary、產文件、做設計稿同步。 |
| **`components.css`** | 元件樣式 | 用 `tokens.css` 的變數組出按鈕、卡片、表單、徽章、hero、步驟條、金額、門鎖密碼等所有 UI 元件。**不寫死任何數值，一律引用變數。** |
| **`styleguide.html`** | 樣式指南 / 元件展示 | 可直接用瀏覽器打開的活文件，一頁看完所有色票、字級與元件外觀。做為設計與工程對照、驗收的依據。 |

> 依賴關係：`components.css` 依賴 `tokens.css`（引用其變數）。`tokens.json` 是 `tokens.css` 的資料鏡像，兩者需保持同步。

---

## 三、如何使用

### 1. 純 HTML 直接引入

在 `<head>` 依序 `<link>` 兩個 CSS（**`tokens.css` 一定要在 `components.css` 之前**，因為元件會用到變數）：

```html
<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="./design-system/tokens.css">
  <link rel="stylesheet" href="./design-system/components.css">
</head>
<body>
  <div class="ds-container">
    <button class="ds-btn ds-btn--primary">確認訂單</button>
  </div>
</body>
</html>
```

### 2. 類別命名規則（`.ds-*`、BEM-lite）

所有類別一律 `ds-` 前綴，避免與其他框架撞名。命名採 **BEM-lite**：

```
.ds-block                 區塊（元件本體）      例：.ds-card
.ds-block__element        區塊內的子元素        例：.ds-card__title、.ds-summary__date
.ds-block--modifier       區塊的變體 / 狀態      例：.ds-btn--primary、.ds-badge--success
```

- **Block**：一個獨立元件，如 `.ds-btn`、`.ds-card`、`.ds-hero`、`.ds-field`。
- **Element**（雙底線 `__`）：屬於某 block 的部件，如 `.ds-field__label`、`.ds-doorcode__code`。
- **Modifier**（雙連字號 `--`）：同一 block 的樣式變體或狀態，如 `.ds-btn--ghost`、`.ds-card--sunken`、`.ds-notice--info`。

**用法：base 類別 + modifier 類別並用**（modifier 不單獨使用）：

```html
<!-- 主要 CTA -->
<button class="ds-btn ds-btn--primary ds-btn--block">完成付款</button>

<!-- 成功徽章 -->
<span class="ds-badge ds-badge--success">
  <span class="ds-badge__dot"></span>已付清
</span>

<!-- 內凹摘要卡 -->
<div class="ds-card ds-card--sunken">…</div>
```

現有元件一覽（皆定義於 `components.css`）：
`ds-container`、`ds-stack`、`ds-header`、`ds-hero`、`ds-stepper`、`ds-card`、`ds-field`、`ds-btn`、`ds-badge`、`ds-chip`、`ds-notice`、`ds-option`、`ds-summary`、`ds-infolist`、`ds-price`、`ds-doorcode`、`ds-checklist`、`ds-upload`、`ds-contact`、`ds-lang`、`ds-brandmark`、`ds-divider`。

### 3. 改主題只改 `tokens.css`

要換色、調字級、改陰影，**只動 `tokens.css` 的變數值**，全站元件會一併更新——**永遠不要在元件或頁面裡寫死色碼與尺寸**。

```css
/* tokens.css：把主色赭紅換成別的暖色，全站 CTA / 連結 / 金額同步變色 */
:root {
  --ds-color-primary: #B4603C;   /* 只改這一行 */
}
```

> 改完 `tokens.css` 記得同步更新 `tokens.json`，讓兩份資料一致。

---

## 四、Token 命名規範與分組一覽

**前綴（prefix）：`ds`** — 所有變數一律 `--ds-*`。
**命名結構：`--ds-{類別}-{名稱}[-{屬性}]`**，全小寫、連字號分隔。

### 顏色 Color — `--ds-color-*`

| Token | 值 | 用途 |
| --- | --- | --- |
| `--ds-color-bg` | `#F6F0E4` | 頁面背景（暖米白） |
| `--ds-color-bg-sunken` | `#EFE6D6` | 內凹面板 / 金額摘要底 / 訂單摘要內層 |
| `--ds-color-surface` | `#FDFBF5` | 卡片 / 主要表面（暖白） |
| `--ds-color-surface-raised` | `#FFFFFF` | 浮起表面（少用純白，如瀏覽器框） |
| `--ds-color-ink` | `#33291D` | 主要文字（深褐，非純黑） |
| `--ds-color-ink-secondary` | `#6E6150` | 次要文字 / 說明 |
| `--ds-color-ink-muted` | `#9C8E78` | 淡色文字 / placeholder / footer |
| `--ds-color-primary` | `#B4603C` | 主色赭紅：CTA、重點、金額、連結、訂單編號 |
| `--ds-color-primary-hover` | `#A0512E` | 主色 hover |
| `--ds-color-primary-active` | `#8C4526` | 主色 pressed |
| `--ds-color-primary-soft` | `#F6E9DD` | 主色淡底：被選取的選項底、focus 前景 |
| `--ds-color-on-primary` | `#FFFFFF` | 主色上的文字 |
| `--ds-color-accent-tan` | `#C6B08A` | tan 裝飾：logo 方塊、hero 中間調、房型圖示 |
| `--ds-color-chip-bg` | `#ECE3D1` | 標籤 / chip 底 |
| `--ds-color-chip-ink` | `#6E6150` | 標籤文字 |
| `--ds-color-success` | `#5F7A4E` | 成功綠：報到成功勾勾、已付清、已上傳 |
| `--ds-color-success-bg` | `#E8EFDB` | 成功淺綠底（徽章 / 橫幅） |
| `--ds-color-success-ink` | `#4C6539` | 成功文字 |
| `--ds-color-border` | `#E7DBC5` | 一般邊框 / 分隔線 |
| `--ds-color-border-strong` | `#D8C8A9` | 較明顯邊框 / hover 邊框 |
| `--ds-color-hero-from` | `#C6B08A` | hero 漸層上緣（tan） |
| `--ds-color-hero-to` | `#2A2114` | hero 漸層下緣（深褐） |
| `--ds-focus-ring` | `rgba(180,96,60,.35)` | focus 外環 |

### 字體家族 Font family — `--ds-font-*`

| Token | 值 |
| --- | --- |
| `--ds-font-serif` | `"Noto Serif TC", "Songti TC", "Source Han Serif TC", serif` — 襯線標題 |
| `--ds-font-sans` | `-apple-system, BlinkMacSystemFont, "PingFang TC", "Noto Sans TC", "Microsoft JhengHei", system-ui, sans-serif` — 內文 |
| `--ds-font-mono` | `"SF Mono", "Roboto Mono", ui-monospace, "JetBrains Mono", monospace` — 數字 / 編號 |

### 字級 Type scale — `--ds-text-*`

每一級都附 `-family`、`-lh`（行高）、`-weight` 等屬性變數。

| 級別 | 大小 | 行高 | 字重 | 家族 | 用途 |
| --- | --- | --- | --- | --- | --- |
| `display` | 2rem | 1.25 | 700 | serif | 頁面主標題（確認訂單 / 完成付款） |
| `h1` | 1.75rem | 1.28 | 700 | serif | hero 民宿名 / 大標 |
| `h2` | 1.25rem | 1.4 | 600 | serif | 區塊標題（您好，歡迎自助報到） |
| `h3` | 1.0625rem | 1.5 | 600 | sans | 卡片內小標 / 房型名 |
| `body` | 1rem | 1.6 | 400 | sans | 內文 |
| `body-sm` | 0.875rem | 1.55 | 400 | sans | 次要內文 / 說明 |
| `caption` | 0.75rem | 1.4 | 500 | sans | 標籤 / 欄位 label / footer，字距 `.04em` |
| `price` | 1.75rem | 1.1 | 700 | mono | 金額（NT$ 4,800），`tabular-nums` |
| `code` | 0.9375rem | 1.3 | 600 | mono | 訂單編號 / 卡號 / 日期，`tabular-nums` |
| `code-xl` | 3rem | 1 | 700 | mono | 大門密碼 8842，字距寬 |

### 間距 Space — `--ds-space-*`

4px 為基準的間距刻度，用於 padding / margin / gap。

| Token | 值 | | Token | 值 |
| --- | --- | --- | --- | --- |
| `--ds-space-1` | 4px | | `--ds-space-6` | 24px |
| `--ds-space-2` | 8px | | `--ds-space-8` | 32px |
| `--ds-space-3` | 12px | | `--ds-space-10` | 40px |
| `--ds-space-4` | 16px | | `--ds-space-12` | 48px |
| `--ds-space-5` | 20px | | `--ds-space-16` | 64px |

### 圓角 Radius — `--ds-radius-*`

| Token | 值 | 用途 |
| --- | --- | --- |
| `--ds-radius-sm` | 8px | 小元件 / chip |
| `--ds-radius-md` | 12px | 表單欄位 / 按鈕 |
| `--ds-radius-lg` | 16px | 卡片 |
| `--ds-radius-xl` | 18px | 大卡片 |
| `--ds-radius-2xl` | 24px | hero / 大區塊 |
| `--ds-radius-pill` | 999px | 膠囊（徽章 / 語言切換） |

### 陰影 Shadow — `--ds-shadow-*`

柔和的暖色陰影（褐調），非中性灰。

| Token | 值 | 用途 |
| --- | --- | --- |
| `--ds-shadow-sm` | `0 1px 2px rgba(70,50,25,.06)` | 細微浮起 |
| `--ds-shadow-card` | `0 18px 40px -24px rgba(88,62,33,.45)` | 卡片 |
| `--ds-shadow-raised` | `0 24px 60px -28px rgba(88,62,33,.5)` | 浮起卡片 / 對話框 |
| `--ds-shadow-focus` | `0 0 0 3px var(--ds-focus-ring)` | focus 外環 |

### 動效 Motion — `--ds-ease-*` / `--ds-dur-*`

| Token | 值 | 用途 |
| --- | --- | --- |
| `--ds-ease` | `cubic-bezier(.2,.7,.3,1)` | 統一緩動曲線 |
| `--ds-dur-fast` | `.15s` | 快速（hover / 小回饋） |
| `--ds-dur` | `.2s` | 標準過場 |
| `--ds-dur-slow` | `.35s` | 較慢（展開 / 頁面轉場） |

---

## 五、日後接框架

### A. 對應到 Tailwind theme

把 `tokens.json` 的值搬進 `tailwind.config.js` 的 `theme.extend`（正式專案可用 Style Dictionary 從 `tokens.json` 自動產生，避免手抄）。範例：

```js
// tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        bg:        { DEFAULT: '#F6F0E4', sunken: '#EFE6D6' },
        surface:   { DEFAULT: '#FDFBF5', raised: '#FFFFFF' },
        ink:       { DEFAULT: '#33291D', secondary: '#6E6150', muted: '#9C8E78' },
        primary:   {
          DEFAULT: '#B4603C',
          hover:   '#A0512E',
          active:  '#8C4526',
          soft:    '#F6E9DD',
        },
        'on-primary': '#FFFFFF',
        'accent-tan': '#C6B08A',
        chip:      { bg: '#ECE3D1', ink: '#6E6150' },
        success:   { DEFAULT: '#5F7A4E', bg: '#E8EFDB', ink: '#4C6539' },
        border:    { DEFAULT: '#E7DBC5', strong: '#D8C8A9' },
      },
      fontFamily: {
        serif: ['Noto Serif TC', 'Songti TC', 'Source Han Serif TC', 'serif'],
        sans:  ['-apple-system', 'BlinkMacSystemFont', 'PingFang TC', 'Noto Sans TC', 'Microsoft JhengHei', 'system-ui', 'sans-serif'],
        mono:  ['SF Mono', 'Roboto Mono', 'ui-monospace', 'JetBrains Mono', 'monospace'],
      },
      fontSize: {
        display:  ['2rem',      { lineHeight: '1.25', fontWeight: '700' }],
        h1:       ['1.75rem',   { lineHeight: '1.28', fontWeight: '700' }],
        h2:       ['1.25rem',   { lineHeight: '1.4',  fontWeight: '600' }],
        h3:       ['1.0625rem', { lineHeight: '1.5',  fontWeight: '600' }],
        body:     ['1rem',      { lineHeight: '1.6' }],
        'body-sm':['0.875rem',  { lineHeight: '1.55' }],
        caption:  ['0.75rem',   { lineHeight: '1.4', letterSpacing: '.04em', fontWeight: '500' }],
        price:    ['1.75rem',   { lineHeight: '1.1', fontWeight: '700' }],
        code:     ['0.9375rem', { lineHeight: '1.3', fontWeight: '600' }],
        'code-xl':['3rem',      { lineHeight: '1',   fontWeight: '700' }],
      },
      spacing: {
        1: '4px',  2: '8px',  3: '12px', 4: '16px', 5: '20px',
        6: '24px', 8: '32px', 10: '40px', 12: '48px', 16: '64px',
      },
      borderRadius: {
        sm: '8px', md: '12px', lg: '16px', xl: '18px', '2xl': '24px', pill: '999px',
      },
      boxShadow: {
        sm:     '0 1px 2px rgba(70,50,25,.06)',
        card:   '0 18px 40px -24px rgba(88,62,33,.45)',
        raised: '0 24px 60px -28px rgba(88,62,33,.5)',
      },
      transitionTimingFunction: { ds: 'cubic-bezier(.2,.7,.3,1)' },
      transitionDuration: { fast: '150ms', DEFAULT: '200ms', slow: '350ms' },
    },
  },
};
```

之後就能寫 `class="bg-surface text-ink rounded-lg shadow-card"`，語意與本設計系統一致。

> **更穩健的做法**：讓 Tailwind 的顏色指向 CSS 變數（例如 `primary: 'var(--ds-color-primary)'`），並照常 `<link>` 進 `tokens.css`。這樣「改主題只改 `tokens.css`」的原則在 Tailwind 專案裡依然成立。

### B. 在 React 沿用類別

最省事的作法：把 `tokens.css` + `components.css` 當成全域樣式匯入，元件直接用既有 `.ds-*` 類別。

```jsx
// main.jsx / _app.tsx —— 全域各匯入一次
import './design-system/tokens.css';
import './design-system/components.css';

// 任一元件
export function CtaButton({ children, onClick }) {
  return (
    <button className="ds-btn ds-btn--primary ds-btn--block" onClick={onClick}>
      {children}
    </button>
  );
}
```

需要條件式 modifier 時，用樣板字串或 `clsx` 併類別即可：

```jsx
<span className={`ds-badge ${paid ? 'ds-badge--success' : 'ds-badge--pending'}`}>
  {paid ? '已付清' : '待付款'}
</span>
```

如此可先沿用整套視覺與元件，未來再視需要逐步改寫成框架原生元件，過程中視覺始終一致。
