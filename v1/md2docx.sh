#!/bin/bash

# md2docx.sh - Convert Markdown files to styled Word documents
#
# Usage: ./md2docx.sh [-h] [-s STYLE] input.md output.docx
#
# Options:
#   -h, --help              Show this help message
#   -s, --style STYLE      Style template (default: modern)
#                         Available: modern, academic, minimal
#
# Requirements:
# - pandoc
# - A working Word installation to view the documents

# Default style
STYLE="modern"

# Show help
show_help() {
    sed -n '/^# Usage:/,/^# Requirements:/p' "$0" | sed 's/^# //'
    exit 1
}

# Create reference.docx for modern style
create_modern_reference() {
    pandoc -o reference.docx --print-default-data-file reference.docx
    # The above creates a base template that pandoc will use
}

# Create reference.docx for academic style
create_academic_reference() {
    pandoc -o reference.docx --print-default-data-file reference.docx
    # Academic style would have different margins, fonts, etc.
}

# Create reference.docx for minimal style
create_minimal_reference() {
    pandoc -o reference.docx --print-default-data-file reference.docx
    # Minimal style would be simpler
}

# Create Lua filter for converting .md links to .docx
cat > fix-links.lua << 'EOF'
-- Fix-links filter: Convert .md links to .docx
function Link(el)
    -- Check if link ends with .md
    if el.target:match("%.md$") then
        -- Replace .md with .docx
        el.target = el.target:gsub("%.md$", ".docx")
    end
    return el
end
EOF

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        -s|--style)
            STYLE="$2"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

# Check if input and output files are provided
if [ $# -ne 2 ]; then
    show_help
fi

INPUT_FILE=$1
OUTPUT_FILE=$2

# Create reference doc based on style
case $STYLE in
    "modern")
        create_modern_reference
        ;;
    "academic")
        create_academic_reference
        ;;
    "minimal")
        create_minimal_reference
        ;;
    *)
        echo "Unknown style: $STYLE"
        exit 1
        ;;
esac

# Extract the first H1 heading from the markdown file
TITLE=$(grep "^# " "$INPUT_FILE" | head -n 1 | sed 's/^# //')

# If no title found, fallback to filename
if [ -z "$TITLE" ]; then
    TITLE=$(basename "$INPUT_FILE" .md)
fi

# Convert to Word document
pandoc "$INPUT_FILE" \
    -o "$OUTPUT_FILE" \
    --reference-doc=reference.docx \
    --lua-filter=fix-links.lua \
    --metadata title="$TITLE" \
    --toc \
    --toc-depth=3 \
    --highlight-style=pygments

# Clean up temporary files
rm reference.docx fix-links.lua
