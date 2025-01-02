# mdcx

Convert Markdown files to professional documents (PDF and Word)

## Requirements

1. Install pandoc:
   ```bash
   brew install pandoc
   ```

2. For PDF conversion, install WeasyPrint:
   ```bash
   brew install weasyprint
   ```

## Usage

Basic usage:
```bash
# Convert to PDF
mdcx pdf input.md output.pdf

# Convert to Word document
mdcx docx input.md output.docx
```

### PDF Conversion

Convert Markdown to PDF with custom Google Fonts:

```bash
# Default style (EB Garamond headlines, Open Sans body)
mdcx pdf input.md output.pdf

# Custom fonts
mdcx pdf -d "Playfair+Display" -b "Source+Serif+Pro" input.md output.pdf

# Keep original .md links
mdcx pdf -n input.md output.pdf
```

Options:
- `-d, --headline FONT` - Set headline font (default: EB+Garamond)
- `-b, --body FONT` - Set body font (default: Open+Sans)
- `-n, --no-links` - Keep .md links instead of converting to .pdf

### Word Conversion

Convert Markdown to Word documents with predefined styles:

```bash
# Default modern style
mdcx docx input.md output.docx

# Academic style
mdcx docx -s academic input.md output.docx
```

Options:
- `-s, --style STYLE` - Set document style (modern, academic, minimal)

### Font Combinations for PDF

#### Classic combinations:
- Playfair Display + Source Serif Pro (Elegant, traditional)
- Merriweather + Source Sans Pro (Professional, clean)
- Lora + Open Sans (Modern classic)

#### Modern combinations:
- Montserrat + Open Sans (Modern and clean)
- Raleway + Roboto (Contemporary, tech-friendly)
- Work Sans + Inter (Minimalist, great readability)

#### Academic/formal:
- EB Garamond + Open Sans (Classic headlines, modern body - Default)
- Cormorant + EB Garamond (Scholarly, traditional)
- Spectral + IBM Plex Serif (Technical, precise)

## Features

- Convert Markdown to PDF or DOCX
- Beautiful typography with Google Fonts (PDF)
- Code syntax highlighting
- Professional document styles
- Automatic table of contents (DOCX)
- Link conversion (.md → .pdf/.docx)
- Clean temporary file handling

## Examples

Convert a single file:
```bash
mdcx pdf document.md document.pdf
mdcx docx document.md document.docx
```

Convert multiple files:
```bash
for f in *.md; do
    mdcx pdf "$f" "${f%.md}.pdf"
    mdcx docx "$f" "${f%.md}.docx"
done
