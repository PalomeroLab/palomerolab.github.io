# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

This site is built with [Hugo](https://gohugo.io/) and deployed to GitHub Pages with GitHub Actions.

## Local development

1. Install Hugo, extended version 0.158.0 or newer.
2. Install Prettier: `npm install -g prettier`.
3. Run `make dev`.
4. Open `http://localhost:1313`.

## Make targets

Run `make` to list the targets and the current settings.

| Target       | Action                                   |
| ------------ | ---------------------------------------- |
| `make dev`   | Serve locally at `http://localhost:1313` |
| `make build` | Build into `public/`                     |
| `make clean` | Remove `public/`                         |
| `make fmt`   | Format with Prettier                     |
| `make test`  | Build and serve on the lab server        |

`make dev` and `make build` stop with an install link if Hugo is missing. `make fmt` does the same for
Prettier.

### Testing on the lab server

`make test` runs `deploy` then `serve`:

1. `deploy` builds your branch on the server, from the server's own git checkout of `origin`.
2. `serve` starts a web server on port 8000. Open `http://156.145.233.38:8000/`.
3. Press `Ctrl-C` to stop it.

The server builds from `origin`, so commit and push first. `make deploy` stops if your branch is
unpushed or if it differs from `origin`. It warns if you have uncommitted changes, because those
changes are not deployed.

`BRANCH` defaults to the branch you are on. To build a different one, run
`make test BRANCH=some-branch`.

## Repository structure

```console
.
├── .github/workflows/hugo.yml   # GitHub Pages build/deploy workflow
├── .prettierrc                  # Prettier config (printWidth 128)
├── Makefile                     # Build, format, and lab-server targets
├── hugo.toml                    # Hugo configuration
├── content/
│   ├── about.md                 # Lab description, "About" section
│   └── teresa.md                # Teresa's bio, "People" section
├── data/team.yaml               # Lab member roster, grouped by role
├── layouts/
│   ├── index.html               # Homepage skeleton, calls the partials below
│   └── partials/                # One file per homepage section
│       ├── navbar.html
│       ├── banner.html
│       ├── about.html           # Renders content/about.md
│       ├── team.html            # Renders content/teresa.md + data/team.yaml
│       ├── publications.html
│       ├── contact.html
│       └── footer.html
├── static/CNAME                 # Custom domain for Pages
└── static/assets/               # CSS, photos, favicon
```

## Content updates

- **Lab description**: edit `content/about.md`. Plain markdown, no front matter fields to touch.
- **Teresa's bio**: edit `content/teresa.md`. Plain markdown.
- **Lab members** (postdocs, students, staff, past members): edit `data/team.yaml`.
  - Each entry needs a `group` (section heading) and a list of `members`.
  - Each member needs `name`, `photo` (path under `static/`), and `description`.
  - `website` is optional; adds a link icon to the card.
  - Add a new group by adding a new `- group: ...` block. Add a member by adding an entry under an
    existing group's `members` list.
- **Photos**: add files to `static/assets/photos/`, then reference the path in `data/team.yaml`
  (for team members) or directly in `layouts/partials/team.html` (for Teresa's photo).

- **Banner tagline, phone, address**: edit `[params]` in `hugo.toml`.

None of the above require editing HTML or Go templates. Run `make fmt` before you commit.

## Deployment

- Pushes to `main` and pull requests against `main` trigger `.github/workflows/hugo.yml`.
- The workflow builds the site with Hugo on every run. It deploys `public/` to GitHub Pages only on `main`.
