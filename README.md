# MJML (Rust NIFs for Elixir)

[![Build Status](https://github.com/adoptoposs/mjml_nif/workflows/Tests/badge.svg)](https://github.com/adoptoposs/mjml_nif/workflows/Tests/badge.svg)
[![Module Version](https://img.shields.io/hexpm/v/mjml.svg)](https://hex.pm/packages/mjml)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/mjml/)
[![Total Download](https://img.shields.io/hexpm/dt/mjml.svg)](https://hex.pm/packages/mjml)
[![License](https://img.shields.io/hexpm/l/mjml.svg)](https://github.com/adoptoposs/mjml_nif/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/adoptoposs/mjml_nif.svg)](https://github.com/adoptoposs/mjml_nif/commits/master)

Native Implemented Function (NIF) bindings for the [MJML](https://mjml.io) Rust implementation ([mrml](https://github.com/jdrouet/mrml)).

## Installation

In order to use the package you need to [install Rust](https://www.rust-lang.org/tools/install).

The package can be installed by adding `mjml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mjml, "~> 1.1.2"}
  ]
end
```

## Usage

Transpile MJML templates to HTML with:

```elixir
mjml = "<mjml>...</mjml>"
{:ok, html} = Mjml.to_html(mjml)

# For an invalid MJML template:
mjml = "something not MJML"
{:error, message} = Mjml.to_html(mjml)
```

## Deployment

MJML requires that the Rust compiler be [installed](https://www.rust-lang.org/tools/install) wherever MJML is compiled.

### Deploying to Heroku

Most Heroku buildpacks for Elixir do not come with Rust installed; you will need to:

- Add a Rust buildpack to your app, setting it to run before Elixir; and
- Add a `RustConfig` file to your project's root directory, with `RUST_SKIP_BUILD=1` set.

For example:
```bash
$ heroku buildpacks:add -i 1 https://github.com/emk/heroku-buildpack-rust.git
$ echo "RUST_SKIP_BUILD=1" > RustConfig
```

### Deploying with Docker

Make sure Rust is installed prior to running `mix deps.compile`. You can see examples of what commands to include in your Dockerfile by looking at the official Rust Dockerfiles. For example, here are the commands for [`alpine3.11`](https://github.com/rust-lang/docker-rust/blob/009cc0a821ff773d54875350312731ed490d5cce/1.43.1/alpine3.11/Dockerfile) based images.

If your Dockerfile is separated into a build stage and a release stage Rust only needs to be installed on the build stage. **However**, your release stage will need to have `libgcc` installed.

Alpine, for example, does not include `libgcc` by default and you will need to install it.

```
RUN apk add --no-cache libgcc
```

You will also need to have the following environment variable set during the `build` stage or else `mix compile` will fail.

```
RUSTFLAGS='--codegen target-feature=-crt-static'
```

## Contributing

We encourage you to contribute to mjml_nif.
Please check our [CONTRIBUTING.md](./CONTRIBUTING.md) guides for more information.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to our [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).


## Copyright and License

Copyright (c) 2020 Paul Götze

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
