# Palomero Lab site. Authoring runs locally, preview runs on the lab server.
# Production is GitHub Pages, built by .github/workflows/hugo.yml on push to main.

# ssh alias, see ~/.ssh/config. The host name comes from ssh, not from a copy here.
REMOTE     := palomerolab-server
REMOTE_DIR := palomerolab.org
REMOTE_HOST = $(shell ssh -G $(REMOTE) 2>/dev/null | awk '/^hostname /{print $$2}')
# override if hugo is not on the server's non-interactive PATH
REMOTE_HUGO := hugo
PORT       := 1313
# the paths hugo watches, plus the config
SRC        := layouts content data static hugo.toml

.DEFAULT_GOAL := help
.PHONY: help dev build clean fmt sync sync-dry preview check-hugo check-prettier check-remote

help:  ## Show this help
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed 's/:.*## / — /'
	@printf '\nREMOTE=%s:%s  PREVIEW=http://%s:%s/\n' '$(REMOTE)' '$(REMOTE_DIR)' '$(REMOTE_HOST)' '$(PORT)'

dev: check-hugo  ## Serve locally, see PORT below
	hugo server --port $(PORT)

build: check-hugo  ## Build into public/
	hugo --gc --minify

clean:  ## Remove public/
	rm -rf public

fmt: check-prettier  ## Format with Prettier, see .prettierrc
	prettier --write --ignore-unknown .

sync-dry: check-remote  ## Show what sync would copy and delete
	rsync -avn --delete $(SRC) $(REMOTE):$(REMOTE_DIR)/

sync: check-remote  ## Copy source to the server, no commit or push needed
	rsync -av --delete $(SRC) $(REMOTE):$(REMOTE_DIR)/

preview: sync  ## Sync, then serve from the server on the lab network (Ctrl-C to stop)
	ssh -t $(REMOTE) '$(REMOTE_HUGO) server --source $(REMOTE_DIR) --bind 0.0.0.0 --port $(PORT) --baseURL http://$(REMOTE_HOST)/'

check-hugo:
	@command -v hugo >/dev/null || { echo 'hugo is not installed: https://gohugo.io/installation/'; exit 1; }

check-prettier:
	@command -v prettier >/dev/null || { echo 'prettier is not installed: npm install -g prettier'; exit 1; }

# rsync --delete removes files. Refuse to run against a directory that is not the site.
check-remote:
	@test -n '$(REMOTE_HOST)' || { echo 'ssh does not know host $(REMOTE). Check ~/.ssh/config.'; exit 1; }
	@ssh $(REMOTE) 'test -f $(REMOTE_DIR)/hugo.toml' || \
		{ echo '$(REMOTE):$(REMOTE_DIR) is not a hugo site. Refusing to rsync --delete into it.'; exit 1; }
	@ssh $(REMOTE) 'command -v $(REMOTE_HUGO) >/dev/null' || \
		{ echo '$(REMOTE_HUGO) is not on the PATH of $(REMOTE). Set REMOTE_HUGO to the full path.'; exit 1; }
