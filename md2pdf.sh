#!/bin/bash

# md2pdf.sh - Convert Markdown files to beautifully styled PDF documents
#
# Usage: ./md2pdf.sh [-h] [-b BODY_FONT] [-d HEADLINE_FONT] [-n] input.md output.pdf
#
# Options:
#   -h, --help              Show this help message
#   -b, --body FONT        Body font (default: Open+Sans)
#   -d, --headline FONT    Headline font (default: EB+Garamond)
#   -n, --no-links        Remove all links from the output
#
# Popular Google Font combinations:
#
# Classic combinations:
#   -d Playfair+Display -b Source+Serif+Pro  # Elegant, traditional
#   -d Merriweather -b Source+Sans+Pro       # Professional, clean
#   -d Lora -b Open+Sans                     # Modern classic
#
# Modern combinations:
#   -d Montserrat -b Open+Sans               # Modern and clean
#   -d Raleway -b Roboto                     # Contemporary, tech-friendly
#   -d Work+Sans -b Inter                    # Minimalist, great readability
#
# Academic/formal:
#   -d EB+Garamond -b Open+Sans              # Classic headlines, modern body (Default)
#   -d Cormorant -b EB+Garamond              # Scholarly, traditional
#   -d Spectral -b IBM+Plex+Serif           # Technical, precise
#
# Requirements:
# - pandoc
# - weasyprint
# - Internet connection (for Google Fonts)
#
# Note: Replace spaces in font names with '+'

# Default fonts
HEADLINE_FONT="EB+Garamond"
BODY_FONT="Open+Sans"
CONVERT_LINKS=true

# Show help
show_help() {
    sed -n '/^# Usage:/,/^# Note:/p' "$0" | sed 's/^# //'
    exit 1
}

# Create Lua filter for converting .md links to .pdf
cat > fix-links.lua << 'EOF'
-- Fix-links filter: Convert .md links to .pdf
function Link(el)
    -- Check if link ends with .md
    if el.target:match("%.md$") then
        -- Replace .md with .pdf
        el.target = el.target:gsub("%.md$", ".pdf")
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
        -b|--body)
            BODY_FONT="$2"
            shift 2
            ;;
        -d|--headline)
            HEADLINE_FONT="$2"
            shift 2
            ;;
        -n|--no-links)
            CONVERT_LINKS=false
            shift
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

# Extract the first H1 heading from the markdown file
TITLE=$(grep "^# " "$INPUT_FILE" | head -n 1 | sed 's/^# //')

# If no title found, fallback to filename
if [ -z "$TITLE" ]; then
    TITLE=$(basename "$INPUT_FILE" .md)
fi

# Create temporary HTML template with specified fonts
cat > default.html5 << EOF
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="\$lang\$" xml:lang="\$lang\$"\$if(dir)\$ dir="\$dir\$"\$endif\$>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=${HEADLINE_FONT}:wght@400;700&family=${BODY_FONT}:wght@400;700&display=swap" rel="stylesheet">
  \$for(css)\$
  <link rel="stylesheet" href="\$css\$" />
  \$endfor\$
</head>
<body>
\$body\$
</body>
</html>
EOF

# Create CSS with specified fonts (remove + from font names in CSS)
HEADLINE_FONT_CSS=$(echo $HEADLINE_FONT | tr '+' ' ')
BODY_FONT_CSS=$(echo $BODY_FONT | tr '+' ' ')

cat > markdown.css << EOF
body {
    font-family: '${BODY_FONT_CSS}', system-ui, -apple-system, sans-serif;
    font-size: 10pt;
    line-height: 1.6;
}

h1, h2, h3, h4, h5, h6 {
    font-family: '${HEADLINE_FONT_CSS}', system-ui, -apple-system, sans-serif;
    font-weight: 700;
}

h1 {
    font-size: 24pt;
}

h2 {
    font-size: 16pt;
}

h3 {
    font-size: 12pt;
}

table {
    font-size: 8pt;
    margin-top: 1.5em;
    margin-bottom: 1.5em;
    border-collapse: collapse;
    width: 100%;
}

th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
}

tr:not(:last-child) td {
    padding-bottom: 8px;
}

li {
    line-height: 1.6;
}

code {
    font-family: 'Courier New', monospace;
}
EOF

# Set SSL vars to fix WeasyPrint SSL issues
export OPENSSL_CONF=/dev/null

# Build pandoc command
PANDOC_CMD="pandoc \"$INPUT_FILE\" -o \"$OUTPUT_FILE\" --pdf-engine=weasyprint --css=./markdown.css --metadata title=\"$TITLE\" -V geometry:margin=1in --template=default.html5"

# Add link conversion if enabled
if [ "$CONVERT_LINKS" = true ]; then
    PANDOC_CMD="$PANDOC_CMD --lua-filter=fix-links.lua"
fi

# Convert without showing the title (since it's already in the markdown)
eval $PANDOC_CMD

# Clean up temporary files
rm default.html5 markdown.css fix-links.lua
