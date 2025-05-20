<div align="center">

# Swagger UI Standalone

[![Gem Version](https://img.shields.io/gem/v/swagger_ui_standalone)](https://badge.fury.io/rb/swagger_ui_standalone)
[![Ruby](https://github.com/typisttech/swagger_ui_standalone/actions/workflows/main.yml/badge.svg)](https://github.com/typisttech/swagger_ui_standalone/actions/workflows/main.yml)
[![License](https://img.shields.io/github/license/typisttech/swagger_ui_standalone.svg)](https://github.com/typisttech/swagger_ui_standalone/blob/master/LICENSE.txt)
[![Follow @TangRufus on X](https://img.shields.io/badge/Follow-TangRufus-15202B?logo=x&logoColor=white)](https://x.com/tangrufus)
[![Follow @TangRufus.com on Bluesky](https://img.shields.io/badge/Bluesky-TangRufus.com-blue?logo=bluesky)](https://bsky.app/profile/tangrufus.com)
[![Sponsor @TangRufus via GitHub](https://img.shields.io/badge/Sponsor-TangRufus-EA4AAA?logo=githubsponsors)](https://github.com/sponsors/tangrufus)
[![Hire Typist Tech](https://img.shields.io/badge/Hire-Typist%20Tech-778899)](https://typist.tech/contact/)

<p>
  <strong>Generate standalone static Swagger UI sites from OpenAPI specifications.</strong>
  <br>
  <br>
  Built with ♥ by <a href="https://typist.tech/">Typist Tech</a>
</p>

</div>

---

## Quick Start

```bash
# Install the gem
gem install swagger_ui_standalone

# Prepare some custom files
mkdir custom

## Download some OpenAPI specifications
wget https://raw.githubusercontent.com/github/rest-api-description/refs/heads/main/descriptions/api.github.com/api.github.com.yaml -O custom/github.yaml
wget https://validator.swagger.io/validator/openapi.json -O custom/validator.yaml

## Make a disallow all robots.txt file
cat > custom/robots.txt <<EOF
User-agent: *
Disallow: /
EOF

## Create custom swagger-initializer.js to override the default file
cat > custom/swagger-initializer.js <<EOF
window.onload = function() {
  window.ui = SwaggerUIBundle({
    urls: [
      {name: "GitHub", url: "github.yaml"},
      {name: "Validator", url: "validator.yaml"},
      {name: "Petstore (External)", url: "https://petstore.swagger.io/v2/swagger.json"},
    ],
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  });
};
EOF

# Generate a standalone static Swagger UI site into the output directory
swagger_ui_standalone generate --custom custom --output output
```

The `generate` command downloads the latest release of Swagger UI from GitHub and copy the `dist` directory to the `output` directory. 
Then, the `custom` directory is copied as is, so you can add or overwrite files in the `output` directory.

```console
$ tree custom output
custom
├── github.yaml
├── robots.txt
├── swagger-initializer.js
└── validator.yaml
output
├── favicon-16x16.png
├── favicon-32x32.png
├── github.yaml
├── index.css
├── index.html
├── oauth2-redirect.html
├── robots.txt
├── swagger-initializer.js
├── swagger-ui-bundle.js
├── swagger-ui-bundle.js.map
├── swagger-ui-es-bundle-core.js
├── swagger-ui-es-bundle-core.js.map
├── swagger-ui-es-bundle.js
├── swagger-ui-es-bundle.js.map
├── swagger-ui-standalone-preset.js
├── swagger-ui-standalone-preset.js.map
├── swagger-ui.css
├── swagger-ui.css.map
├── swagger-ui.js
├── swagger-ui.js.map
└── validator.yaml

# Start a local web server to serve the static site with webrick
# See https://gist.github.com/willurd/5720255 for alternatives
$ gem install webrick
$ ruby -run -ehttpd output -p8000
```

## Usage

### `generate`

```console
$ swagger_ui_standalone help generate
Usage:
  swagger_ui_standalone generate [options] --custom=DIRECTORY --output=DIRECTORY

Options:
  --custom=DIRECTORY      # Path to the directory containing custom files, which will be copied to the output directory
  --output=DIRECTORY      # Where to write the generated files
  [--repo=OWNER/REPO]     # GitHub repository to download in the format <owner/repo>
                          # Default: swagger-api/swagger-ui
  [--ref=TAG|BRANCH|SHA]  # Git reference to download (can be a tag, branch or commit SHA). Omit to use the latest release
  [--force]               # Overwrite files that already exist

Generate standalone static Swagger UI
```

### `download`

```console
$ swagger_ui_standalone help download
Usage:
  swagger_ui_standalone download [options] --output=DIRECTORY

Options:
  --output=DIRECTORY      # Where to write the generated files
  [--repo=OWNER/REPO]     # GitHub repository to download in the format <owner/repo>
                          # Default: swagger-api/swagger-ui
  [--ref=TAG|BRANCH|SHA]  # Git reference to download (can be a tag, branch or commit SHA). Omit to use the latest release
  [--force]               # Overwrite files that already exist

Download standalone static Swagger UI source code
```

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add swagger_ui_standalone
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install swagger_ui_standalone
```

## Credits

[`Swagger UI Standalone`](https://github.com/typisttech/swagger_ui_standalone) is a [Typist Tech](https://typist.tech) project and
maintained by [Tang Rufus](https://x.com/TangRufus), freelance developer [for hire](https://typist.tech/contact/).

Full list of contributors can be found [on GitHub](https://github.com/typisttech/swagger_ui_standalone/graphs/contributors).

## Copyright and License

This project is a [free software](https://www.gnu.org/philosophy/free-sw.en.html) distributed under the terms of
the MIT license. For the full license, see [LICENSE](./LICENSE.txt).

## Contribute

Feedbacks / bug reports / pull requests are welcome.
