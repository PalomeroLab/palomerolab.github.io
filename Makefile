# Palomero Lab site.
# Production is GitHub Pages, built by .github/workflows/hugo.yml on push to main.

PORT := 1313

# make sync copies the built site here.
DESKTOP := /Users/rdn/Desktop/Website🕸️

# make deploy-on-lab-server builds with this address, then copies the result to
# the Apache directory on the lab server. The server runs no Hugo.
LAB_HOST := palomerolab-server
LAB_URL := http://156.145.233.38/
LAB_DIR := /var/www/html

.DEFAULT_GOAL := help
.PHONY: help dev build clean fmt sync deploy-on-lab-server check-hugo check-prettier

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

sync: build  ## Copy the built site to the Desktop folder
	rsync -a public/ "$(DESKTOP)/"

deploy-on-lab-server: check-hugo  ## Build here, copy to the lab server at http://156.145.233.38/
	hugo --gc --minify --baseURL $(LAB_URL)
	rsync -a --delete --exclude CNAME public/ $(LAB_HOST):$(LAB_DIR)/
	@echo 'Done. Rebuild with make build before you push, because public/ now carries the lab address.'

check-hugo:
	@command -v hugo >/dev/null || { echo 'hugo is not installed: https://gohugo.io/installation/'; exit 1; }

check-prettier:
	@command -v prettier >/dev/null || { echo 'prettier is not installed: npm install -g prettier'; exit 1; }
