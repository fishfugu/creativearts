.PHONY: help build deploy serve clean

# Default target: show help
help:
	@echo "Available commands:"
	@echo "  make build     - Build the site into the docs/ folder"
	@echo "  make serve     - Serve the site locally at http://127.0.0.1:8000/"
	@echo "  make deploy    - Build and push to GitHub Pages (via docs/)"
	@echo "  make clean     - Remove the generated docs/ directory"

# Build the MkDocs site into the `docs/` folder
build:
	mkdocs build

# Serve the site locally with auto-reload
serve:
	mkdocs serve

# Build and deploy to GitHub
deploy: build
	git add docs/
	git commit -m "Build site into docs folder for GitHub Pages"
	git push

# Clean the output directory
clean:
	rm -rf docs/
