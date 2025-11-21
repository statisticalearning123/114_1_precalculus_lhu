# Makefile for converting Markdown lecture notes to PDF
# 龍華科技大學 - 基礎數學課程筆記轉換工具

# 變數設定
ORGANIZED_DIR = lecture_note_organized
TEMPLATE = template.tex
COURSE_NAME = 基礎數學

# 尋找所有 markdown 檔案
MD_FILES = $(wildcard $(ORGANIZED_DIR)/*_基礎數學_課程筆記_整理版.md)

# 顏色設定（終端機輸出）
GREEN = \033[0;32m
BLUE = \033[0;34m
YELLOW = \033[1;33m
NC = \033[0m # No Color

# 預設目標：生成所有 PDF
.PHONY: all
all: $(ORGANIZED_DIR)
	@echo "$(BLUE)開始轉換所有整理版筆記...$(NC)"
	@for mdfile in $(MD_FILES); do \
		$(MAKE) convert-single MD_FILE=$$mdfile; \
	done
	@echo "$(GREEN)✓ 所有整理版 PDF 已生成完畢！$(NC)"
	@echo "$(BLUE)輸出位置: $(ORGANIZED_DIR)/$(NC)"

# 建立輸出資料夾
$(ORGANIZED_DIR):
	@mkdir -p $(ORGANIZED_DIR)
	@echo "$(GREEN)✓ 建立輸出資料夾: $(ORGANIZED_DIR)$(NC)"

# 轉換單一檔案（內部使用）
.PHONY: convert-single
convert-single:
	@if [ -z "$(MD_FILE)" ]; then \
		echo "$(YELLOW)錯誤: 需要指定 MD_FILE$(NC)"; \
		exit 1; \
	fi
	@BASENAME=$$(basename "$(MD_FILE)"); \
	CLASS_DATE=$$(echo "$$BASENAME" | sed -n 's/\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)_.*/\1/p'); \
	if [ -n "$$CLASS_DATE" ]; then \
		OUTPUT_NAME="$${CLASS_DATE}_$(COURSE_NAME)_課程筆記_整理版.pdf"; \
		OUTPUT_PATH="$(ORGANIZED_DIR)/$$OUTPUT_NAME"; \
		echo "$(BLUE)正在轉換: $(MD_FILE)$(NC)"; \
		echo "$(BLUE)  日期: $$CLASS_DATE$(NC)"; \
		echo "$(BLUE)  課程: $(COURSE_NAME)$(NC)"; \
		echo "$(BLUE)  輸出: $$OUTPUT_NAME$(NC)"; \
		pandoc "$(MD_FILE)" \
			--pdf-engine=xelatex \
			--template=$(TEMPLATE) \
			-V CJKmainfont="PingFang TC" \
			-V mainfont="PingFang TC" \
			-V date="$$CLASS_DATE" \
			-V geometry:margin=2.5cm \
			-V documentclass=article \
			-V fontsize=12pt \
			-V colorlinks=true \
			-V linkcolor=blue \
			-V urlcolor=blue \
			-o "$$OUTPUT_PATH" 2>&1 | grep -v "Missing character" || true; \
		echo "$(GREEN)✓ 完成: $$OUTPUT_NAME$(NC)"; \
	else \
		echo "$(YELLOW)⚠ 跳過: $(MD_FILE) (檔名格式不符)$(NC)"; \
	fi

# 只生成特定日期的 PDF（強制更新）
.PHONY: pdf
pdf:
	@if [ -z "$(DATE)" ]; then \
		echo "$(YELLOW)使用方式: make pdf DATE=2025-10-02$(NC)"; \
		exit 1; \
	fi
	@file=$$(ls $(ORGANIZED_DIR)/$(DATE)_$(COURSE_NAME)_課程筆記_整理版.md 2>/dev/null | head -n 1); \
	if [ -z "$$file" ]; then \
		echo "$(YELLOW)找不到檔案: $(ORGANIZED_DIR)/$(DATE)_$(COURSE_NAME)_課程筆記_整理版.md$(NC)"; \
		exit 1; \
	fi; \
	OUTPUT_NAME="$(DATE)_$(COURSE_NAME)_課程筆記_整理版.pdf"; \
	rm -f "$(ORGANIZED_DIR)/$$OUTPUT_NAME"; \
	$(MAKE) convert-single MD_FILE="$$file"

# 清除所有生成的 PDF
.PHONY: clean
clean:
	@rm -f $(ORGANIZED_DIR)/*.pdf
	@echo "$(GREEN)✓ 已清除所有整理版 PDF 檔案$(NC)"

# 重新生成所有 PDF
.PHONY: rebuild
rebuild: clean all

# 檢查相依套件
.PHONY: check
check:
	@echo "檢查必要套件..."
	@command -v pandoc >/dev/null 2>&1 || { echo "❌ 缺少 pandoc，請執行: brew install pandoc"; exit 1; }
	@command -v xelatex >/dev/null 2>&1 || { echo "❌ 缺少 xelatex，請執行: brew install --cask mactex"; exit 1; }
	@echo "$(GREEN)✓ 所有必要套件已安裝$(NC)"

# 開啟 PDF 輸出資料夾
.PHONY: open
open:
	@if [ -d "$(ORGANIZED_DIR)" ]; then \
		open $(ORGANIZED_DIR); \
	else \
		echo "$(BLUE)整理版資料夾不存在，請先執行 make$(NC)"; \
	fi

# 列出所有可轉換的檔案
.PHONY: list
list:
	@echo "$(BLUE)可轉換的 Markdown 檔案：$(NC)"
	@if [ -n "$(MD_FILES)" ]; then \
		for file in $(MD_FILES); do \
			echo "  - $$file"; \
		done; \
	else \
		echo "  （無）"; \
	fi

# 顯示統計資訊
.PHONY: stats
stats:
	@echo "$(BLUE)筆記統計：$(NC)"
	@echo "  Markdown 檔案數: $(words $(MD_FILES))"
	@if [ -d "$(ORGANIZED_DIR)" ]; then \
		echo "  已生成 PDF 數: $$(ls -1 $(ORGANIZED_DIR)/*.pdf 2>/dev/null | wc -l | tr -d ' ')"; \
	else \
		echo "  已生成 PDF 數: 0"; \
	fi

# 顯示幫助訊息
.PHONY: help
help:
	@echo "$(BLUE)龍華科技大學 - 基礎數學筆記 PDF 轉換工具$(NC)"
	@echo ""
	@echo "可用指令："
	@echo "  make                       - 生成所有整理版筆記的 PDF"
	@echo "  make pdf DATE=2025-10-02   - 生成特定日期的 PDF（強制更新）"
	@echo "  make clean                 - 清除所有 PDF 檔案"
	@echo "  make rebuild               - 重新生成所有 PDF"
	@echo "  make check                 - 檢查必要套件是否已安裝"
	@echo "  make open                  - 開啟整理版 PDF 輸出資料夾"
	@echo "  make list                  - 列出所有可轉換的檔案"
	@echo "  make stats                 - 顯示統計資訊"
	@echo "  make help                  - 顯示此幫助訊息"
