# About this documentation
Parts of the documentation in this use templates, if markdown file is generated from a template a notice should be present at the bottom of the file.

This automatic generation is used to prevent documentation getting out of sync when the same information is needed in multiple places, an example could be that the repo's readme.md file should be identical to the "Home" page in the documentation, this is achived by using a template for the readme.md importing the "Home" document

## How to add to this documentation
### Create new section
First create a directory for the section, and a jinja template file
```bash
# Make directory and empty jinja file
mkdir -p docs/example
touch docs/example/example.jinja

# All files should include footer containing warning not to edit md files directly
echo '{{ '{% include \"docs/footer.section\" %}' }}' >> docs/example/example.jinja
```
This page should be added to the nav section of mkdocs.yaml, see the file or mkdocs documentation for how to do this
### Add page
Create a new file inside the directory you want to add to.
The file should follow the 'relevant_name.section' naming scheme.
Treat this file as a markdown file, and add the content you want


Once you are ready to include it in the documentation add a line to the directorys .jinja file, the line should look something like below
```
{{ '{% include \"example/world_domination.section\" %}' }}
```
Note, this should always be placed above the footer inclusion

While there aren't many restrictions on the content in a section, it is expected that each section starts with an H1 header

## Documentation deployment
Deployment to github pages is not automatic, in order to deploy, follow this process
```bash
# The following commands are all from the root of the project

# Build documentation
./build_docs.sh 

# Source venv
source .venv/bin/activate

# Run locally to validate changes before deploying
mkdocs serve

# Use mkdocs github pages feature to deploy
mkdocs gh-deploy
```