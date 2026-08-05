# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

The website of the Palomero Lab, at https://www.palomerolab.org/.

You can make most changes here on GitHub, in the browser. You need no software
on your computer, and you need to write no HTML.

## How to edit a file

1. Open the file in the list below.
2. Click the pencil at the top right of the file.
3. Make the change.
4. Click **Commit changes**, write one line about what you did, and commit.

The site rebuilds itself. Your change appears at https://www.palomerolab.org/
about a minute later. Watch the **Actions** tab for a green check. A red X means
the site did not rebuild, and the change is not live.

## What to edit

| To change                      | Open this file                 |
| ------------------------------ | ------------------------------ |
| Lab members, and their links   | `data/team.yaml`               |
| About our group                | `content/sections/about.md`    |
| Ongoing Projects               | `content/sections/projects.md` |
| Join Us                        | `content/sections/join.md`     |
| Extras, for photos of the lab  | `content/sections/extras.md`   |
| Teresa Palomero's bio          | `content/sections/teresa.md`   |
| The Research page              | `content/research.md`          |
| The alumni list                | `assets/alumni.csv`            |
| Tagline, phone number, address | `hugo.toml`                    |

The `.md` files are Markdown. Write plain text. `**bold**` makes bold, and
`[text](https://example.com)` makes a link.

## How to add a lab member

Open `data/team.yaml` and copy an entry that is already there. Keep the dashes
and the indentation exactly as they are, because the spacing carries the
meaning in this kind of file.

```yaml
- group: Research Staff
  members:
    - name: Ryan D. Najac
      suffix: BA
      description: Ryan is a very good research technician
      orcid: 0009-0000-6280-5646
      github: rdnajac
```

A member needs `name` and `description`. Everything else is optional:

| Field                                                     | What it does                           |
| --------------------------------------------------------- | -------------------------------------- |
| `suffix`                                                  | The degree after the name, such as PhD |
| `orcid`, `github`, `x`, `email`, `phone`, `cv`, `website` | Each one adds an icon link to the card |

To move somebody to Past Members, cut their entry and paste it under that
group. Groups appear in the order of the file, and members sort by name.

## How to add a photo

1. Open the `assets/photos` folder.
2. Click **Add file**, then **Upload files**.
3. Name the file after the member, exactly as the name appears in
   `data/team.yaml`, for example `Ryan D. Najac.jpg`.

The card finds the photo by that name. Nothing else to edit.

A photo should be a square about 250 pixels wide. A larger one still works,
because the card crops it, but it makes the page slower. A much smaller one
looks blurry.

## If something looks wrong

Every change is saved forever, and any change can be undone. Open the
**Commits** list, find the change, and revert it. Nothing you do here can lose
the earlier version of the site.

Ask Ryan if a change does not appear, or if the Actions tab shows a red X.

## For developers

[DEVELOP.md](DEVELOP.md) covers the local setup: Hugo, the make targets, the
formatter, the templates, and the preview server on the lab network.
