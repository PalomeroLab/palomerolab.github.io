---
title: "People"
build:
  render: never
cascade:
  build:
    render: never
---

Each file in this directory is a profile file for one team member. A
profile file is an alternative to a member entry in data/team.yaml. Each
profile file has front matter for the fields that it uses.

# required fields: name, group
# The group value must match a group name in data/team.yaml. The card
# appears in that group, together with the yaml members, in the same
# sort order.
# optional fields: suffix, photo, joined, focus, fun_fact
# optional fields, each one adds one icon link to the card: orcid, github, x, email, phone, cv, website
# The fields photo, orcid, github, and cv follow the same rules as in data/team.yaml.
#
# The body starts with a heading of level 1. This heading is a label,
# for example the first name of the person. It does not appear on the
# page.
# The text after the level 1 heading, up to the first heading of level
# 2, is the card text.
# A heading of level 2 marks the start of a longer text. This text
# appears behind a hidden dropdown arrow on the card. If the profile
# has no long text yet, omit the level 2 heading and the dropdown
# arrow. The text of the level 2 heading is a marker only. It does not
# appear on the page.
