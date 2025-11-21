# 考試公式表系統

本資料夾包含考試相關的公式表，可以附在考卷最後提供給學生參考。

## 📁 檔案說明

- **期中考公式表.md** - Markdown 原始檔（可編輯）
- **期中考公式表.pdf** - PDF 版本（印出附在考卷後面）
- **Makefile** - 自動化生成工具

## 🚀 快速開始

### 生成 PDF

在此資料夾執行：

```bash
cd materials/exams/midterm
make
```

### 開啟生成的 PDF

```bash
make open
```

### 重新生成 PDF

```bash
make rebuild
```

## ✏️ 修改公式表

1. **編輯 Markdown 檔案**：
   ```bash
   # 使用任何文字編輯器編輯
   open "期中考公式表.md"
   ```

2. **重新生成 PDF**：
   ```bash
   make rebuild
   ```

## 📋 公式表內容

目前期中考公式表包含：

1. **指數律**
   - 同底數相乘
   - 指數的指數

2. **乘法公式**
   - 完全平方公式
   - 完全平方差公式
   - 平方差公式

3. **直線方程式**
   - 直線通式 y = mx + b
   - 直線的性質
   - 比較係數法

4. **函數相關**
   - 函數代入（框框法）
   - 負號規則

5. **合併同類項**
   - 同類項的判斷
   - 合併步驟

6. **函數的圖形**
   - 定義域與值域
   - 描點法
   - 直角坐標平面

## 📝 使用建議

### 考卷編排

建議在考卷最後一頁附上公式表，可以：

1. **單獨一頁**：
   - 印出「期中考公式表.pdf」
   - 釘在考卷最後

2. **嵌入考卷**：
   - 將 PDF 內容複製到考卷文件中
   - 放在考卷最後一頁或兩頁

### 印刷注意事項

- **建議紙張**：A4
- **邊界設定**：已設定為 2cm
- **字體大小**：12pt（適合閱讀）
- **顏色**：彩色印刷效果更佳（標題使用龍華藍）

## 🔧 技術說明

### 生成方式

使用 Pandoc + XeLaTeX 將 Markdown 轉換為 PDF：

```bash
pandoc "期中考公式表.md" \
  -o "期中考公式表.pdf" \
  --pdf-engine=xelatex \
  --template=../lecture_notes/template.tex \
  -V documentclass=article \
  -V fontsize=12pt \
  -V papersize=a4 \
  -V geometry:margin=2cm \
  -V CJKmainfont="PingFang TC" \
  -V mainfont="PingFang TC" \
  --toc=false
```

### 模板

使用與課程筆記相同的 LaTeX 模板（`../lecture_notes/template.tex`），確保風格一致。

## 📚 未來擴充

可以為期末考建立類似的公式表：

1. 複製「期中考公式表.md」為「期末考公式表.md」
2. 修改內容（增加 Ch3 相關公式）
3. 在 Makefile 中新增 `final` 目標

---

**最後更新**：2025-11-13
