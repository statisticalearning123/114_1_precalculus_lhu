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
- **部署**：GitHub Pages（推送到 GitHub 後自動部署）

---

## 🎨 設計原則

### ⚠️ 最高優先級規則

**🚫 絕對不使用簡體字**

- ✅ 所有內容**必須使用繁體中文**（正體中文）
- ❌ **嚴格禁止**使用簡體字（如：该、页、内容 等）
- ✅ 正確用字範例：
  - ✅ 「該頁面內容」（繁體）
  - ❌ 「该页面内容」（簡體）
  - ✅ 「課程」（繁體）
  - ❌ 「课程」（簡體）
- 📌 這是**台灣**的大學課程網站，必須使用台灣的正體中文

---

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
├── materials/               # 課程資料（公開給學生）
│   └── lecture_notes/       # 課程筆記系統
│       ├── lecture_note/    # 上課版筆記（手寫 PDF）
│       │   └── YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf
│       ├── lecture_note_organized/  # 整理版筆記
│       │   ├── YYYY-MM-DD_基礎數學_課程筆記_整理版.md
│       │   └── YYYY-MM-DD_基礎數學_課程筆記_整理版.pdf
│       ├── template.tex     # LaTeX PDF 模板
│       ├── Makefile         # PDF 自動化工具
│       └── CLAUDE_如何生成整理版筆記.md  # 詳細流程說明
├── Makefile                 # 專案主 Makefile
├── DESIGN_PRINCIPLES.md     # 設計原則文件
├── README.md                # 專案說明
└── CLAUDE.md                # 本文件
```

### 📂 materials/lecture_notes/ 資料夾設計

**按版本分類的資料夾結構**：

- **lecture_note/**：上課版筆記（手寫原稿）
  - 上課時的原始手寫筆記 PDF（從 Notability 等工具匯出）
  - 提供給學生下載
  - 檔名：`YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf`

- **lecture_note_organized/**：整理版筆記
  - **Markdown 原稿**：整理後的筆記原始碼（**不提供給學生下載**）
  - **PDF**：從 Markdown 生成的清晰版筆記（提供給學生下載）
  - 檔名：`YYYY-MM-DD_基礎數學_課程筆記_整理版.{md|pdf}`

- **工作檔案**：
  - `template.tex`：PDF 生成模板
  - `Makefile`：自動化腳本
  - `CLAUDE_如何生成整理版筆記.md`：完整流程說明（含 Mermaid 圖）

---

## 📝 課程筆記系統

### 檔名規則

**上課版筆記**（手寫原稿）：
```
materials/lecture_notes/lecture_note/YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf
```

**整理版筆記**：
```
materials/lecture_notes/lecture_note_organized/YYYY-MM-DD_基礎數學_課程筆記_整理版.md
materials/lecture_notes/lecture_note_organized/YYYY-MM-DD_基礎數學_課程筆記_整理版.pdf
```

**重要說明**：
- Markdown 檔案**不提供給學生下載**
- 學生可以下載兩種 PDF：上課版（手寫原稿）和整理版（清晰版）
- 課程名稱固定為「基礎數學」
- 整理版檔名必須包含「**_整理版**」後綴

---

## 🤖 使用 Claude Code 生成整理版筆記（重要！）

### 核心流程

當需要為新的上課筆記建立整理版時，**請 Claude Code 使用 Read 工具辨識手寫筆記 PDF**。

**為什麼？**
- Claude Code 的 Read 工具可以直接讀取 PDF 檔案（包括圖片 PDF）
- Claude 是多模態 LLM，具備視覺辨識能力，可以「看懂」手寫文字
- **不需要額外的 OCR 工具**，Claude 會直接辨識並整理內容

### 標準工作流程

**步驟 1：上傳手寫筆記**
```bash
# 將手寫筆記 PDF 放入
materials/lecture_notes/lecture_note/YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf
```

**步驟 2：請 Claude Code 辨識並生成整理版**

使用以下提示詞：

```
請幫我處理 YYYY-MM-DD 的課程筆記：

1. 讀取手寫筆記 PDF：
   materials/lecture_notes/lecture_note/YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf

2. 辨識其中的手寫內容，並整理成清晰的 Markdown 格式

3. 儲存為：
   materials/lecture_notes/lecture_note_organized/YYYY-MM-DD_基礎數學_課程筆記_整理版.md

請確保：
- 保留所有數學公式（使用 LaTeX 語法 $...$）
- 保持清楚的標題層級（#, ##, ###）
- 整理例題與說明
- 使用清晰的項目符號和編號
```

### ⚠️ 整理版筆記撰寫原則（重要！）

**核心原則：忠實呈現原稿內容**

整理版筆記的目的是將手寫內容轉換為清晰的數位格式，**不是重新撰寫或改寫**。

**✅ 應該做的事**：

1. **保留原本的用語**：使用老師在筆記中使用的詞彙和說法
2. **保留原本的結構**：按照手寫筆記的順序和分段整理
3. **保留原本的例題**：完整呈現筆記中的例題，不要自行增減
4. **保留原本的標註**：如「c.f.」、「想」、「注意」等老師的標記
5. **數學公式忠實轉換**：將手寫公式轉為 LaTeX，不改變內容

**❌ 不應該做的事**：

1. **不要額外添加標題**：如「本週主題」、「學習目標」、「重點整理」等原稿沒有的內容
2. **不要改寫用語**：如把「會被數字代換」改成「直接代入法」
3. **不要添加額外說明**：除非是補充詳解（需明確標示）
4. **不要重新組織內容**：保持原稿的邏輯順序
5. **不要使用華麗的格式**：保持簡潔，與原稿風格一致

**格式指引**：

```markdown
# 基礎數學課程筆記

**日期**：YYYY-MM-DD
**主題**：[從原稿標題提取]

---

## [原稿的第一個主題]

[忠實轉錄內容]

---

## [原稿的第二個主題]

[忠實轉錄內容]
```

**範例對照**：

| 原稿內容 | ✅ 正確整理 | ❌ 錯誤整理 |
|---------|------------|------------|
| 「會被數字代換」 | 會被數字代換 | 直接代入法 |
| 「x 不能用 2 代入！！」 | $x$ 不能用 2 代入！！ | 當 x=2 時會產生不定型 |
| 「c.f.」 | c.f. | 比較：/ 參考： |
| 沒有「學習目標」 | （不加） | 📚 學習目標：... |

**步驟 3：自動生成 PDF**

Claude Code 會在建立 Markdown 後自動執行：
```bash
cd materials/lecture_notes
make pdf DATE=YYYY-MM-DD
```

### Makefile 邏輯

**路徑變數**（`materials/lecture_notes/Makefile`）：
```makefile
ORGANIZED_DIR = lecture_note_organized
TEMPLATE = template.tex
COURSE_NAME = 基礎數學
```

**檔名轉換邏輯**：
1. 尋找檔案：`lecture_note_organized/*_基礎數學_課程筆記_整理版.md`
2. 提取日期：使用 `sed` 從檔名提取 `YYYY-MM-DD`
3. 生成 PDF：輸出到 `lecture_note_organized/YYYY-MM-DD_基礎數學_課程筆記_整理版.pdf`

### 常用命令

```bash
# 在 materials/lecture_notes/ 目錄執行
cd materials/lecture_notes

make                          # 生成所有整理版 PDF
make pdf DATE=2025-10-16      # 生成特定日期的 PDF（強制更新）
make rebuild                  # 清除並重新生成所有 PDF
make clean                    # 清除所有 PDF
make list                     # 列出所有可轉換的 Markdown 檔案
make stats                    # 顯示筆記統計資訊
make open                     # 開啟整理版資料夾

# Quarto 網站相關（在專案根目錄執行）
make preview                  # 本地預覽網站
make build                    # 建置網站
git push                      # 部署網站（推送到 GitHub 自動部署）
```

### 整理版 Markdown 格式範例

```markdown
# 基礎數學課程筆記

**日期**：2025-10-16
**主題**：Ch2 函數（續）

---

## 📚 本週主題

1. 完全平方公式
2. 合併同類項

---

## 📖 詳細內容

### 1. 完全平方公式

$(a+b)^2 = a^2 + 2ab + b^2$

**例題**：

$(x+2)^2 = x^2 + 4x + 4$

...
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

- **手寫原稿**：[2025-10-02_基礎數學_課程筆記_手寫原稿.pdf](materials/lecture_notes/lecture_note/2025-10-02_基礎數學_課程筆記_手寫原稿.pdf)
- **整理版**：[2025-10-02_基礎數學_課程筆記_整理版.pdf](materials/lecture_notes/lecture_note_organized/2025-10-02_基礎數學_課程筆記_整理版.pdf)
```

**注意**：不提供 Markdown 檔案下載連結

#### assignments.qmd（作業與考試）
包含：
- 完整的作業說明（題型、字數、評分標準）
- 明確標示「📝 請至 TronClass 繳交/作答」
- 考試資訊（日期、範圍、配分）

---

## 🔧 開發工作流程

### 新增一週的課程內容

1. **上傳手寫筆記 PDF**
   - 將手寫筆記 PDF 放入 `materials/lecture_notes/lecture_note/`
   - 檔名：`2025-10-16_基礎數學_課程筆記_手寫原稿.pdf`

2. **請 Claude Code 辨識並生成整理版**
   ```
   請幫我處理 2025-10-16 的課程筆記：

   1. 讀取手寫筆記 PDF：
      materials/lecture_notes/lecture_note/2025-10-16_基礎數學_課程筆記_手寫原稿.pdf

   2. 辨識並整理成 Markdown 格式

   3. 儲存為：
      materials/lecture_notes/lecture_note_organized/2025-10-16_基礎數學_課程筆記_整理版.md

   4. 執行 make 生成 PDF
   ```

3. **檢閱生成的內容**
   - 確認 Markdown 內容正確（特別是數學公式）
   - 確認 PDF 格式正確

4. **更新 contents.qmd**
   ```markdown
   ### 第三週（2025-10-16）

   **主題：Ch2 函數（續）- 乘法公式與合併同類項**

   - 完全平方公式
   - 合併同類項

   ---

   #### 📥 課堂筆記下載

   - **手寫原稿**：[2025-10-16_基礎數學_課程筆記_手寫原稿.pdf](materials/lecture_notes/lecture_note/2025-10-16_基礎數學_課程筆記_手寫原稿.pdf)
   - **整理版**：[2025-10-16_基礎數學_課程筆記_整理版.pdf](materials/lecture_notes/lecture_note_organized/2025-10-16_基礎數學_課程筆記_整理版.pdf)
   ```

5. **更新 index.qmd 課程進度表**

   ⚠️ **重要規則**：
   - **上課內容**欄位：使用連結
   - **備註**欄位：
     - 只寫重要事項（作業、考試相關）
     - 使用純文字，不要使用連結
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

6. **預覽網站**
   ```bash
   make preview
   # 瀏覽器開啟 http://localhost:4200
   ```

7. **建置並部署**
   ```bash
   make build
   git add . && git commit -m "更新課程內容" && git push
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

3. **建立 TronClass 題庫檔案**（詳見下方「TronClass 題庫匯入」章節）

---

### TronClass 題庫匯入

#### 檔案格式

TronClass 題庫使用 `.xls` 格式（Excel 97-2003），匯入時需要壓縮成 `.zip`。

**檔案結構**：
```
materials/homework_solutions/hw0X/
├── 作業X題目.md          # 題目 Markdown（網站用）
├── 作業X詳解.md          # 詳解 Markdown（網站用）
├── 作業X_TronClass題庫.xls   # TronClass 匯入用
└── 作業X_TronClass題庫.zip   # 壓縮檔（匯入用）
```

#### Excel 欄位格式

| 欄位 | 說明 | 必填 |
|------|------|------|
| 題型* | `單選題`、`複選題`、`是非題` | ✅ |
| 題幹* | 題目內容（支援 LaTeX：`$...$`） | ✅ |
| 難易度* | `易`、`中`、`難` | ✅ |
| 答案* | 大寫字母（是非題用 `A`=正確、`B`=錯誤） | ✅ |
| 正確答案解釋 | 解答說明 | |
| 配分 | 分數（如 `10`） | |
| 選項-A~G | 選項內容 | |

#### LaTeX 公式支援

TronClass 支援 LaTeX，在題幹和選項中使用 `$...$` 包住公式：

```
題幹：$\lim_{x \to 3} (2x + 1) = ?$
選項A：$5$
選項B：$6$
```

**常用 LaTeX 語法**：
- 極限：`$\lim_{x \to a}$`
- 分數：`$\frac{a}{b}$`
- 次方：`$x^2$`
- 下標：`$x_1$`
- 不等於：`$\neq$`
- 左極限：`$\lim_{x \to a^-}$`
- 右極限：`$\lim_{x \to a^+}$`

#### TronClass 測驗設定

| 設定項目 | 建議值 |
|---------|--------|
| 測驗類型 | 練習 |
| 作答次數上限 | 自訂 10 次 |
| 計分規則 | 最後一次得分 |
| 成績比率 | 8% |
| 公布成績 | 定時公布（截止後） |
| 公布答案 | 定時公布 → 公布對錯與正確答案 |

#### 產生題庫的步驟

1. **建立題目和詳解 Markdown**
2. **使用 Python 產生 Excel 題庫**（使用 `xlwt` 套件）
3. **壓縮成 ZIP 檔案**
   ```bash
   cd materials/homework_solutions/hw0X
   zip 作業X_TronClass題庫.zip 作業X_TronClass題庫.xls
   ```
4. **匯入 TronClass**：上傳 ZIP 檔案到題庫

### 更新 Changelog

**重要**：每次有重要更新時，必須同時更新兩個地方：

1. **更新 changelog.qmd（完整紀錄）**
   - 按時間順序新增更新條目
   - 使用適當的 callout 類型區分更新類別
   - 包含所有相關連結

2. **更新 index.qmd「最近更新」區塊**
   - 只保留最近 3-5 則重要更新
   - 移除較舊的更新（但保留在 changelog.qmd）
   - 確保與 changelog.qmd 內容一致

**更新類別與 Callout 類型**：

| 更新類別 | Callout 類型 | Emoji | 使用時機 |
|---------|-------------|-------|---------|
| 考試資訊 | `callout-important` | 🎯 | 期中考、期末考相關公告 |
| 作業更新 | `callout-warning` | 📝 | 作業開放、截止、詳解發布 |
| 教材更新 | `callout-note` | 📚 | 課程筆記、講義、補充資料 |
| 重要公告 | `callout-caution` | 📢 | 課程政策、特殊安排 |
| 網站功能 | `callout-tip` | ✨ | 網站改版、新功能上線 |

**Changelog 範例**：

```markdown
### 2025/11/20 {.changelog-date}

::: callout-important
## 🎯 考試資訊

**期中考加分辦法公布**

- ✅ **方法一：期中考訂正**（+10 分）
  - 截止時間：2025/12/06 23:59
  - 繳交方式：TronClass「期中考訂正」作業區
- ✅ **方法二：期中考補考**
  - 申請方式：寄信至 statisticalearning123@gmail.com
:::
```

**注意事項**：

- ✅ 日期格式：`YYYY/MM/DD`
- ✅ 標題使用 `{.changelog-date}` CSS 類別
- ✅ 所有 bullet list 前必須空一行（Quarto 規則）
- ✅ 包含相關頁面的連結，方便學生查看詳情
- ✅ 使用清晰簡潔的語言

---

## ⚠️ 重要注意事項

### 術語一致性

- ✅ 使用「**截止時間**」（包含日期和時間）
- ❌ 不使用「截止日期」
- ✅ 課程名稱：「**基礎數學**」（無羅馬數字 I）

### 公告撰寫規範（announcements/）

公告存放於 `announcements/` 資料夾，用於 TronClass 或 Email 發送。

**檔名格式**：`YYYY-MM-DD_公告主題.md`

**公告格式範例**：
```markdown
主旨：成績登錄完成與課後作業三公告

---

同學們好，

跟大家說明幾件事情：

一、第一件事標題

第一件事的內容說明。

二、第二件事標題

第二件事的內容說明：

- 項目一：內容
- 項目二：內容
- 截止時間：2025/12/28（日）23:59

補充說明文字。

有任何問題歡迎來信詢問。

statisticalearning123@gmail.com
```

**格式重點**：

1. **空行規則**：
   - 「同學們好，」後面**不空行**，直接接開場白
   - 每個大標題（一、二、三）前面**空一行**
   - 段落之間**空一行**
   - bullet list 整體前後各**空一行**，但 list 內部項目之間**不空行**
   - 結尾 email 前面**空一行**

2. **日期格式**：
   - ✅ 所有日期後面**必須加括號星期**：`2025/12/28（日）23:59`
   - ✅ 使用 Bash 確認星期：`date -j -f '%Y-%m-%d' '2025-12-28' '+%A'`

3. **結尾格式**：
   - 「有任何問題歡迎來信詢問。」
   - 空一行
   - `statisticalearning123@gmail.com`（不加「鄭澈 老師」）

---

### 日期處理規範

**⚠️ 極度重要：日期必須用 Bash 查證，絕不能憑印象**

Claude 的日期記憶可能不準確，**所有日期相關的判斷都必須透過 Bash 命令確認**。

1. **取得今天日期**：
   ```bash
   date '+%Y/%m/%d %A'
   ```

2. **查證星期幾**：寫日期+星期時，必須用程式確認
   ```bash
   # 確認特定日期是星期幾
   date -j -f '%Y-%m-%d' '2025-12-04' '+%A %Y-%m-%d'
   ```

3. **判斷是否可以發布**：例如「作業詳解公布時間是 12/1」，要先用 bash 確認今天日期是否已過 12/1
   ```bash
   # 先確認今天日期
   date '+%Y/%m/%d'
   # 再判斷是否可以發布
   ```

4. **更新紀錄日期**：使用「實際上傳/更新日期」，而非「上課日期」
   - ✅ 今天 12/13 上傳第十一週筆記 → changelog 日期寫 12/13
   - ❌ 第十一週上課日是 12/11 → changelog 日期不寫 12/11

5. **筆記檔名日期**：使用「上課日期」
   - ✅ `2025-12-11_基礎數學_課程筆記_整理版.md`（上課日期）
   - 這樣學生容易對應是哪一週的內容

**嚴禁事項**：

- ❌ **絕對不能憑印象判斷日期**（Claude 的日期記憶常常出錯）
- ❌ 憑感覺猜星期幾（例如：12/4 寫成星期三，實際是星期四）
- ❌ 把「上課日期」當成「更新紀錄日期」
- ❌ 不確認就說「今天是 X 月 X 日」

### 顏色規範

- **主色**：龍華藍 `#003366`
- **強調色**：`#0066CC`
- ❌ 不使用紅色（曾誤用 `#CC0033`）

### PDF 檔名

- ✅ 課程名稱固定為「基礎數學」
- ✅ 從檔名自動提取日期
- ✅ 手寫原稿格式：`YYYY-MM-DD_基礎數學_課程筆記_手寫原稿.pdf`
- ✅ 整理版格式：`YYYY-MM-DD_基礎數學_課程筆記_整理版.pdf`
- ❌ 不從檔名提取課程主題（如 "markdown版"）

### 設計原則

- ✅ 網站提供**完整詳細的說明**
- ✅ 明確標示「📝 請至 TronClass 繳交」
- ❌ 絕不只寫「請至 TronClass 查看」

### Quarto Markdown 格式規範

- ✅ **Bullet point 前必須空一行**，否則會渲染失敗
- ✅ **正確格式**：
  ```markdown
  **考試卷**：

  - 期中考試卷.pdf
  - 期中考答案卷.pdf
  ```
- ❌ **錯誤格式**（會渲染成連續文字）：
  ```markdown
  **考試卷**：
  - 期中考試卷.pdf
  - 期中考答案卷.pdf
  ```

**常見錯誤範例**：

```markdown
# ❌ 錯誤：bullet point 前沒有空行
詳細解答（2025/11/16 公布）：
- 期中考詳解.pdf

內容包含：
- ✅ 第一部分：10 道選擇題完整解答
- ✅ 第二部分：2 道計算題詳細步驟

# ✅ 正確：bullet point 前空一行
詳細解答（2025/11/16 公布）：

- 期中考詳解.pdf

內容包含：

- ✅ 第一部分：10 道選擇題完整解答
- ✅ 第二部分：2 道計算題詳細步驟
```

**重要提醒**：
- 在編輯 `.qmd` 檔案時，所有 bullet list 前都必須空一行
- 適用於所有層級的標題後接 bullet list 的情況
- 這是 Quarto 的 Markdown 解析規則，必須嚴格遵守

### 更新紀錄規範

**⚠️ 極度重要：所有修改都必須記錄到更新紀錄**

每次修改網站內容時，**必須同時更新**：

1. **changelog.qmd**（完整紀錄）
   - 按時間順序新增更新條目
   - 使用適當的 callout 類型（參見「更新 Changelog」章節）
   - 包含所有相關連結

2. **index.qmd 的「最近更新」區塊**
   - 保留最近 3-5 則重要更新
   - 移除較舊的更新（但保留在 changelog.qmd）
   - 確保與 changelog.qmd 內容一致

**需要記錄的修改類型**：

- ✅ 新增課程筆記
- ✅ 新增/修改作業資訊
- ✅ 考試相關公告
- ✅ 網站功能更新（如新增快速連結、書籤功能）
- ✅ 課程資訊更新（如教科書資訊、授課章節）
- ✅ 課程政策變更
- ❌ 僅修正錯字或格式（除非影響學生理解）

**記錄時機**：

- 📌 **即時記錄**：完成修改後立即更新 changelog
- 📌 **一次性記錄**：相關的多個修改可以合併為一則更新
- 📌 **明確日期**：使用修改當天的日期

**範例**：

如果在 2025/11/21 新增了教科書資訊和授課章節，應該在 changelog.qmd 中新增：

```markdown
### 2025/11/21 {.changelog-date}

::: callout-note
## 📚 教材更新

**新增教科書資訊與授課章節**

- 指定教科書：微積分（張振華、彭賓鈺著，新文京出版）
- 詳細授課章節：
  - Chapter 02 函數（3 個子章節）
  - Chapter 03 函數的極限與連續（4 個子章節）

詳見：[課程大綱 - 課程教材](index.qmd#課程教材)
:::
```

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
# 課程筆記 PDF（在 materials/lecture_notes/ 執行）
cd materials/lecture_notes
make                          # 生成所有整理版 PDF
make pdf DATE=2025-10-16      # 生成特定日期的 PDF（強制更新）
make rebuild                  # 重新生成所有 PDF
make clean                    # 清除所有整理版 PDF
make list                     # 列出所有可轉換的 Markdown 檔案
make stats                    # 顯示筆記統計資訊
make open                     # 開啟整理版資料夾

# 網站相關（在專案根目錄執行）
make preview                  # 預覽網站
make build                    # 建置網站
git push                      # 部署網站（推送到 GitHub 自動部署）
```

---

## 📖 相關文件

- [README.md](README.md) - 專案完整說明
- [DESIGN_PRINCIPLES.md](DESIGN_PRINCIPLES.md) - 設計原則
- [materials/lecture_notes/Makefile](materials/lecture_notes/Makefile) - 課程筆記 PDF 生成邏輯
- [materials/lecture_notes/CLAUDE_如何生成整理版筆記.md](materials/lecture_notes/CLAUDE_如何生成整理版筆記.md) - 詳細流程說明（含 Mermaid 圖）
- [_quarto.yml](_quarto.yml) - 網站配置

---

**最後更新**：2025-12-03
**維護者**：鄭澈
