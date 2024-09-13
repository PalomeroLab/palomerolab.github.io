# palomerolab.org

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

The lab website is built using [this template](https://github.com/StartBootstrap/startbootstrap-scrolling-nav).

The initial commit was create by cloning the template repository...

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

```
dist/
├── assets/
│   └── favicon.ico
├── cs/s
│   └── styles.css
├── index.html
└── js/
    └── scripts.js

4 directories, 4 files
```

> [!CAUTION]
> Do not modify styles.css or scripts.js directly.
