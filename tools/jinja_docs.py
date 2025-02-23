#!/usr/bin/python3
import os
from jinja2 import Environment, FileSystemLoader

def get_files_recursive(path='.'):
    """
    get all files in 'path' including files in subdirectories
    """
    o = []
    for entry in os.listdir(path):
        full_path = os.path.join(path, entry)
        if os.path.isdir(full_path):
            o += get_files_recursive(full_path)
        else:
            o.append(full_path)
    return o

def build_document(filename):
    """
    Build jinja2 templates into markdown
    The output file will be the same as the template just with .jinja replaced with .md
    So docs/example/world_domination.jinja would become docs/example/world_domination.md
    """
    ofn = file[:-6] + ".md"
    print("="*5, f"Building {ofn}", "="*5)

    with open(filename) as f1:
        doc = Environment(loader=FileSystemLoader(".")).from_string(f1.read())
        with open(ofn, "w") as f2:
            f2.write(doc.render())


if __name__ == "__main__":
    files = get_files_recursive()
    for file in files:
        if ".jinja" in file[-6:]:
            build_document(file)