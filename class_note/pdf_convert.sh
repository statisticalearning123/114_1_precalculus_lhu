#!/bin/bash

# PDF 轉換腳本
# 龍華科技大學 - 基礎數學教學筆記轉換工具

# 設定變數
PDF_DIR="pdf_output"
TEMPLATE="template.tex"
DRAFT_DIR="draft"

# 顏色設定
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 顯示幫助訊息
show_help() {
    echo -e "${BLUE}龍華科技大學 - 基礎數學筆記 PDF 轉換工具${NC}"
    echo ""
    echo "使用方式："
    echo "  ./pdf_convert.sh [選項]"
    echo ""
    echo "選項："
    echo "  all              生成所有筆記的 PDF（預設）"
    echo "  2025-10-02       生成特定日期的 PDF"
    echo "  clean            清除所有 PDF 檔案"
    echo "  rebuild          重新生成所有 PDF"
    echo "  check            檢查必要套件是否已安裝"
    echo "  install          安裝必要套件（macOS）"
    echo "  open             開啟 PDF 輸出資料夾"
    echo "  list             列出所有可轉換的檔案"
    echo "  stats            顯示統計資訊"
    echo "  help             顯示此幫助訊息"
    echo ""
    echo -e "${GREEN}範例：${NC}"
    echo "  ./pdf_convert.sh                  # 生成所有 PDF"
    echo "  ./pdf_convert.sh 2025-10-02       # 只生成 2025-10-02.pdf"
    echo "  ./pdf_convert.sh rebuild          # 重新生成所有 PDF"
}

# 檢查必要套件
check_dependencies() {
    echo "檢查必要套件..."

    if ! command -v pandoc &> /dev/null; then
        echo -e "${RED}❌ 缺少 pandoc，請執行: brew install pandoc${NC}"
        return 1
    fi

    if ! command -v xelatex &> /dev/null; then
        echo -e "${RED}❌ 缺少 xelatex，請執行: brew install --cask mactex${NC}"
        return 1
    fi

    echo -e "${GREEN}✓ 所有必要套件已安裝${NC}"
    return 0
}

# 安裝必要套件
install_dependencies() {
    echo "安裝必要套件..."

    if ! command -v brew &> /dev/null; then
        echo -e "${RED}❌ 請先安裝 Homebrew: https://brew.sh${NC}"
        return 1
    fi

    echo "安裝 pandoc..."
    brew install pandoc

    echo -e "${BLUE}正在安裝 MacTeX（這可能需要較長時間）...${NC}"
    brew install --cask mactex

    echo -e "${GREEN}✓ 安裝完成！請重新啟動終端機${NC}"
}

# 建立輸出資料夾
create_output_dir() {
    if [ ! -d "$PDF_DIR" ]; then
        mkdir -p "$PDF_DIR"
        echo -e "${GREEN}✓ 建立輸出資料夾: $PDF_DIR${NC}"
    fi
}

# 轉換單個 Markdown 到 PDF
convert_md_to_pdf() {
    local md_file="$1"
    local basename=$(basename "$md_file" .md)
    local pdf_file="$PDF_DIR/${basename}.pdf"

    # 從檔名提取日期（格式：筆記_YYYY-MM-DD_*）
    local class_date=""
    if [[ "$basename" =~ 筆記_([0-9]{4}-[0-9]{2}-[0-9]{2})_ ]]; then
        class_date="${BASH_REMATCH[1]}"
    fi

    echo -e "${BLUE}正在轉換: $md_file → $pdf_file${NC}"
    if [ -n "$class_date" ]; then
        echo -e "${BLUE}上課日期: $class_date${NC}"
    fi

    # 建立 pandoc 命令
    local pandoc_cmd="pandoc \"$md_file\" \
        --pdf-engine=xelatex \
        --template=\"$TEMPLATE\" \
        -V CJKmainfont=\"PingFang TC\" \
        -V mainfont=\"PingFang TC\" \
        -V geometry:margin=2.5cm \
        -V documentclass=article \
        -V fontsize=12pt \
        -V colorlinks=true \
        -V linkcolor=blue \
        -V urlcolor=blue"

    # 如果有提取到日期，加入 date 參數
    if [ -n "$class_date" ]; then
        pandoc_cmd="$pandoc_cmd -V date=\"$class_date\""
    fi

    pandoc_cmd="$pandoc_cmd -o \"$pdf_file\" 2>&1 | grep -v \"Missing character\""

    # 執行轉換
    eval $pandoc_cmd

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ 完成: $pdf_file${NC}"
        return 0
    else
        echo -e "${RED}❌ 轉換失敗: $md_file${NC}"
        return 1
    fi
}

# 生成所有 PDF
convert_all() {
    create_output_dir

    # 找尋所有 markdown 檔案
    local md_files=()

    # 在當前目錄找 (格式：筆記_YYYY-MM-DD_*.md)
    if ls 筆記_*.md 2>/dev/null; then
        md_files+=($(ls 筆記_*.md 2>/dev/null))
    fi

    # 在 draft 目錄找
    if [ -d "$DRAFT_DIR" ]; then
        if ls $DRAFT_DIR/筆記_*.md 2>/dev/null; then
            md_files+=($(ls $DRAFT_DIR/筆記_*.md 2>/dev/null))
        fi
    fi

    if [ ${#md_files[@]} -eq 0 ]; then
        echo -e "${YELLOW}找不到任何筆記檔案（格式：筆記_YYYY-MM-DD_*.md）${NC}"
        return 1
    fi

    local success=0
    local failed=0

    for md_file in "${md_files[@]}"; do
        if convert_md_to_pdf "$md_file"; then
            ((success++))
        else
            ((failed++))
        fi
    done

    echo ""
    echo -e "${GREEN}✓ 所有 PDF 已生成完畢！${NC}"
    echo -e "${BLUE}成功: $success 個，失敗: $failed 個${NC}"
    echo -e "${BLUE}輸出位置: $PDF_DIR/${NC}"
}

# 生成特定日期的 PDF
convert_single() {
    local date="$1"
    local md_file=""

    # 先在當前目錄找
    if ls 筆記_${date}_*.md 2>/dev/null | head -n 1 > /dev/null; then
        md_file=$(ls 筆記_${date}_*.md 2>/dev/null | head -n 1)
    # 再到 draft 目錄找
    elif [ -d "$DRAFT_DIR" ] && ls $DRAFT_DIR/筆記_${date}_*.md 2>/dev/null | head -n 1 > /dev/null; then
        md_file=$(ls $DRAFT_DIR/筆記_${date}_*.md 2>/dev/null | head -n 1)
    fi

    if [ -z "$md_file" ]; then
        echo -e "${RED}❌ 找不到檔案: 筆記_${date}_*.md${NC}"
        echo -e "${YELLOW}提示：請確認檔案格式為 筆記_YYYY-MM-DD_*.md${NC}"
        return 1
    fi

    create_output_dir
    convert_md_to_pdf "$md_file"
}

# 清除所有 PDF
clean_pdfs() {
    if [ -d "$PDF_DIR" ]; then
        rm -rf "$PDF_DIR"
        echo -e "${GREEN}✓ 已清除所有 PDF 檔案${NC}"
    else
        echo -e "${YELLOW}PDF 資料夾不存在${NC}"
    fi
}

# 重新生成所有 PDF
rebuild_all() {
    clean_pdfs
    convert_all
}

# 開啟 PDF 資料夾
open_output_dir() {
    if [ -d "$PDF_DIR" ]; then
        open "$PDF_DIR"
    else
        echo -e "${BLUE}PDF 資料夾不存在，請先執行: ./pdf_convert.sh${NC}"
    fi
}

# 列出所有可轉換的檔案
list_files() {
    local md_files=()

    if ls 筆記_*.md 2>/dev/null; then
        md_files+=($(ls 筆記_*.md 2>/dev/null))
    fi

    if [ -d "$DRAFT_DIR" ]; then
        if ls $DRAFT_DIR/筆記_*.md 2>/dev/null; then
            md_files+=($(ls $DRAFT_DIR/筆記_*.md 2>/dev/null))
        fi
    fi

    echo -e "${BLUE}可轉換的 Markdown 檔案：${NC}"

    if [ ${#md_files[@]} -eq 0 ]; then
        echo "  （無）"
    else
        for file in "${md_files[@]}"; do
            echo "  - $file"
        done
    fi
}

# 顯示統計資訊
show_stats() {
    local md_count=0
    local pdf_count=0

    if ls 筆記_*.md 2>/dev/null | wc -l > /dev/null; then
        md_count=$((md_count + $(ls 筆記_*.md 2>/dev/null | wc -l | tr -d ' ')))
    fi

    if [ -d "$DRAFT_DIR" ]; then
        if ls $DRAFT_DIR/筆記_*.md 2>/dev/null | wc -l > /dev/null; then
            md_count=$((md_count + $(ls $DRAFT_DIR/筆記_*.md 2>/dev/null | wc -l | tr -d ' ')))
        fi
    fi

    if [ -d "$PDF_DIR" ]; then
        pdf_count=$(ls "$PDF_DIR"/*.pdf 2>/dev/null | wc -l | tr -d ' ')
    fi

    echo -e "${BLUE}筆記統計：${NC}"
    echo "  Markdown 檔案數: $md_count"
    echo "  已生成 PDF 數: $pdf_count"

    if [ -d "$PDF_DIR" ] && [ $pdf_count -gt 0 ]; then
        echo ""
        echo -e "${BLUE}PDF 檔案大小：${NC}"
        ls -lh "$PDF_DIR"/*.pdf 2>/dev/null | awk '{print "  " $9 ": " $5}'
    fi
}

# 主程式
main() {
    # 如果沒有參數，預設執行 all
    if [ $# -eq 0 ]; then
        convert_all
        exit 0
    fi

    # 處理命令
    case "$1" in
        all)
            convert_all
            ;;
        clean)
            clean_pdfs
            ;;
        rebuild)
            rebuild_all
            ;;
        check)
            check_dependencies
            ;;
        install)
            install_dependencies
            ;;
        open)
            open_output_dir
            ;;
        list)
            list_files
            ;;
        stats)
            show_stats
            ;;
        help|--help|-h)
            show_help
            ;;
        [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
            # 日期格式，當作日期處理
            convert_single "$1"
            ;;
        *)
            echo -e "${RED}未知的命令: $1${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 執行主程式
main "$@"
