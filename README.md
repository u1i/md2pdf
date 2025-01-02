# mdcx

Convert Markdown files to professional documents (PDF and Word)

> ⚠️ Currently only tested and supported on macOS.

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

PDF Options:
- `-d, --headline FONT` - Set headline font (default: EB+Garamond)
- `-b, --body FONT` - Set body font (default: Open+Sans)
- `-n, --no-links` - Keep .md links instead of converting to .pdf

### Word Conversion

Convert Markdown to Word documents:

```bash
mdcx docx input.md output.docx
```

The Word output uses default system fonts and styles for better compatibility. Links are automatically converted from .md to .docx.

Markdown elements are mapped to corresponding Word styles:
- `# Heading` → Heading 1
- `## Heading` → Heading 2
- `### Heading` → Heading 3
- Code blocks → Code style
- Blockquotes → Quote style
- Lists → List styles

This makes the document fully editable in Word, with proper document structure and navigation. Users can:
- Use Word's navigation pane to jump between sections
- Modify all headings of a certain level by changing the style
- Update document formatting using Word's style system

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

- PDF output with customizable Google Fonts
- Word output with system fonts for compatibility
- Code syntax highlighting
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
