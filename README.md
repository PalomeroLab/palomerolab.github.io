# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

The lab website is built using [this template](https://github.com/StartBootstrap/startbootstrap-scrolling-nav).

The initial commit was created by cloning the template repository...

```sh
git clone https://github.com/StartBootstrap/startbootstrap-scrolling-nav.git
```

then building the website using the template's instructions...

```sh
cd startbootstrap-scrolling-nav
npm install
npm run build
```

and finally copying the built files to the root of this repository.

```sh
cp -r dist/* /path/to/palomerolab.org/
```

> [!NOTE]
> You do not need to perform these steps again. This is just for reference.

## File Structure

The original file structure of the template repository is as follows:

```console
dist/
├── assets/
│   └── favicon.ico
├── css/
│   └── styles.css
├── index.html
└── js/
    └── scripts.js

4 directories, 4 files
```

> [!CAUTION]
> Do not modify styles.css or scripts.js directly.

The current file structure of the repository is as follows:

```console
.
├── CNAME
├── README.md
├── assets/
│   ├── Columbia_University_logo_bg-dark.png
│   ├── banner.jpg
│   ├── favicon.png
│   └── photos/
│       └── [team member photos]
├── css/
│   ├── my-styles.css
│   └── styles.css
├── index.html
├── js/
│   ├── people.js
│   ├── publications.js
│   └── scripts.js
└── people.json
```

> [!CAUTION]
> Do not modify `styles.css` or `scripts.js` directly. Use `my-styles.css` for custom styles and add new scripts as needed.

## Maintenance

### Updating the "Recent Publications" Section"

You don't need to manually update the "Recent Publications" section. The website
fetches the latest publications from PubMed using the [PubMed API](https://www.ncbi.nlm.nih.gov/home/develop/api/).

### Updating Team Members

To update team members, edit the `people.json` file. This file is a JSON (JavaScript Object Notation) document that structures data in a human-readable format.

Structure of `people.json`:

- The file contains objects for different categories (e.g., "Postdoctoral Fellows", "Students")
- Each category is an array of person objects
- Each person object has properties like "name", "photo", "description", and optionally "website"

To add, remove, or modify team members:

1. Navigate to `people.json` in the GitHub repository
2. Click the edit (pencil) icon
3. Make your changes, following the existing structure
4. Commit your changes with a descriptive message

Example of adding a new team member:

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

To add new team member photos:

1. Go to the `assets/photos/` directory in the GitHub repository
2. Click "Add file" > "Upload files"
3. Select and upload the new photo(s)
4. Commit the changes
5. Update the corresponding entry in `people.json` with the correct file path

### Dynamic Content Generation

The website uses JavaScript to dynamically generate content:

- `people.js`: Fetches and renders the team members from `people.json`
- `publications.js`: Fetches recent publications from PubMed and renders them on the page

These scripts interact with the HTML to create dynamic sections of the website.

## Domain Management

The website domain (palomerolab.org) is registered through [Porkbun](https://porkbun.com/).
The website is hosted for free on GitHub Pages, with only the domain name requiring annual renewal.

### Setting Up Custom Domains on GitHub Pages

For detailed instructions on setting up custom domains with GitHub Pages, including A records configuration, refer to the [GitHub Pages documentation](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site).

#### CNAME File

The `CNAME` file in the repository root contains just the domain name
(palomerolab.org). The file is used to map the custom domain to the GitHub Pages
site.

### Subdomains and Project Pages

Other repositories with GitHub Pages enabled are accessible under palomerolab.org. For example, a repository named `project` would be accessible at `palomerolab.org/project`.

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
- [ ] Disallow direct modifications to `styles.css` and `scripts.js`
- [ ] Prevent accidental deletion of `people.json` or `assets/photos/`
- [ ] Implement a GitHub Action to validate JSON syntax on every commit
- [ ] Create a web-based form for editing `people.json` to avoid syntax errors
- [ ] Add a script to automatically resize and optimize uploaded photos
- [ ] Implement a staging environment for testing changes before they go live
- [ ] Add a script to automatically update copyright year in the footer
