# 龍華科技大學 - 基礎數學 主 Makefile
# 管理課程筆記 PDF 和課程網站

# 顏色設定
GREEN = \033[0;32m
BLUE = \033[0;34m
YELLOW = \033[1;33m
NC = \033[0m # No Color

# 預設目標：建置 PDF
.PHONY: all
all:
	@$(MAKE) -C materials/_source all

# ========== 課程筆記 PDF 相關 ==========

.PHONY: rebuild clean pdf check install-deps open list stats
rebuild:
	@echo "$(BLUE)重新生成所有課程筆記 PDF$(NC)"
	@$(MAKE) -C materials/_source rebuild

clean:
	@echo "$(BLUE)清除課程筆記 PDF$(NC)"
	@$(MAKE) -C materials/_source clean

pdf:
	@$(MAKE) -C materials/_source pdf DATE=$(DATE)

check:
	@$(MAKE) -C materials/_source check

install-deps:
	@$(MAKE) -C materials/_source install-deps

open:
	@$(MAKE) -C materials/_source open

list:
	@$(MAKE) -C materials/_source list

stats:
	@$(MAKE) -C materials/_source stats

# ========== Quarto 課程網站相關 ==========

.PHONY: preview build deploy clean-site
preview:
	@echo "$(BLUE)啟動 Quarto 預覽伺服器...$(NC)"
	@quarto preview

build:
	@echo "$(BLUE)建置 Quarto 網站...$(NC)"
	@quarto render
	@echo "$(GREEN)✓ 網站建置完成！輸出位置: _site/$(NC)"

deploy:
	@echo "$(BLUE)部署網站到 Posit Connect Cloud...$(NC)"
	@quarto publish connect

clean-site:
	@echo "$(BLUE)清除網站建置檔案$(NC)"
	@rm -rf _site
	@rm -rf .quarto
	@echo "$(GREEN)✓ 網站建置檔案已清除$(NC)"

# ========== 綜合指令 ==========

.PHONY: clean-all build-all help
clean-all: clean clean-site
	@echo "$(GREEN)✓ 已清除所有生成檔案（PDF + 網站）$(NC)"

build-all: rebuild build
	@echo "$(GREEN)✓ 已建置所有內容（PDF + 網站）$(NC)"

# ========== 幫助資訊 ==========

help:
	@echo "$(BLUE)龍華科技大學 - 基礎數學 專案管理$(NC)"
	@echo ""
	@echo "$(YELLOW)課程筆記 PDF 指令：$(NC)"
	@echo "  make                       - 生成所有筆記的 PDF"
	@echo "  make rebuild               - 重新生成所有 PDF"
	@echo "  make pdf DATE=2025-10-02   - 生成特定日期的 PDF"
	@echo "  make clean                 - 清除所有 PDF 檔案"
	@echo "  make open                  - 開啟 PDF 輸出資料夾"
	@echo "  make list                  - 列出所有可轉換的檔案"
	@echo "  make stats                 - 顯示統計資訊"
	@echo ""
	@echo "$(YELLOW)Quarto 課程網站指令：$(NC)"
	@echo "  make preview               - 本地預覽網站"
	@echo "  make build                 - 建置靜態網站"
	@echo "  make deploy                - 部署到 Posit Connect Cloud"
	@echo "  make clean-site            - 清除網站建置檔案"
	@echo ""
	@echo "$(YELLOW)綜合指令：$(NC)"
	@echo "  make clean-all             - 清除所有生成檔案（PDF + 網站）"
	@echo "  make build-all             - 建置所有內容（PDF + 網站）"
	@echo "  make check                 - 檢查必要套件"
	@echo "  make install-deps          - 安裝必要套件"
	@echo "  make help                  - 顯示此幫助訊息"
	@echo ""
	@echo "$(GREEN)範例：$(NC)"
	@echo "  make preview               # 預覽課程網站"
	@echo "  make build-all             # 建置 PDF 和網站"
	@echo "  make deploy                # 部署網站"
