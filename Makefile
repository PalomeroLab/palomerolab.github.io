# Palomero Lab site. Authoring targets run locally, deploy/serve run on the lab server.

# ssh alias for 156.145.233.38, see ~/.ssh/config
REMOTE     := palomerolab-server
REMOTE_DIR := website
# branch the server builds, defaults to the branch you are on
BRANCH     ?= $(shell git rev-parse --abbrev-ref HEAD)
# override if hugo is not on the server's non-interactive PATH
HUGO       := hugo
TEST_PORT  := 8000
TEST_URL   := http://156.145.233.38:$(TEST_PORT)/

.DEFAULT_GOAL := help
.PHONY: help dev build clean fmt deploy serve test check-hugo check-prettier check-pushed

help:  ## Show this help
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed 's/:.*## / — /'
	@printf '\nBRANCH=%s  REMOTE=%s  TEST_URL=%s\n' '$(BRANCH)' '$(REMOTE)' '$(TEST_URL)'

dev: check-hugo  ## Serve locally at http://localhost:1313
	hugo server

build: check-hugo  ## Build into public/
	hugo --gc --minify

clean:  ## Remove public/
	rm -rf public

fmt: check-prettier  ## Format with Prettier, see .prettierrc
	prettier --write --ignore-unknown .

deploy: check-pushed  ## On the server: build the current branch
	ssh $(REMOTE) 'cd $(REMOTE_DIR) && git fetch origin $(BRANCH) && git checkout -B $(BRANCH) origin/$(BRANCH) && $(HUGO) --gc --minify --baseURL "$(TEST_URL)"'

serve:  ## On the server: serve public/ at TEST_URL (Ctrl-C to stop)
	ssh -t $(REMOTE) 'cd $(REMOTE_DIR)/public && python3 -m http.server $(TEST_PORT) --bind 0.0.0.0'

test: deploy serve  ## Deploy then serve, so you can test at TEST_URL

check-hugo:
	@command -v hugo >/dev/null || { echo 'hugo is not installed: https://gohugo.io/installation/'; exit 1; }

check-prettier:
	@command -v prettier >/dev/null || { echo 'prettier is not installed: npm install -g prettier'; exit 1; }

check-pushed:
	@git fetch -q origin $(BRANCH) || { echo 'origin has no branch $(BRANCH). Push it first.'; exit 1; }
	@test "$$(git rev-parse $(BRANCH))" = "$$(git rev-parse FETCH_HEAD)" || \
		{ echo '$(BRANCH) differs from origin/$(BRANCH). The server builds from origin, so push first.'; exit 1; }
	@test -z "$$(git status --porcelain)" || echo 'warning: uncommitted changes are not deployed.'
