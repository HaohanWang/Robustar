# Setup

- First [intall Mkdocs](https://www.mkdocs.org/user-guide/installation/) locally.
- Then, make sure you are in `website` directory, run `mkdocs serve`. Open up http://127.0.0.1:8000/ in your browser, and you'll see the default home page being displayed.
- If you want to deploy your documentation, run `mkdocs build`, then run `mkdocs gh-deploy --force`. Your documentation should shortly appear at <username>.github.io/<repository>
- If you want to deploy your documentation, run `mkdocs build`, then run `mkdocs gh-deploy --force`. Your documentation should shortly appear at `username.github.io/repository`
    - A new branch `gh-pages` will be automatically added
    - Go to your repository's setting page, click on `pages`, select the `gh-deploy` branch to build the GitHub Pages site 

# Adding docs
The `nav` derivative in `mkdocs.yml` defines the document tree. Put your `.md` file somewhere in `docs` folder and declare your `.md` file in `mkdocs.yml`.

# Customizing the page
We use `mkdocs-material` theme. Please consult [its reference doc](https://squidfunk.github.io/mkdocs-material/setup/changing-the-colors/) for more features.
