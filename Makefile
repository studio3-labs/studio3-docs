.PHONY: lint lint-tokens lint-strict build build-strict serve clean install validate help pdfs

# Default target
help:
	@echo "Studio3 Documentation Commands:"
	@echo "  lint        - Run custom markdown linter"
	@echo "  lint-tokens - Run the dead-token guard (\$$SIGNAL / \$$STUDIO) only"
	@echo "  lint-strict - Run MkDocs strict build validation"
	@echo "  validate    - Run every validation check"
	@echo "  build       - Build the documentation with PDFs"
	@echo "  build-strict- Build with strict validation"
	@echo "  pdfs        - Generate PDF guides"
	@echo "  serve       - Serve documentation locally"
	@echo "  clean       - Clean build artifacts"
	@echo "  install     - Install dependencies"

# Custom markdown linter (stdlib only - no virtualenv needed)
lint:
	@echo "🔍 Running custom markdown linter..."
	@python3 lint_markdown_ultra.py docs

# Dead-token guard only: Studio3 has no native token
lint-tokens:
	@echo "🚫 Running dead-token guard..."
	@python3 lint_markdown_ultra.py --token-guard docs

# MkDocs strict validation
lint-strict:
	@echo "🔍 Running MkDocs strict validation..."
	@bash -c "source venv/bin/activate && mkdocs build --strict --quiet"

# Run all validation methods
validate: lint-strict lint-tokens lint
	@echo "✅ All validation checks completed"

# There is no auto-formatter for docs/, and there must not be one. Prettier
# does not understand MkDocs admonitions - it strips the four-space indentation
# from an admonition body and reflows it onto the "!!!" line, which breaks the
# published pages - so docs/ is in .prettierignore and the former `format`,
# `format-check` and `lint-fix` targets are gone. `make lint` reports what needs
# fixing; fix it by hand. See LINTING.md.

# Generate PDF guides
pdfs:
	@echo "📚 Generating PDF guides..."
	@bash -c "source venv/bin/activate && python3 generate_professional_pdfs.py"

# Build documentation
build: pdfs
	@echo "🏗️ Building documentation..."
	@bash -c "source venv/bin/activate && mkdocs build"

# Build with strict validation
build-strict:
	@echo "🏗️ Building documentation with strict validation..."
	@bash -c "source venv/bin/activate && mkdocs build --strict"

# Serve documentation locally
serve:
	@echo "🚀 Starting local server..."
	@bash -c "source venv/bin/activate && mkdocs serve"

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf site/
	@rm -f lint_output.txt
	@rm -f docs/pdf/*.pdf

# Install dependencies
install:
	@echo "📦 Installing Python dependencies..."
	@python3 -m venv venv || true
	@bash -c "source venv/bin/activate && pip install -r requirements.txt"
	@echo "📦 Installing Node dependencies..."
	@npm install