#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Running Markdown formatting tests..."

# Create a temporary copy of the test file
cp test-formatting.md test-formatting.tmp.md

# Run mdformat on the temporary file
mdformat \
    --wrap 80 \
    --number \
    --end-of-line lf \
    test-formatting.tmp.md

# Compare the files
if diff test-formatting.md test-formatting.tmp.md > formatting-diff.txt; then
    echo -e "${GREEN}✓ File already properly formatted${NC}"
else
    echo -e "${RED}× Formatting issues found:${NC}"
    cat formatting-diff.txt
fi

# Clean up
rm test-formatting.tmp.md formatting-diff.txt

echo "Test complete!"
