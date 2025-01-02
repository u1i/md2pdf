# md2pdf and md2docx (v1)

Original version of the markdown converters, with separate scripts for PDF and Word output.

## PDF Conversion

```bash
./md2pdf.sh input.md output.pdf
```

With custom fonts:
```bash
HEADLINE_FONT="Playfair+Display" BODY_FONT="Source+Serif+Pro" ./md2pdf.sh input.md output.pdf
```

## Word Conversion

```bash
./md2docx.sh input.md output.docx
```

With custom style:
```bash
./md2docx.sh -s academic input.md output.docx
```

See the new version in the root directory for the improved unified command `mdcx` that combines both functionalities.
