import os
from jinja2 import Template, Environment, FileSystemLoader

def get_files_recursive(path='.'):
    o = []
    for entry in os.listdir(path):
        full_path = os.path.join(path, entry)
        if os.path.isdir(full_path):
            o += get_files_recursive(full_path)
        else:
            o.append(full_path)
    return o

def build_document(filename):
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