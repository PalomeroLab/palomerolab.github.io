# Palomero Lab site.
# Production is GitHub Pages, built by .github/workflows/hugo.yml on push to main.

PORT := 1313

.DEFAULT_GOAL := help
.PHONY: help dev build clean fmt check-hugo check-prettier

help:  ## Show this help
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed 's/:.*## / — /'

dev: check-hugo  ## Serve locally with live reload
	hugo server --port $(PORT)

build: check-hugo  ## Build into public/
	hugo --gc --minify

clean:  ## Remove public/
	rm -rf public

fmt: check-prettier  ## Format with Prettier, see .prettierrc
	prettier --write --ignore-unknown .

check-hugo:
	@command -v hugo >/dev/null || { echo 'hugo is not installed: https://gohugo.io/installation/'; exit 1; }

check-prettier:
	@command -v prettier >/dev/null || { echo 'prettier is not installed: npm install -g prettier'; exit 1; }
