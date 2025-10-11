# CLAUDE.md

本文件為 Claude Code 提供專案指導，協助 AI 理解專案架構與工作流程。

## 📚 專案概述

**專案名稱**：龍華科技大學 114-1 基礎數學課程網站

**專案目的**：
- 提供完整的課程網站（進度、教材、作業說明）
- 自動化課程筆記 PDF 生成
- 與 TronClass 教學平台整合

**技術棧**：
- **網站框架**：Quarto
- **PDF 生成**：Pandoc + XeLaTeX
- **自動化**：Make
- **版本控制**：Git + GitHub
- **部署**：Posit Connect Cloud

---

## 🎨 設計原則

### 核心原則：網站與 TronClass 分工

```
✅ 課程網站：
   - 完整的課程進度說明
   - 詳細的作業要求與評分標準
   - 教材下載（PDF 筆記）

✅ TronClass：
   - 實際作業繳交
   - 線上測驗作答
   - 成績查詢與管理
```

**重要**：網站必須提供**完整詳細的說明**，但繳交動作在 TronClass。絕不能只寫「請至 TronClass 查看」。

詳見：[DESIGN_PRINCIPLES.md](DESIGN_PRINCIPLES.md)

---

## 📁 專案結構

```
.
├── _quarto.yml              # Quarto 網站設定
├── index.qmd                # 首頁（課程大綱、評分方式、課程進度）
├── contents.qmd             # 課程內容（每週詳細內容）
├── assignments.qmd          # 作業與考試（完整說明）
├── class_note/              # 課堂筆記系統
│   ├── draft/               # Markdown 筆記原稿
│   │   └── 筆記_YYYY-MM-DD_描述.md
│   ├── pdf_output/          # 生成的 PDF
│   │   └── YYYY-MM-DD_基礎數學_課程筆記.pdf
│   ├── template.tex         # LaTeX PDF 模板
│   └── Makefile             # PDF 自動化
├── Makefile                 # 專案主 Makefile
├── DESIGN_PRINCIPLES.md     # 設計原則文件
├── README.md                # 專案說明
└── CLAUDE.md                # 本文件
```

---

## 📝 PDF 筆記系統

### 檔名規則

**Markdown 原稿**（在 `class_note/draft/`）：
```
筆記_YYYY-MM-DD_任意描述.md
```
- 日期格式必須是 `YYYY-MM-DD`（例如 `2025-10-02`）
- 描述部分可以是任意文字（例如 "markdown版"、"初稿" 等）
- 描述**不會**影響 PDF 檔名

**生成的 PDF**（在 `class_note/pdf_output/`）：
```
YYYY-MM-DD_基礎數學_課程筆記.pdf
```
- 日期從原稿檔名自動提取
- 課程名稱固定為「基礎數學」（在 `class_note/Makefile` 的 `COURSE_NAME` 變數設定）

**範例**：
```
輸入：class_note/draft/筆記_2025-10-02_markdown版.md
輸出：class_note/pdf_output/2025-10-02_基礎數學_課程筆記.pdf
```

### Makefile 邏輯

**課程名稱變數**（`class_note/Makefile:8`）：
```makefile
COURSE_NAME = 基礎數學
```

**檔名轉換邏輯**：
1. 使用 `sed` 從檔名提取日期：`筆記_([0-9]{4}-[0-9]{2}-[0-9]{2})_.*`
2. 組合輸出檔名：`${日期}_${COURSE_NAME}_課程筆記.pdf`
3. 忽略原檔名中的描述部分

### 常用命令

```bash
# 在專案根目錄執行（會自動轉發到 class_note/）
make                    # 生成所有 PDF
make rebuild            # 清除並重新生成所有 PDF
make pdf DATE=2025-10-02  # 生成特定日期的 PDF
make clean              # 清除所有 PDF
make open               # 開啟 PDF 資料夾

# Quarto 網站相關
make preview            # 本地預覽網站
make build              # 建置網站
make deploy             # 部署到 Posit Connect Cloud
```

---

## 🌐 Quarto 網站

### 網站配置 (_quarto.yml)

**品牌色**：龍華藍 `#003366`
- 導航列背景
- 表格標題背景
- 連結顏色

**網站結構**：
```yaml
navbar:
  - 課程大綱 (index.qmd)
  - 課程內容 (contents.qmd)
  - 作業與考試 (assignments.qmd)
```

### 頁面內容指引

#### index.qmd（課程大綱）
包含：
- 網站說明（網站 URL + TronClass 分工）
- 評分方式（出席 20%、期中考 20%、期末考 20%、作業 40%）
- 課程章節（Ch2、Ch3）
- 課程進度（16 週完整表格）

#### contents.qmd（課程內容）
包含：
- 每週詳細上課內容
- **PDF 下載連結**（使用 `####` 標題「📥 課堂筆記下載」）
- 課程活動說明（例如電影欣賞）

**PDF 下載連結格式**：
```markdown
#### 📥 課堂筆記下載

**PDF 下載**：[2025-10-02_基礎數學_課程筆記.pdf](class_note/pdf_output/2025-10-02_基礎數學_課程筆記.pdf)
```

#### assignments.qmd（作業與考試）
包含：
- 完整的作業說明（題型、字數、評分標準）
- 明確標示「📝 請至 TronClass 繳交/作答」
- 考試資訊（日期、範圍、配分）

---

## 🔧 開發工作流程

### 新增一週的課程內容

1. **撰寫課堂筆記 Markdown**
   ```bash
   # 在 class_note/draft/ 建立新檔案
   # 檔名：筆記_2025-10-16_描述.md
   ```

2. **生成 PDF**
   ```bash
   cd class_note
   make rebuild
   # 或使用：make pdf DATE=2025-10-16
   ```

3. **更新 contents.qmd**
   ```markdown
   ### 第三週（2025-10-16）

   **主題：課程主題**

   - 重點 1
   - 重點 2

   ---

   #### 📥 課堂筆記下載

   **PDF 下載**：[2025-10-16_基礎數學_課程筆記.pdf](class_note/pdf_output/2025-10-16_基礎數學_課程筆記.pdf)
   ```

4. **更新 index.qmd 課程進度表**
   ```markdown
   | 3 | 2025/10/16 | 課程主題 | [課堂筆記](contents.qmd#第三週2025-10-16) |
   ```

5. **預覽網站**
   ```bash
   make preview
   # 瀏覽器開啟 http://localhost:4200
   ```

6. **建置並部署**
   ```bash
   make build
   make deploy
   ```

### 新增作業

1. **編輯 assignments.qmd**
   ```markdown
   ### 作業二

   - **測驗形式**：線上測驗（個人測驗）
   - **題目類型**：...
   - **開放時間**：2025/10/23 21:00
   - **截止時間**：2025/11/06 19:14
   - **配分**：8%
   - **作答方式**：📝 **請至 TronClass 線上測驗作答**
   ```

2. **更新 index.qmd 進度表**
   ```markdown
   | 4 | 2025/10/23 | 課程主題 | 公布「課後作業二（截止時間 2025/11/06 19:14）」 |
   ```

---

## ⚠️ 重要注意事項

### 術語一致性

- ✅ 使用「**截止時間**」（包含日期和時間）
- ❌ 不使用「截止日期」
- ✅ 課程名稱：「**基礎數學**」（無羅馬數字 I）

### 顏色規範

- **主色**：龍華藍 `#003366`
- **強調色**：`#0066CC`
- ❌ 不使用紅色（曾誤用 `#CC0033`）

### PDF 檔名

- ✅ 課程名稱固定為「基礎數學」
- ✅ 從檔名自動提取日期
- ✅ 格式：`YYYY-MM-DD_基礎數學_課程筆記.pdf`
- ❌ 不從檔名提取課程主題（如 "markdown版"）

### 設計原則

- ✅ 網站提供**完整詳細的說明**
- ✅ 明確標示「📝 請至 TronClass 繳交」
- ❌ 絕不只寫「請至 TronClass 查看」

---

## 🚀 快速參考

### Git 工作流程

```bash
git add .
git commit -m "更新課程內容"
git push origin main
```

### Quarto 命令

```bash
quarto preview              # 預覽（http://localhost:4200）
quarto render               # 建置網站到 _site/
```

### Makefile 命令總覽

```bash
# PDF 相關（自動轉發到 class_note/）
make                        # 生成所有 PDF
make rebuild                # 重新生成所有 PDF
make clean                  # 清除 PDF
make open                   # 開啟 PDF 資料夾

# 網站相關
make preview                # 預覽網站
make build                  # 建置網站
make deploy                 # 部署網站

# 綜合
make build-all              # 建置 PDF + 網站
make clean-all              # 清除所有生成檔案
```

---

## 📖 相關文件

- [README.md](README.md) - 專案完整說明
- [DESIGN_PRINCIPLES.md](DESIGN_PRINCIPLES.md) - 設計原則
- [class_note/Makefile](class_note/Makefile) - PDF 生成邏輯
- [_quarto.yml](_quarto.yml) - 網站配置

---

**最後更新**：2025-10-11
**維護者**：鄭澈
