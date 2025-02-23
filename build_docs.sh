#!/bin/bash

if [ ! -d "assets/cinder" ] 
then
    cd assets
    wget https://github.com/chrissimpkins/cinder/archive/v1.2.0.zip
    unzip v1.2.0
    mv cinder-1.2.0/cinder/ .
    rm -rf v1.2.0.zip
    rm -rf cinder-1.2.0
    cd ..
fi

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python3 tools/jinja_docs.py 
mkdocs build