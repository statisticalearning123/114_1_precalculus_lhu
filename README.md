# 龍華科技大學 114-1 基礎數學課程網站

[![Quarto](https://img.shields.io/badge/Made%20with-Quarto-blue.svg)](https://quarto.org)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

龍華科技大學 114 學年度第 1 學期基礎數學課程網站

## 🌐 課程網站

**線上課程網站**：https://statisticalearning123-114-1-precalculus-lhu.share.connect.posit.cloud

本課程網站搭配 **TronClass** 教學平台使用：
- **課程網站**：提供課程進度、教材下載、作業說明
- **TronClass**：作業繳交、測驗作答、成績查詢

## 📚 課程資訊

- **課程名稱**：基礎數學
- **開課學期**：114 學年度第 1 學期
- **學校**：龍華科技大學

## 🌐 網站功能

本網站提供：

- ✅ **課程進度** - 每週上課內容與進度
- ✅ **教材下載** - 課堂筆記 PDF 下載
- ✅ **完整作業說明** - 詳細的作業要求與評分標準
- ✅ **考試資訊** - 期中考、期末考日期與範圍

**作業繳交**：請至 TronClass 教學平台

## 🚀 快速開始

### 本地預覽

```bash
# 預覽網站
make preview

# 建置網站
make build

# 生成課堂筆記 PDF
make rebuild
```

### 部署到 Posit Connect Cloud

```bash
make deploy
```

## 📁 專案結構

```
.
├── _quarto.yml              # Quarto 網站設定
├── index.qmd                # 首頁（課程大綱）
├── contents.qmd             # 課程內容
├── assignments.qmd          # 作業與考試
├── materials/               # 課程資料（公開給學生）
│   ├── lectures/            # 上課版筆記（手稿 PDF）
│   ├── notes/               # 整理版筆記（PDF + Markdown）
│   ├── homework_solutions/  # 作業詳解（PDF + Markdown）
│   └── _source/             # 工作檔案（template.tex, Makefile）
├── Makefile                 # 自動化工具
└── DESIGN_PRINCIPLES.md     # 設計原則文件
```

### 📂 materials/ 資料夾說明

- **lectures/**：上課版筆記（手稿 PDF）
  - 檔名格式：`YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf`
  - 內容：上課時的原始筆記，包含手寫內容
  - 提供給學生下載

- **notes/**：整理版筆記（PDF + Markdown）
  - PDF 檔案：整理過的清晰版筆記（從 Markdown 生成）
  - Markdown 檔案：筆記原始碼（**不提供下載**，僅供生成 PDF 使用）
  - 提供給學生的是 PDF，Markdown 是工作檔案

- **homework_solutions/**：作業詳解（PDF + Markdown）
  - PDF 檔案：作業題目的完整詳解（從 Markdown 生成）
  - Markdown 檔案：詳解原始碼（**不提供下載**，僅供生成 PDF 使用）
  - 檔名格式：`作業一詳解.pdf`、`作業二詳解.pdf`
  - 提供給學生下載 PDF

- **_source/**：工作檔案（不公開）
  - `template.tex`：PDF 生成模板
  - `Makefile`：PDF 自動生成腳本
  - `*.note`：Notability 原檔備份

## 🎨 技術棧

- **網站框架**：[Quarto](https://quarto.org/)
- **PDF 生成**：Pandoc + XeLaTeX
- **樣式**：Bootstrap + 自訂 SCSS
- **字體**：PingFang TC（蘋方-繁）
- **主題色**：龍華藍 (#003366)

## 📝 課程筆記 PDF 系統

### 自動生成 PDF

系統會自動從 Markdown 筆記生成精美的 PDF：

```bash
# 生成所有 PDF
make

# 生成特定日期的 PDF
make pdf DATE=2025-10-02

# 重新生成所有 PDF
make rebuild
```

### 工作流程

1. **撰寫整理版筆記**
   - 在 `materials/notes/` 建立 Markdown 檔案
   - 檔名格式：`YYYY-MM-DD_基礎數學_課程筆記.md`

2. **生成 PDF**
   ```bash
   make rebuild  # 從 Markdown 生成 PDF
   ```

3. **上傳上課版筆記**
   - 將手稿 PDF 直接放入 `materials/lectures/`
   - 檔名格式：`YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf`

4. **更新網站**
   - 編輯 `contents.qmd` 添加下載連結
   - 格式參考第一週範例

### PDF 特色

- **自動日期提取**：從檔名自動提取上課日期
- **統一命名**：所有 PDF 使用一致的課程名稱
- **龍華品牌色**：使用龍華藍主題
- **中文支援**：完整的繁體中文支援
- **數學公式**：支援 LaTeX 數學公式

## 📋 設計原則

本專案遵循以下設計原則：

### 網站與 TronClass 分工

```
網站：
✅ 詳細的課程內容說明
✅ 完整的作業要求
✅ 教材下載

TronClass：
✅ 實際作業繳交
✅ 測驗作答
✅ 成績管理
```

詳細說明請參閱：[DESIGN_PRINCIPLES.md](DESIGN_PRINCIPLES.md)

## 🔧 環境需求

### 網站建置

- [Quarto](https://quarto.org/) (>= 1.4)
- R 或 Python（可選）

### PDF 生成

- [Pandoc](https://pandoc.org/) (>= 2.0)
- [MacTeX](https://www.tug.org/mactex/) 或其他 XeLaTeX 發行版
- macOS 內建字體（PingFang TC）

### 安裝依賴

```bash
# macOS
brew install pandoc
brew install --cask mactex

# 或使用 Make
make install-deps
```

## 📖 使用說明

### 更新課程內容

1. **編輯 `contents.qmd`** - 新增每週詳細內容
   - 使用 `## 第 N 週（YYYY-MM-DD）` 格式
   - 詳細列出該週的上課內容
   - 添加 PDF 下載連結（上課版 + 整理版）

2. **更新 `index.qmd` 課程進度表**
   - 在課程進度表中添加該週資訊
   - **上課內容**欄位：使用連結指向 `contents.qmd` 對應週次
   - **備註**欄位：
     - 只寫**重要事項**（作業、考試相關）
     - 使用**純文字**，不要使用連結
     - 不要寫「課堂筆記」（點上課內容連結即可看到筆記）

   ✅ 正確範例：
   ```markdown
   | 2 | 2025/10/09 | [電影欣賞](contents.qmd#第二週2025-10-09) | 公布「課後作業一」 |
   | 3 | 2025/10/16 | [Ch2 函數（續）](contents.qmd#第三週2025-10-16) | |
   | 4 | 2025/10/23 | [Ch2 函數的圖形](contents.qmd#第四週2025-10-23) | 「課後作業一」繳交截止，公布詳解 |
   ```

   ❌ 錯誤範例：
   ```markdown
   | 3 | 2025/10/16 | [Ch2 函數（續）](contents.qmd#第三週2025-10-16) | 課堂筆記 |
   | 4 | 2025/10/23 | [Ch2 函數的圖形](contents.qmd#第四週2025-10-23) | [課堂筆記](contents.qmd#...)、作業截止 |
   ```

3. 建置網站：`make build`
4. 部署：`make deploy`

### 新增課堂筆記

1. **撰寫 Markdown 筆記**
   - 在 `materials/notes/` 建立檔案
   - 檔名：`YYYY-MM-DD_基礎數學_課程筆記.md`

2. **生成整理版 PDF**
   ```bash
   make rebuild
   ```

3. **上傳上課版 PDF**
   - 將手稿 PDF 放入 `materials/lectures/`
   - 使用相同檔名格式

4. **更新網站連結**
   - 編輯 `contents.qmd`
   - 添加兩個版本的下載連結（參考第一週）

### 更新作業資訊

1. 編輯 `assignments.qmd`
2. 提供完整的作業說明（題型、要求、評分）
3. 明確標示「請至 TronClass 繳交」

## 🎯 Make 指令速查

```bash
# 網站相關
make preview       # 本地預覽
make build         # 建置網站
make deploy        # 部署到 Posit Connect
make clean-site    # 清除網站建置檔案

# PDF 相關
make               # 生成所有 PDF
make rebuild       # 重新生成所有 PDF
make clean         # 清除所有 PDF
make open          # 開啟 PDF 資料夾

# 綜合
make build-all     # 建置 PDF + 網站
make clean-all     # 清除所有生成檔案
make help          # 顯示說明
```

## 📄 授權

MIT License

---

**授課教師**：鄭澈
**最後更新**：2025-10-10
