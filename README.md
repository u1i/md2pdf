# Markdown Document Converter

Convert Markdown files to beautifully styled PDFs and Word documents.

## Requirements

1. Install pandoc:
   ```bash
   brew install pandoc
   ```

2. For PDF conversion, install WeasyPrint:
   ```bash
   brew install weasyprint
   ```

3. For Word conversion, no additional tools needed (pandoc includes docx support)

## PDF Conversion (md2pdf.sh)

Convert Markdown to PDF with custom Google Fonts:

```bash
./md2pdf.sh input.md output.pdf
```

Options:
- `-d, --headline FONT` - Set headline font (default: EB+Garamond)
- `-b, --body FONT` - Set body font (default: Open+Sans)
- `-n, --no-links` - Keep .md links instead of converting to .pdf
- `-h, --help` - Show help with font combinations

### PDF Font Combinations

The PDF converter includes several curated font combinations:

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

## Word Conversion (md2docx.sh)

Convert Markdown to Word documents with predefined styles:

```bash
./md2docx.sh input.md output.docx
```

Options:
- `-s, --style STYLE` - Set document style (default: modern)
  - Available styles: modern, academic, minimal
- `-h, --help` - Show help message

### Word Document Features

- Automatic table of contents
- Code syntax highlighting
- Consistent styling across documents
- Automatic conversion of .md links to .docx
- Professional typography and spacing

## Features

Both converters support:
- Link conversion (.md → .pdf/.docx)
- Code syntax highlighting
- Tables and lists
- Block quotes
- Automatic title extraction from first H1
- Clean temporary file handling

## Examples

Convert to PDF with custom fonts:
```bash
./md2pdf.sh -d "Playfair+Display" -b "Source+Serif+Pro" input.md output.pdf
```

Convert to Word with academic style:
```bash
./md2docx.sh -s academic input.md output.docx
```

Convert multiple files:
```bash
for f in *.md; do
    ./md2pdf.sh "$f" "${f%.md}.pdf"
    ./md2docx.sh "$f" "${f%.md}.docx"
done
