#!/bin/bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python3 tools/jinja_docs.py 
mkdocs build