# 龍華科技大學 - 基礎數學 I 課堂筆記

> 114 學年度第 1 學期

---

## 📚 關於本資料夾

這個資料夾包含「基礎數學 I」課程的所有上課筆記，包括：

- **Markdown 格式筆記**：方便編輯和版本控制
- **PDF 格式筆記**：適合列印和閱讀
- **轉換工具**：自動將 Markdown 轉換成精美的 PDF

---

## 📁 資料夾結構

```
class_note/
├── README.md              # 本文件
├── template.tex           # LaTeX PDF 模板
├── pdf_convert.sh         # PDF 轉換腳本
├── Makefile              # Make 自動化工具
│
├── draft/                # 草稿筆記
│   └── 筆記_YYYY-MM-DD_*.md
│
├── 筆記_YYYY-MM-DD_*.md  # 正式筆記（Markdown）
│
└── pdf_output/           # 生成的 PDF（自動產生）
    └── 筆記_YYYY-MM-DD_*.pdf
```

---

## 🚀 快速開始

### 方法 1：使用 Make（推薦）

```bash
# 生成所有 PDF
make

# 生成特定日期的 PDF
make pdf DATE=2025-10-02

# 查看幫助
make help
```

### 方法 2：使用 Shell 腳本

```bash
# 生成所有 PDF
./pdf_convert.sh

# 生成特定日期的 PDF
./pdf_convert.sh 2025-10-02

# 查看幫助
./pdf_convert.sh help
```

---

## 📋 常用指令

### Make 指令

| 指令 | 說明 |
|------|------|
| `make` | 生成所有筆記的 PDF |
| `make pdf DATE=2025-10-02` | 生成特定日期的 PDF |
| `make clean` | 清除所有 PDF 檔案 |
| `make rebuild` | 重新生成所有 PDF |
| `make open` | 開啟 PDF 資料夾 |
| `make list` | 列出所有可轉換的檔案 |
| `make stats` | 顯示統計資訊 |
| `make check` | 檢查必要套件 |
| `make help` | 顯示幫助訊息 |

### Shell 腳本指令

| 指令 | 說明 |
|------|------|
| `./pdf_convert.sh` | 生成所有 PDF |
| `./pdf_convert.sh 2025-10-02` | 生成特定日期的 PDF |
| `./pdf_convert.sh clean` | 清除所有 PDF |
| `./pdf_convert.sh rebuild` | 重新生成所有 PDF |
| `./pdf_convert.sh open` | 開啟 PDF 資料夾 |
| `./pdf_convert.sh list` | 列出可轉換檔案 |
| `./pdf_convert.sh stats` | 統計資訊 |

---

## 🔧 環境設定

### 必要套件

1. **Pandoc** - Markdown 轉換工具
2. **MacTeX** - LaTeX 排版系統（包含 xelatex）

### 安裝步驟

#### 自動安裝（推薦）

```bash
make install-deps
```

或

```bash
./pdf_convert.sh install
```

#### 手動安裝

```bash
# 安裝 Pandoc
brew install pandoc

# 安裝 MacTeX（較大，需要時間）
brew install --cask mactex
```

### 檢查安裝

```bash
make check
```

或

```bash
./pdf_convert.sh check
```

---

## 📝 筆記命名規則

### Markdown 檔案

格式：`筆記_YYYY-MM-DD_描述.md`

範例：
- `筆記_2025-10-02_markdown版.md`
- `筆記_2025-10-09_函數與指數.md`

### PDF 檔案（自動生成）

格式：`筆記_YYYY-MM-DD_描述.pdf`

位置：`pdf_output/`

---

## 🎨 PDF 樣式特色

生成的 PDF 具有以下特色：

- ✅ **中文支援**：使用 PingFang TC 字體
- ✅ **數學公式**：完整的 LaTeX 數學支援
- ✅ **程式碼區塊**：清楚的語法高亮
- ✅ **精美排版**：專業的標題和段落格式
- ✅ **頁首頁尾**：包含課程資訊和頁碼
- ✅ **色彩設計**：龍華科大紅色主題

---

## 📖 撰寫筆記建議

### Markdown 格式範例

```markdown
# 基礎數學 I - 上課筆記

**日期**: 2025-10-02
**章節**: Ch2 函數

---

## 2.1 函數定義

函數 `f(x) = y` 表示...

### 例題

若 `f(x) = x²`，則：

- `f(0) = 0`
- `f(1) = 1`
- `f(2) = 4`
```

### 數學公式

```markdown
行內公式：`f(x) = x²`

獨立公式：
```math
f(x) = x² + 2x + 1
```
```

---

## 🔍 疑難排解

### 問題 1：找不到檔案

**錯誤訊息**：`找不到檔案: 筆記_2025-10-02_*.md`

**解決方式**：
- 確認檔名格式正確：`筆記_YYYY-MM-DD_*.md`
- 檢查檔案位置（當前目錄或 `draft/`）

### 問題 2：PDF 生成失敗

**可能原因**：
- 缺少必要套件
- LaTeX 語法錯誤

**解決方式**：
```bash
# 檢查套件
make check

# 查看詳細錯誤訊息
pandoc 筆記_2025-10-02_markdown版.md -o test.pdf --pdf-engine=xelatex
```

### 問題 3：中文顯示問題

**確認**：
- 系統已安裝 PingFang TC 字體
- 使用 xelatex 引擎（不是 pdflatex）

---

## 💡 使用技巧

### 技巧 1：批次轉換

```bash
# 一次生成所有筆記
make rebuild
```

### 技巧 2：即時預覽

```bash
# 生成 PDF 後立即開啟
make pdf DATE=2025-10-02 && make open
```

### 技巧 3：檢查進度

```bash
# 查看統計資訊
make stats
```

---

## 📚 相關文件

- [Pandoc 官方文件](https://pandoc.org/)
- [LaTeX 數學符號](https://www.overleaf.com/learn/latex/Mathematical_expressions)
- [Markdown 語法](https://www.markdownguide.org/)

---

## 🎓 課程資訊

- **課程**：基礎數學 I
- **學校**：龍華科技大學
- **學期**：114 學年度第 1 學期
- **教師**：鄭澈

---

*最後更新：2025-10-10*
