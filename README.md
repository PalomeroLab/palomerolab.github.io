# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

This site is built with [Hugo](https://gohugo.io/) and deployed to GitHub Pages with GitHub Actions.

## Local development

1. Install Hugo (extended version recommended).
2. Run:

```bash
hugo server
```

3. Open `http://localhost:1313`.

## Build

```bash
hugo --gc --minify
```

Generated output is written to `public/`.

## Repository structure

```console
.
├── .github/workflows/hugo.yml   # GitHub Pages build/deploy workflow
├── hugo.toml                    # Hugo configuration
├── layouts/index.html           # Homepage template
├── static/CNAME                 # Custom domain for Pages
├── static/people.json           # Lab member data
└── static/assets/               # CSS, JS, bios, images, favicon
```

## Content updates

- Lab members: edit `static/people.json`
- Bios markdown: edit files in `static/assets/bios/`
- Photos: add/update files in `static/assets/photos/`

## Deployment

- Pushes to `main` trigger `.github/workflows/hugo.yml`.
- The workflow builds the site with Hugo and deploys `public/` to GitHub Pages.
