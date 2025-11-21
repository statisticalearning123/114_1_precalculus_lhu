# Makefile for generating exam papers and formula sheets
# 龍華科技大學 - 基礎數學考試資料生成工具

# 變數設定
TEMPLATE_LECTURE = ../../lecture_notes/template.tex
TEMPLATE_EXAM = template-exam.tex
COURSE_NAME = 基礎數學

# 顏色設定（終端機輸出）
GREEN = \033[0;32m
BLUE = \033[0;34m
YELLOW = \033[1;33m
NC = \033[0m # No Color

# 預設目標：生成正式考卷
.PHONY: all
all: exam

# 生成正式考卷（含公式表）
.PHONY: exam
exam:
	@echo "$(BLUE)正在生成期中考考卷 PDF（含公式表）...$(NC)"
	@pandoc "2025-期中考-考卷-正式版.md" \
		-o "2025-期中考-考卷.pdf" \
		--pdf-engine=xelatex \
		--template=$(TEMPLATE_EXAM) \
		-V documentclass=article \
		-V fontsize=12pt \
		-V papersize=a4 \
		-V CJKmainfont="PingFang TC" \
		-V mainfont="PingFang TC" \
		2>&1 | grep -v "Missing character" || true
	@echo "$(GREEN)✓ 期中考考卷 PDF 已生成！$(NC)"
	@echo "$(BLUE)輸出檔案: 2025-期中考-考卷.pdf$(NC)"

# 生成期中考公式表（獨立檔案）
.PHONY: formula
formula:
	@echo "$(BLUE)正在生成期中考公式表 PDF...$(NC)"
	@pandoc "期中考公式表.md" \
		-o "期中考公式表.pdf" \
		--pdf-engine=xelatex \
		--template=$(TEMPLATE_LECTURE) \
		-V documentclass=article \
		-V fontsize=12pt \
		-V papersize=a4 \
		-V geometry:margin=2cm \
		-V CJKmainfont="PingFang TC" \
		-V mainfont="PingFang TC" \
		--toc=false 2>&1 | grep -v "Missing character" || true
	@echo "$(GREEN)✓ 期中考公式表 PDF 已生成！$(NC)"
	@echo "$(BLUE)輸出檔案: 期中考公式表.pdf$(NC)"

# 生成期中考詳解 PDF
.PHONY: solution
solution:
	@echo "$(BLUE)正在生成期中考詳解 PDF...$(NC)"
	@pandoc "2025-期中考-詳解.md" \
		-o "2025-期中考-詳解.pdf" \
		--pdf-engine=xelatex \
		--template=$(TEMPLATE_LECTURE) \
		-V documentclass=article \
		-V fontsize=12pt \
		-V papersize=a4 \
		-V geometry:margin=2cm \
		-V CJKmainfont="PingFang TC" \
		-V mainfont="PingFang TC" \
		--toc=true \
		--toc-depth=3 \
		2>&1 | grep -v "Missing character" || true
	@echo "$(GREEN)✓ 期中考詳解 PDF 已生成！$(NC)"
	@echo "$(BLUE)輸出檔案: 2025-期中考-詳解.pdf$(NC)"

# 生成答案卷 PDF
.PHONY: answer
answer:
	@echo "$(BLUE)正在生成期中考答案卷 PDF...$(NC)"
	@pandoc "2025-期中考-答案卷.md" \
		-o "2025-期中考-答案卷.pdf" \
		--pdf-engine=xelatex \
		--template=template-answer-sheet.tex \
		-V documentclass=article \
		-V fontsize=12pt \
		-V papersize=a4 \
		-V CJKmainfont="PingFang TC" \
		-V mainfont="PingFang TC" \
		2>&1 | grep -v "Missing character" || true
	@echo "$(GREEN)✓ 期中考答案卷 PDF 已生成！$(NC)"
	@echo "$(BLUE)輸出檔案: 2025-期中考-答案卷.pdf$(NC)"

# 清除生成的 PDF
.PHONY: clean
clean:
	@rm -f *.pdf
	@echo "$(GREEN)✓ 已清除所有 PDF 檔案$(NC)"

# 重新生成
.PHONY: rebuild
rebuild: clean all

# 開啟考卷 PDF
.PHONY: open
open:
	@if [ -f "2025-期中考-考卷-正式版.pdf" ]; then \
		open "2025-期中考-考卷-正式版.pdf"; \
	else \
		echo "$(YELLOW)考卷 PDF 不存在，請先執行 make exam$(NC)"; \
	fi

# 開啟公式表 PDF
.PHONY: open-formula
open-formula:
	@if [ -f "期中考公式表.pdf" ]; then \
		open "期中考公式表.pdf"; \
	else \
		echo "$(YELLOW)公式表 PDF 不存在，請先執行 make formula$(NC)"; \
	fi

# 檢查相依套件
.PHONY: check
check:
	@echo "檢查必要套件..."
	@command -v pandoc >/dev/null 2>&1 || { echo "❌ 缺少 pandoc，請執行: brew install pandoc"; exit 1; }
	@command -v xelatex >/dev/null 2>&1 || { echo "❌ 缺少 xelatex，請執行: brew install --cask mactex"; exit 1; }
	@echo "$(GREEN)✓ 所有必要套件已安裝$(NC)"

# 顯示幫助訊息
.PHONY: help
help:
	@echo "$(BLUE)龍華科技大學 - 基礎數學考試資料生成工具$(NC)"
	@echo ""
	@echo "可用指令："
	@echo "  make              - 生成期中考考卷 PDF（含公式表）"
	@echo "  make exam         - 生成期中考考卷 PDF（含公式表）"
	@echo "  make answer       - 生成期中考答案卷 PDF"
	@echo "  make solution     - 生成期中考詳解 PDF"
	@echo "  make formula      - 生成期中考公式表 PDF（獨立檔案）"
	@echo "  make clean        - 清除所有 PDF 檔案"
	@echo "  make rebuild      - 重新生成考卷 PDF"
	@echo "  make open         - 開啟考卷 PDF"
	@echo "  make open-formula - 開啟公式表 PDF"
	@echo "  make check        - 檢查必要套件是否已安裝"
	@echo "  make help         - 顯示此幫助訊息"
