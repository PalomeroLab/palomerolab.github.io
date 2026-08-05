# Development

This site uses [Hugo](https://gohugo.io/). The site has no theme. All templates
live in `layouts/`.

## Requirements

- `hugo` (extended version)
- `node` and `npm`, for `make fmt`. The first run installs Prettier locally
- `ssh` access to `palomerolab-server`, for a preview on the lab network
- `rsync`, for `make sync` and `make deploy-on-lab-server`

## Quick start

```bash
make dev      # serve at http://localhost:1313/
make build    # build into public/
make fmt      # format with Prettier. Run this before each commit
make sync     # copy the built site to the Desktop folder
make help     # list all targets
```

## The alumni list

`assets/alumni.csv` holds one row for each alumnus, with these columns:

| Column     | Contents                                                                                                                                  |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `category` | Postdoctoral & PhD Mentees, Clinical Fellows, Graduate & Predoctoral Trainees, Research Technicians, or Undergraduate & Visiting Students |
| `years`    | Years in the Palomero Lab. A trailing dash means still present.                                                                           |
| `name`     | Full name, with the degree suffix as the person uses it.                                                                                  |
| `position` | Current position and institution, outside this lab.                                                                                       |

The Past Members group in the People section ends with a link to the file, at
`/alumni.csv`. `layouts/partials/people.html` publishes it with
`resources.Get`, which is why the file sits in `assets/`.

It cannot go in `data/`. Hugo reads no CSV from that directory. To build a
table from the rows one day, read them with `transform.Unmarshal`:

```go-html-template
{{ $alumni := resources.Get "alumni.csv" | transform.Unmarshal }}
```

Keep the file valid CSV, and keep the comment lines out of it.

## Formatting

Run `make fmt` before each commit. It formats every file with Prettier, see
`.prettierrc`. Nothing else checks the formatting, so the habit is the only
thing that keeps the diffs clean. A commit that mixes a real change with a
reformat of the whole file is hard to read and hard to revert.

Prettier reads the Go templates through `prettier-plugin-go-template`. Without
the plugin it breaks them, so `make fmt` runs Prettier from `node_modules`, not
from `PATH`. The first run installs it.

## Repository layout

| Path                 | Contents                                                  |
| -------------------- | --------------------------------------------------------- |
| `layouts/index.html` | The home page. It calls one partial for each section.     |
| `layouts/partials/`  | One file for each section, named after it: `people.html`. |
| `content/`           | Prose fragments in Markdown. Templates pull them in.      |
| `data/team.yaml`     | The team roster. Edit this file to change the people.     |
| `alumni.csv`         | Alumni, 2005 to now. Hugo ignores it there.               |
| `static/`            | Files that Hugo copies without a change: photos, CSS.     |
| `hugo.toml`          | Site configuration.                                       |
| `public/`            | Build output. Do not edit. Do not commit.                 |

## How the templates find the content

README.md covers the day to day edits: the roster, the prose, the photos. This
section covers what a template does with them.

### The section fragments

The files in `content/sections/` are fragments, not pages. Templates read them
with `site.GetPage`. For example, `layouts/partials/people.html` reads
`content/sections/teresa.md`, because her entry in `data/team.yaml` names it in
a `bio` field.

A fragment needs no front matter. `content/sections/_index.md` carries a
cascade that keeps every file in the directory off the site:

```yaml
cascade:
  build:
    render: never
    list: never
```

A Markdown file that belongs somewhere else, such as `content/research.md`,
builds a page of its own through `layouts/_default/single.html`. The build
warns when a file outside `sections/` carries no title, because that is the
sign of a fragment in the wrong place.

### The team cards

`layouts/partials/people.html` builds every card, including the wide one for
the Principal Investigator, which the `wide` field on a group sets. It looks
for a photo in `assets/photos/` under the member name, in jpg, jpeg, png, and
webp order, and it warns when it finds none. A `photo` field overrides that
guess, with a path under `assets/`.

### The sections and the navbar

The `[[menus.main]]` entries in `hugo.toml` are the list of sections.
`layouts/index.html` renders one `<section>` for each entry whose url starts
with `#`, and the url names the partial: `#people` renders
`layouts/partials/people.html`. Backgrounds alternate by position. An entry
whose url does not start with `#` links to a page of its own, as `/research/`
does, and the navbar puts the home page in front of an anchor when it renders
on such a page.

To add a section, write `layouts/partials/<name>.html`, then add the menu
entry.

### The Extras photos

Put the image in `static/assets/extras/`. Then link it from
`content/sections/extras.md` without the `static/` prefix:

```markdown
![Lab outing, summer 2026](/assets/extras/outing-2026-summer.jpg)
```

## The lab server

Apache on the lab server shows the site at http://156.145.233.38/ for the lab
network. It does not publish the site.

Build here, then copy the result:

```bash
make deploy-on-lab-server
```

The target builds with the lab address, then copies `public/` to
`/var/www/html` on the server. It keeps the `CNAME` file and removes everything
else that the build did not write. The server runs no Hugo, and it needs no
copy of this repository.

The build in `public/` carries the lab address afterward. Run `make build`
before you look at that directory again.

The Apache directory belongs to root. Change the owner one time:

```bash
ssh palomerolab-server 'sudo chown -R palomerolab:palomerolab /var/www/html'
```

## Publication

GitHub Actions builds the site and publishes it to GitHub Pages. See
`.github/workflows/hugo.yml`. A push to `main` publishes the site. A pull
request builds the site but does not publish it.

The lab server never publishes the site. It is a preview machine only.

## Known problems

| Problem                      | Fix                                           |
| ---------------------------- | --------------------------------------------- |
| Edit does not appear         | `hugo server --disableFastRender`             |
| Port 1313 busy               | `pkill -x hugo`                               |
| Stale site on port 8000      | `pkill -f http.server`                        |
| ssh command exits 255        | `pkill -x hugo`, not `pkill -f 'hugo server'` |
| Lab server shows an old site | `make deploy-on-lab-server`                   |

## Useful Hugo commands

```bash
hugo server                       # dev server with live reload, port 1313
hugo server --disableFastRender   # full rebuild after each change
hugo server -D                    # include drafts
hugo --gc --minify                # production build, the same command as CI
hugo list all                     # every page that Hugo builds
hugo config                       # print the resolved configuration
hugo version                      # check the version, the versions differ
```
