.PHONY: help setup build deploy serve clean

VENV_NAME?=.venv

# Default target: show help
help:
	@echo "Available commands:"
	@echo "  make setup              - Create venv and install mkdocs & material theme"
	@echo "  make build              - Build the site into the docs/ folder"
	@echo "  make serve              - Serve the site locally at http://127.0.0.1:8000/"
	@echo "  make deploy             - Build and push to GitHub Pages (via docs/)"
	@echo "  make deploy-gh-pages    - Build and push to GitHub Pages (via docs/)"
	@echo "  make clean              - Remove the generated docs/ directory"

# Create venv and install mkdocs & material theme
setup:
	python3 -m venv $(VENV_NAME)
	. $(VENV_NAME)/bin/activate && pip install --upgrade pip
	. $(VENV_NAME)/bin/activate && pip install mkdocs mkdocs-material

# Build the MkDocs site into the `docs/` folder
build:
	. $(VENV_NAME)/bin/activate && mkdocs build

# Serve the site locally with auto-reload
serve:
	. $(VENV_NAME)/bin/activate && mkdocs serve

# Build and deploy to GitHub
deploy: build
	git add docs/
	git commit -m "Build site into docs folder for GitHub Pages"
	git push

# Deploy to GitHub Pages
deploy-gh-pages:
	. $(VENV_NAME)/bin/activate && mkdocs gh-deploy --force
	@echo "Site deployed to GitHub Pages"
	@echo "Visit https://fishfugu.github.io/creativearts to see the site"

# Usage: make deploy-git MSG="Your commit message"
deploy-git:
ifndef MSG
	$(error Commit message not supplied. Use: make deploy-git MSG="your message")
endif
	git commit -a -m "$(MSG)"
	git push
	git status
	@echo "Site deployed to GitHub Pages"
	@echo "Visit https://fishfugu.github.io/creativearts to see the site"

# Clean the output directory
clean:
	rm -rf site $(VENV_NAME)
