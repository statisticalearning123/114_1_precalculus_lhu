# 部署指南：Posit Connect Cloud

本課程網站使用 **Quarto + Python** 建立，並部署到 **Posit Connect Cloud**。

## 📋 部署流程總覽

1. 建立 GitHub repository（公開）
2. 設定本地專案環境
3. 建立虛擬環境
4. 安裝必要套件
5. 建立 Quarto 文件
6. 本地預覽測試
7. 推送到 GitHub
8. 部署到 Posit Connect Cloud

---

## 🔧 詳細步驟

### 1. 建立 GitHub Repository

- 登入 GitHub
- 建立新的 **公開** repository
- 記錄 repository URL

### 2. Clone Repository 到本地

在 VS Code 或終端機：

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

### 3. 建立 Python 虛擬環境

```bash
python -m venv venv
source venv/bin/activate  # macOS/Linux
# 或
venv\Scripts\activate     # Windows
```

### 4. 安裝必要套件

建立 `requirements.txt`：

```txt
plotly
jupyter
pandas
```

安裝套件：

```bash
pip install -r requirements.txt
```

### 5. 建立 Quarto 文件

建立主要文件，例如 `dashboard.qmd` 或 `index.qmd`

### 6. 本地預覽

```bash
quarto preview dashboard.qmd
```

檢查網站是否正常運作。

### 7. 推送到 GitHub

建立 `.gitignore`：

```bash
touch .gitignore
```

在 `.gitignore` 中加入：

```
venv/
_site/
.quarto/
*.pyc
__pycache__/
```

推送到 GitHub：

```bash
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

### 8. 部署到 Posit Connect Cloud

1. 登入 [Posit Connect Cloud](https://connect.posit.cloud/)
2. 點擊 **Publish** 圖示按鈕
3. 選擇 **Quarto**
4. 選擇你的 GitHub repository
5. 確認 branch（通常是 `main`）
6. 選擇主要檔案（例如 `index.qmd` 或 `dashboard.qmd`）
7. 點擊 **Publish**

部署過程會顯示狀態更新和建置日誌。

---

## 🔄 更新與重新部署

當你更新程式碼或資料後：

1. 提交並推送變更到 GitHub：

```bash
git add .
git commit -m "Update content"
git push
```

2. 前往 Connect Cloud 的 **Content List**
3. 點擊內容旁的 **republish** 圖示

網站會自動重新建置和部署。

---

## 📝 注意事項

- Repository 必須是 **公開的**（或設定 GitHub App 連結）
- 確保 `requirements.txt` 包含所有必要套件
- `.gitignore` 要排除虛擬環境和暫存檔
- 主要 `.qmd` 檔案要在 repository 根目錄或指定位置

---

## 🔗 參考資源

- [Posit Connect Cloud 文件](https://docs.posit.co/connect-cloud/)
- [Quarto 官方文件](https://quarto.org/)
- [範例專案](https://github.com/posit-dev/connect-cloud-examples)

---

最後更新：2025-10-09
