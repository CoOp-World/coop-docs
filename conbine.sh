#!/bin/bash
# Remove the old file if it exists so we don't duplicate
rm -f combined_documentation.md

# Find all .md files and concatenate them
find . -name "*.md" -print | while read filename; do
    # Add a header with the original file path so NotebookLM can cite the exact file
    echo -e "\n\n# ==========================================" >> combined_documentation.md
    echo "# Source File: $filename" >> combined_documentation.md
    echo -e "# ==========================================\n" >> combined_documentation.md
    
    # Append the file contents
    cat "$filename" >> combined_documentation.md
done

echo "Done! Created combined_documentation.md"
