## Getting Started with front-end docs

- First [intall Mkdocs](https://www.mkdocs.org/user-guide/installation/) locally.
- Then, make sure you are in `frontend_doc` directory, run `mkdocs serve`. Open up http://127.0.0.1:8000/ in your browser, and you'll see the default home page being displayed.
- If you want to deploy your documentation, run `mkdocs build`, then run `mkdocs gh-deploy --force`. Your documentation should shortly appear at <username>.github.io/<repository>
    - A new branch `gh-pages` will be automatically added
    - Go to your repository's setting page, click on `pages`, select the `gh-deploy` branch to build the GitHub Pages site 