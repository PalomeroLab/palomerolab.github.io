# Palomero Lab site. Authoring runs locally, preview runs on the lab server.
# Production is GitHub Pages, built by .github/workflows/hugo.yml on push to main.

# ssh alias for 156.145.233.38, see ~/.ssh/config
REMOTE     := palomerolab-server
REMOTE_DIR := palomerolab.org
REMOTE_IP  := 156.145.233.38
PORT       := 1313
# the paths hugo watches, plus the config
SRC        := layouts content data static hugo.toml

.DEFAULT_GOAL := help
.PHONY: help dev build clean fmt sync sync-dry preview check-hugo check-prettier

help:  ## Show this help
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed 's/:.*## / — /'
	@printf '\nREMOTE=%s:%s  PREVIEW=http://%s:%s/\n' '$(REMOTE)' '$(REMOTE_DIR)' '$(REMOTE_IP)' '$(PORT)'

dev: check-hugo  ## Serve locally at http://localhost:1313
	hugo server

build: check-hugo  ## Build into public/
	hugo --gc --minify

clean:  ## Remove public/
	rm -rf public

fmt: check-prettier  ## Format with Prettier, see .prettierrc
	prettier --write --ignore-unknown .

sync-dry:  ## Show what sync would copy and delete
	rsync -avn --delete $(SRC) $(REMOTE):$(REMOTE_DIR)/

sync:  ## Copy source to the server, no commit or push needed
	rsync -av --delete $(SRC) $(REMOTE):$(REMOTE_DIR)/

preview: sync  ## Sync, then serve from the server on the lab network (Ctrl-C to stop)
	ssh -t $(REMOTE) 'cd $(REMOTE_DIR) && hugo server --bind 0.0.0.0 --baseURL http://$(REMOTE_IP)/'

check-hugo:
	@command -v hugo >/dev/null || { echo 'hugo is not installed: https://gohugo.io/installation/'; exit 1; }

check-prettier:
	@command -v prettier >/dev/null || { echo 'prettier is not installed: npm install -g prettier'; exit 1; }
