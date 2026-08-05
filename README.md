# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

The website of the Palomero Lab. It is built with [Hugo](https://gohugo.io/) and
deployed to GitHub Pages by GitHub Actions.

Most changes need no HTML and no Go template. Edit one file, run `make fmt`, and
commit.

## Add or remove a lab member

Edit `data/team.yaml`. Each group has a `group` name and a list of `members`.
The comments at the top of the file list every field.

```yaml
- group: Research Staff
  members:
    - name: Ryan D. Najac
      suffix: BA
      description: Ryan is a very good research technician
      orcid: 0009-0000-6280-5646
      github: rdnajac
```

`name` and `description` are the only fields a member needs. Each of `orcid`,
`github`, `x`, `email`, `phone`, `cv`, and `website` adds an icon link to the
card.

Groups appear in the order of the file. Members sort by name.

## Add a photo

Put the file in `assets/photos/`, named after the member, for example
`assets/photos/Ryan D. Najac.jpg`. The card finds it with no `photo` field.

Photos are 250x250 thumbnails. The card crops whatever shape the file has, so
nothing stretches, but a file smaller than 250px looks soft. The build warns
when a member has no photo.

## Change the text of a section

| Section                | File                           |
| ---------------------- | ------------------------------ |
| About our group        | `content/sections/about.md`    |
| Ongoing Projects       | `content/sections/projects.md` |
| Join Us                | `content/sections/join.md`     |
| Extras                 | `content/sections/extras.md`   |
| Teresa Palomero's bio  | `content/sections/teresa.md`   |
| Research, its own page | `content/research.md`          |

These are plain Markdown. The files in `content/sections/` need no front matter.

## Change the tagline, phone, or address

Edit `[params]` in `hugo.toml`.

## Add a section

Write `layouts/partials/<name>.html`, then add a menu entry in `hugo.toml`:

```toml
[[menus.main]]
  name = "Alumni"
  url = "#alumni"
  weight = 9
```

The entry gives both the navbar link and the section on the page. A `url` that
does not start with `#` links to a page of its own, as `/research/` does.

## Publish

A push to `main` builds the site and deploys it to GitHub Pages. A pull request
builds it without deploying.

To update the preview on the lab network at http://156.145.233.38/:

```bash
make deploy-on-lab-server
```

It builds here and copies the result. The server runs no Hugo.

## Local development

```bash
make dev      # serve at http://localhost:1313/
make build    # build into public/
make fmt      # format with Prettier. Run before each commit
make help     # list every target
```

The first `make fmt` installs Prettier and its Go template plugin with npm.
Prettier breaks the templates without that plugin, so always format through
`make fmt`, never through a Prettier on your `PATH`.

[DEVELOP.md](DEVELOP.md) covers the rest: the repository layout, how the
templates find the content, the lab server, and the known problems.
