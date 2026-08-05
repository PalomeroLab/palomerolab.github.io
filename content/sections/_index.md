---
title: "Sections"
build:
  render: never
  list: never
cascade:
  build:
    render: never
    list: never
---

The files in this directory are fragments, not pages. A partial pulls each one
in with `site.GetPage`. The cascade above keeps every fragment off the site, so
a new fragment needs no front matter of its own.
