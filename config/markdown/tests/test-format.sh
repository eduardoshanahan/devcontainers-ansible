#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Exit on any error
set -e

# Change to script directory
cd "$(dirname "$0")"

echo "Running Markdown formatting tests..."

# Check if mdformat is installed
if ! command -v mdformat &> /dev/null; then
    echo -e "${RED}Error: mdformat is not installed${NC}"
    echo "Please rebuild the devcontainer to install mdformat and its dependencies"
    exit 1
fi

# Create a temporary copy of the test file
cp test-formatting.md test-formatting.tmp.md

# Run mdformat on the temporary file
echo "Running mdformat..."
mdformat \
    --wrap 80 \
    --number \
    --end-of-line lf \
    test-formatting.tmp.md

# Compare the files
if diff test-formatting.md test-formatting.tmp.md > formatting-diff.txt; then
    echo -e "${GREEN}✓ File already properly formatted${NC}"
    rm formatting-diff.txt
    rm test-formatting.tmp.md
    exit 0
else
    echo -e "${RED}× Formatting issues found:${NC}"
    cat formatting-diff.txt
    echo -e "\n${RED}Please fix the formatting issues above${NC}"
    rm formatting-diff.txt
    rm test-formatting.tmp.md
    exit 1
fi

echo "Test complete!"
