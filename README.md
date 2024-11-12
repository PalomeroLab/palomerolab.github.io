# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

The lab website is built using [this template](https://github.com/StartBootstrap/startbootstrap-scrolling-nav).

## Table of Contents

- [Template](#template)
- [File Structure](#file-structure)
- [Maintenance](#maintenance)
  - [Updating the "Recent Publications" Section](#updating-the-recent-publications-section)
  - [Updating Lab Members](#updating-lab-members)
  - [Uploading Photos](#uploading-photos)
  - [Dynamic Content Generation](#dynamic-content-generation)
- [Domain Management](#domain-management)
- [Tips and Troubleshooting](#tips-and-troubleshooting)
- [Additional Resources](#additional-resources)
- [TODO](#todo)

## File Structure

```console
.
├── CNAME                       # Contains the custom domain name
├── README.md                   # Documentation for the repository
├── assets/
│   ├── CU_logo_bg-dark.png     # Columbia University logo (footer)
│   ├── bios                    # Folder containing md files
│   │   ├── about.md            # About the lab
│   │   └── [lab member bios]
│   ├── banner.jpg              # The main banner image
│   ├── css
│   │   └── my-styles.css       # Custom styles (add or override)
│   ├── favicon.png             # Custom web icon
│   ├── js
│   │   ├── injectMarkdown.js   # Script for rendering Markdown content
│   │   ├── people.js           # Script for rendering lab members
│   │   └── publications.js     # Script for fetching publications
│   └── photos/
│       └── [lab member photos]
├── index.html                  # Main HTML file
├── prettier.sh                 # Script to automatically format files
└── people.json                 # Text file containing lab member data
```

## Maintenance

You should not need to modify the HTML or CSS files directly.
The website is designed to be easy to update without needing to know HTML or
CSS. Most content is stored in Markdown files and JSON, which are human-readable

### Dynamic Content Generation

The website uses JavaScript to dynamically generate content:

- `injectMarkdown.js`: Injects content from Markdown files into named sections
- `people.js`: Fetches and renders the lab members from `people.json`
- `publications.js`: Fetches and renders recent publications from PubMed

### Markdown Content

Content for the "About" section and lab member bios is stored in Markdown files.
These files are located in the `assets/bios/` directory. For more information on
markdown syntax, refer to the [Markdown Guide](https://www.markdownguide.org/basic-syntax/)
and the [GitHub Markdown Guide](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

### Updating the "Recent Publications" Section"

You don't need to manually update the "Recent Publications" section.
The website automatically fetches the latest publications from PubMed using the
[PubMed API](https://www.ncbi.nlm.nih.gov/home/develop/api/).

### Updating Lab Members

To update lab members, edit the `people.json` file. This is a JSON document
(JavaScript Object Notation) that structures data in a human-readable format.

Structure of `people.json`:

- The file contains objects for different categories (e.g., "Postdoctoral Fellows", "Students")
- Each category is an array of person objects
- Each person object has properties like "name", "photo", "description", and optionally "website"

To add, remove, or modify lab members:

1. Navigate to `people.json` in the GitHub repository
2. Click the edit (pencil) icon
3. Make your changes, following the existing structure
4. Commit your changes with a descriptive message

Example of adding a new lab member:

```json
"Research Staff": [
  {
    "name": "New Member, Ph.D.",
    "photo": "assets/photos/NewMember.jpg",
    "description": "Dr. New Member is a researcher working on XYZ in the Palomero Lab",
    "website": "https://example.com"
  },
  // ... existing members ...
]
```

### Uploading Photos

To add new lab member photos:

1. Go to the `assets/photos/` directory in the GitHub repository
2. Click "Add file" > "Upload files"
3. Select and upload the new photo(s)
4. Commit the changes
5. Update the corresponding entry in `people.json` with the correct file path

## Domain Management

The website domain (palomerolab.org) is registered through [Porkbun](https://porkbun.com/).
The website is hosted for free on GitHub Pages, with only the domain name requiring annual renewal.

### Setting Up Custom Domains on GitHub Pages

For detailed instructions on setting up custom domains with GitHub Pages,
including A records configuration, refer to the
[GitHub Pages documentation](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site).

#### CNAME File

The `CNAME` file in the repository root contains just the domain name
(palomerolab.org). The file is used to map the custom domain to the GitHub Pages
site.

### Subdomains and Project Pages

Other repositories with GitHub Pages enabled are accessible under palomerolab.org.
For example, a repository named `project` would be accessible at `palomerolab.org/project`.

## Tips and Troubleshooting

- Use the GitHub web interface for simple text edits to minimize the risk of errors

If you encounter issues:

1. Check that all JSON in `people.json` is valid (no missing commas, brackets, etc.)
2. Ensure all file paths in `people.json` are correct
3. Verify that new photos are in the correct directory and format
4. If dynamic content isn't loading, check the browser console for JavaScript errors

For more complex issues or if you're unsure about making changes, create an
issue in the repository or ask for help.

## Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Markdown Syntax Guide](https://www.markdownguide.org/basic-syntax/)
- [JSON Syntax Guide](https://www.json.org/json-en.html)

## TODO

- [ ] Automatically format changes with `prettier`
- [ ] Implement a GitHub Action to validate JSON syntax on every commit
- [ ] Prevent accidental deletion of `people.json` or `assets/photos/`
- [ ] Create a web-based form for editing `people.json` to avoid syntax errors
- [ ] Add a script to automatically resize and optimize uploaded photos
- [ ] Implement a staging environment for testing changes before they go live
- [ ] Add a script to automatically update copyright year in the footer
