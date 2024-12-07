# srcenv

[![Version](https://img.shields.io/github/v/release/ins0mniaque/srcenv)](https://github.com/ins0mniaque/srcenv/releases)
[![License](https://img.shields.io/github/license/ins0mniaque/srcenv)](https://github.com/ins0mniaque/srcenv/blob/master/LICENSE)
[![CI](https://github.com/ins0mniaque/srcenv/actions/workflows/ci.yml/badge.svg)](https://github.com/ins0mniaque/srcenv/actions/workflows/ci.yml)
[![Release](https://github.com/ins0mniaque/srcenv/actions/workflows/release.yml/badge.svg)](https://github.com/ins0mniaque/srcenv/actions/workflows/release.yml)

[Installation](#installation) / [Usage](#usage) / [Roadmap](#roadmap) / [Contributing](#contributing)

A cross-shell tool for sourcing POSIX compliant .env scripts.

## Description

srcenv takes a snapshot of the POSIX shell environment, sources the .env scripts
and prints a shell specific script exporting the environment variables that have
changed since the snapshot.

## Installation

### Homebrew

```bash
brew install ins0mniaque/srcenv/srcenv
```

### Manual

> [!IMPORTANT]
> A POSIX shell is required to evaluate the `.env` scripts.
>
> [jq](https://jqlang.github.io/jq) is required and needs to be in your `PATH`; see [installation options](https://jqlang.github.io/jq/download).

Download the [latest script](https://raw.githubusercontent.com/ins0mniaque/srcenv/main/srcenv) and/or [man page](https://raw.githubusercontent.com/ins0mniaque/srcenv/main/srcenv.1) and make it executable:

```bash
curl -OL https://raw.githubusercontent.com/ins0mniaque/srcenv/main/srcenv
curl -OL https://raw.githubusercontent.com/ins0mniaque/srcenv/main/srcenv.1

chmod +x srcenv
```

_or_

Clone the repository:

```bash
git clone https://github.com/ins0mniaque/srcenv
```

## Usage

The following table shows how to source `.env` in different shells:

| Shell      | Command                                 |
|------------|-----------------------------------------|
| Bash       | `source <(srcenv bash .env)`            |
| Fish       | `srcenv fish .env \| source`            |
| PowerShell | `Invoke-Expression (&srcenv pwsh .env)` |
| Zsh        | `source <(srcenv zsh .env)`             |

For a list of supported shells, see `srcenv --help`.

For more advanced usage see the [srcenv(1) manpage](https://github.com/ins0mniaque/srcenv/blob/main/srcenv.1.md) (`man ./srcenv.1`).

## Roadmap

- [ ] Fill out roadmap

## Contributing

See [CONTRIBUTING.md](https://github.com/ins0mniaque/srcenv/blob/main/CONTRIBUTING.md) for more information on how to contribute.
