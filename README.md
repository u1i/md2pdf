# PDF Generation from Markdown with Custom Fonts

This tool allows you to convert Markdown files to beautifully styled PDFs with custom fonts.

## Requirements

1. Install pandoc:

   ```bash
   brew install pandoc
   ```

2. Install WeasyPrint:

   ```bash
   brew install weasyprint
   ```

The following files are needed:

- `md2pdf.sh` - The main conversion script

The script will automatically generate these temporary files as needed:

- `default.html5` - HTML template for PDF generation
- `markdown.css` - CSS styling for the PDF
- `fix-links.lua` - Lua filter for converting .md links to .pdf

## Usage

Basic usage:

```bash
./md2pdf.sh input.md output.pdf
```

With custom fonts:

```bash
./md2pdf.sh -d "EB+Garamond" -b "Open+Sans" input.md output.pdf
```

Options:

- `-d, --headline FONT` - Set headline font (default: EB+Garamond)
- `-b, --body FONT` - Set body font (default: Open+Sans)
- `-n, --no-links` - Keep .md links instead of converting to .pdf
- `-h, --help` - Show help with font combinations

## Font Combinations

The script includes several curated font combinations:

### Classic combinations:

- Playfair Display + Source Serif Pro (Elegant, traditional)
- Merriweather + Source Sans Pro (Professional, clean)
- Lora + Open Sans (Modern classic)

### Modern combinations:

- Montserrat + Open Sans (Modern and clean)
- Raleway + Roboto (Contemporary, tech-friendly)
- Work Sans + Inter (Minimalist, great readability)

### Academic/formal:

- EB Garamond + Open Sans (Classic headlines, modern body - Default)
- Cormorant + EB Garamond (Scholarly, traditional)
- Spectral + IBM Plex Serif (Technical, precise)

## Features

- Uses Google Fonts for typography
- Automatically converts .md links to .pdf links
- Extracts title from first H1 heading
- Cleans up temporary files after conversion
- Supports custom font combinations
- Proper margin settings
