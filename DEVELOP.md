# Development

This site uses [Hugo](https://gohugo.io/). The site has no theme. All templates
live in `layouts/`.

## Requirements

- `hugo` (extended version)
- `prettier`, for `make fmt`
- `ssh` access to `palomerolab-server`, for a preview on the lab network

## Quick start

```bash
make dev      # serve at http://localhost:1313/
make build    # build into public/
make fmt      # format with Prettier
make help     # list all targets
```

## Repository layout

| Path                 | Contents                                              |
| -------------------- | ----------------------------------------------------- |
| `layouts/index.html` | The home page. It calls one partial for each section.  |
| `layouts/partials/`  | One file for each section: banner, about, team, and so on. |
| `content/`           | Prose fragments in Markdown. Templates pull them in.   |
| `data/team.yaml`     | The team roster. Edit this file to change the people.  |
| `static/`            | Files that Hugo copies without a change: photos, CSS.  |
| `hugo.toml`          | Site configuration.                                    |
| `public/`            | Build output. Do not edit. Do not commit.              |

## How to make common changes

### Add or remove a team member

Edit `data/team.yaml`. Each group has a `group` name and a list of `members`.
Each member needs `name`, `photo`, and `description`. The `website` field is
optional. If you add a `website`, the card shows a link icon.

Put the photo in `static/assets/photos/`. The `photo` field must give the path
without the `static/` prefix.

### Change the prose

The files in `content/` are fragments, not pages. Templates read them with
`site.GetPage`. For example, `layouts/partials/team.html` reads
`content/teresa.md`.

Each fragment starts with this front matter:

```yaml
---
build:
  render: never
  list: never
---
```

Keep it. It tells Hugo not to build the fragment into a standalone page. If you
remove it, Hugo builds a page at `/teresa/` and warns that no template matches.

### Add a photo to the Extras section

Put the image in `static/assets/extras/`. Then link it from
`content/extras.md` without the `static/` prefix:

```markdown
![Lab outing, summer 2026](/assets/extras/outing-2026-summer.jpg)
```

### Change the layout

Edit the partial for the section in `layouts/partials/`. To add a section,
write a new partial. Then call it from `layouts/index.html`.

## The lab server

The `make` targets are local only. The server is a separate machine with its
own copy of the site at `~/Public/palomerolab.org`.

The server has two ways to show the site. Both are previews for the lab
network. Neither one publishes the site.

### Live reload on port 1313

Use this while you work. Hugo rebuilds after each change.

```bash
cd ~/Public/palomerolab.org
hugo server --bind 0.0.0.0 --baseURL http://156.145.233.38/
```

The address is http://156.145.233.38:1313/. Press Ctrl-C to stop the server.

`--bind 0.0.0.0` is necessary. Without it, Hugo listens on 127.0.0.1 and no
other machine can reach the site. `--baseURL` fixes the links and the live
reload script, which otherwise point at `localhost`.

### Static copy on port 80

Apache serves `/var/www/html` at http://156.145.233.38/, with no port number.
Use this to show the site to somebody. There is no live reload.

The directory belongs to root. Change the owner one time:

```bash
sudo chown -R palomerolab:palomerolab /var/www/html
```

After that, each build needs no sudo:

```bash
cd ~/Public/palomerolab.org
hugo --gc --minify --baseURL http://156.145.233.38/ --destination /var/www/html
```

Add `--cleanDestinationDir` if you deleted a page and it must disappear.

## Publication

GitHub Actions builds the site and publishes it to GitHub Pages. See
`.github/workflows/hugo.yml`. A push to `main` publishes the site. A pull
request builds the site but does not publish it.

The lab server never publishes the site. It is a preview machine only.

## Known problems

| Problem                  | Fix                                                 |
| ------------------------ | --------------------------------------------------- |
| Edit does not appear     | `hugo server --disableFastRender`                    |
| Port 1313 busy           | `pkill -x hugo`                                      |
| Stale site on port 8000  | `pkill -f http.server`                               |
| ssh command exits 255    | `pkill -x hugo`, not `pkill -f 'hugo server'`        |
| Lab server runs Hugo 0.123 | Templates use `hugo.Data`, which needs 0.156. Upgrade the server |

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
