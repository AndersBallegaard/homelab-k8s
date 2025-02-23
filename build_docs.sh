#!/bin/bash

# Delete old site data
rm -rf site

# Create and activate python venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Build all pages that need it
python3 tools/jinja_docs.py 

# Build static mkdocs
mkdocs build