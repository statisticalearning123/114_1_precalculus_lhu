# 預備微積分課程網站

龍華科技大學 114學年度第1學期 預備微積分課程網站

## 專案結構

```
114_1_龍華科大/
├── _quarto.yml              # Quarto 網站配置檔
├── index.qmd                # 首頁
├── syllabus.qmd            # 課程大綱
├── schedule.qmd            # 課程進度表
├── DEPLOYMENT.md           # 部署指南
├── README.md               # 本檔案
├── requirements.txt        # Python 套件需求
├── .gitignore             # Git 忽略清單
│
├── weeks/                  # 每週課程內容
│   ├── week01/
│   │   └── index.qmd
│   ├── week02/
│   │   └── index.qmd
│   └── week03/
│       └── index.qmd
│
├── assignments/            # 作業
│   ├── hw01.qmd
│   └── hw02.qmd
│
├── exams/                  # 考試資訊
│   ├── midterm.qmd
│   └── final.qmd
│
├── resources/              # 學習資源
│   ├── notes.qmd
│   ├── supplements.qmd
│   └── links.qmd
│
└── assets/                 # 靜態資源
    ├── images/
    ├── data/
    └── css/
        └── styles.css
```

## 快速開始

### 1. 安裝 Quarto

從 [Quarto 官網](https://quarto.org/docs/get-started/) 下載並安裝 Quarto。

### 2. 設定 Python 環境（如果使用 Python）

```bash
# 建立虛擬環境
python -m venv venv

# 啟動虛擬環境
source venv/bin/activate  # macOS/Linux
# 或
venv\Scripts\activate     # Windows

# 安裝必要套件
pip install -r requirements.txt
```

### 3. 本地預覽

```bash
# 預覽整個網站
quarto preview

# 或預覽單一檔案
quarto preview index.qmd
```

### 4. 建置網站

```bash
quarto render
```

建置完成的網站會在 `_site/` 資料夾中。

## 部署到 Posit Connect Cloud

詳細部署步驟請參閱 [DEPLOYMENT.md](DEPLOYMENT.md)。

### 簡要步驟：

1. 推送到 GitHub
2. 登入 Posit Connect Cloud
3. 選擇 Quarto 專案
4. 連結 GitHub repository
5. 選擇 `index.qmd` 作為主要檔案
6. 部署

## 內容維護

### 新增週次內容

1. 複製現有週次資料夾作為範本
2. 修改內容和日期
3. 在 `_quarto.yml` 中更新導航選單

### 新增作業

1. 在 `assignments/` 目錄下建立新的 `.qmd` 檔案
2. 使用 `hw01.qmd` 作為範本
3. 在 `_quarto.yml` 中更新導航選單

### 更新課程進度

編輯 `schedule.qmd` 檔案即可。

## 自訂樣式

編輯 `assets/css/styles.css` 來自訂網站外觀。

## 使用的技術

- **Quarto**: 科學和技術出版系統
- **Python**: 用於數學計算和視覺化
  - matplotlib
  - plotly
  - numpy
  - pandas
  - sympy
- **Posit Connect Cloud**: 網站託管

## 注意事項

1. 修改 `.qmd` 檔案後，Quarto 會自動重新建置
2. Python 程式碼區塊使用 `{python}` 標記
3. 數學公式使用 LaTeX 語法，放在 `$$` 或 `$` 之間
4. 所有圖片應放在 `assets/images/` 目錄

## 常用 Quarto 語法

### Callout 區塊

```markdown
::: {.callout-note}
這是提示訊息
:::

::: {.callout-tip}
這是建議
:::

::: {.callout-warning}
這是警告
:::

::: {.callout-important}
這是重要訊息
:::
```

### 數學公式

```markdown
行內公式：$E = mc^2$

區塊公式：
$$
\int_a^b f(x)dx = F(b) - F(a)
$$
```

### 程式碼區塊

````markdown
```{python}
#| echo: true
#| code-fold: false

import numpy as np
x = np.linspace(0, 10, 100)
```
````

## 問題排解

### Quarto 無法找到 Python

確保已安裝 Python 並將其加入 PATH。

### 套件安裝失敗

確認已啟動虛擬環境，並更新 pip：

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### 網站預覽無法開啟

檢查是否有其他程式佔用埠號 (port)。

## 更新日誌

- 2025-10-09: 初始建立專案結構

## 授權

本課程教材僅供教育使用。

## 聯絡資訊

- 授課教師：[教師姓名]
- Email: [email@example.com]
- Office Hours: [時間和地點]
