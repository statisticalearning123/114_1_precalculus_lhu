# 基礎數學課程網站

龍華科技大學 114-1 基礎數學課程網站

## 📌 設計原則

**重要**：本網站提供完整的作業說明與課程資訊，但實際作業繳交請至 TronClass。

```
網站功能：
✅ 課程進度說明
✅ 教材下載 (PDF)
✅ 完整作業說明（題型、要求、評分標準）
✅ 演算法式教學介紹

TronClass 功能：
✅ 作業繳交
✅ 測驗作答
✅ 成績查詢
```

詳細設計原則請參閱：[DESIGN_PRINCIPLES.md](DESIGN_PRINCIPLES.md)

---

## 🚀 快速開始

### 本地預覽

```bash
# 渲染網站
quarto preview

# 或使用 make
make preview
```

### 建置網站

```bash
# 建置靜態網站
quarto render

# 或使用 make
make build
```

## 📁 檔案結構

```
.
├── _quarto.yml          # Quarto 網站設定
├── index.qmd            # 首頁（課程大綱）
├── contents.qmd         # 課程內容
├── assignments.qmd      # 作業與考試
├── materials.qmd        # 教材下載
├── teaching-method.qmd  # 演算法式教學
├── styles.css           # 自訂樣式
├── custom.scss          # SCSS 主題
├── class_note/          # 課堂筆記資料夾
│   ├── pdf_output/      # PDF 筆記
│   └── ...
└── _site/               # 建置後的網站（自動生成）
```

## 🎨 網站特色

1. **龍華科技大學品牌色**：使用龍華紅 (#CC0033)
2. **響應式設計**：支援各種裝置瀏覽
3. **清晰導覽**：側邊欄 + 頂部導覽列
4. **PDF 下載**：直接連結課堂筆記 PDF
5. **演算法式教學介紹**：專門介紹框框法等教學法

## 📝 內容更新

### 新增課堂筆記

1. 在 `class_note/draft/` 中建立新的 markdown 筆記
2. 使用 `make rebuild` 生成 PDF
3. 在 `contents.qmd` 中新增該週的課程內容和 PDF 連結

### 更新作業資訊

編輯 `assignments.qmd`，填入作業詳情。

### 更新課程進度

編輯 `contents.qmd`，新增每週的上課內容。

## 🌐 部署到 Posit Connect Cloud

### 方法一：透過 Quarto CLI

```bash
# 首次部署
quarto publish connect

# 更新部署
quarto publish connect --update
```

### 方法二：透過 RStudio

1. 在 RStudio 中開啟專案
2. 點擊 Publish 按鈕
3. 選擇 Posit Connect Cloud
4. 按照指示完成部署

### 方法三：使用 Make

```bash
# 部署到 Posit Connect
make deploy
```

## 🔧 Make 指令

```bash
make preview    # 本地預覽
make build      # 建置網站
make deploy     # 部署到 Posit Connect
make clean      # 清除建置檔案
make help       # 顯示說明
```

## 📚 技術棧

- **Quarto**：靜態網站生成器
- **Bootstrap**：響應式框架
- **SCSS/CSS**：自訂樣式
- **Pandoc**：文件轉換

## 📞 聯絡資訊

授課教師：鄭澈

---

*最後更新：2025-10-10*
