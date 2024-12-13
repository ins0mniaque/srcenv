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
changed since the snapshot, with support for reverting those changes.

## Installation

> [!IMPORTANT]
> [sh](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/sh.html) _(or any POSIX shell)_ is required to evaluate the `.env` scripts. On [Windows](#windows), srcenv can use `sh.exe` installed by [git](https://git-scm.com).
>
> [jq](https://jqlang.github.io/jq) is required and needs to be in your `PATH`; see [installation options](https://jqlang.github.io/jq/download).

### Homebrew

```bash
brew install ins0mniaque/srcenv/srcenv
```

### Debian / RPM packages

Download the latest packages from the [GitHub release page](https://github.com/ins0mniaque/srcenv/releases).

### Windows

<details>
    <summary>PowerShell</summary><p></p>

Install for current user:

```powershell
# Create installation directory
New-Item "$Env:LOCALAPPDATA\srcenv" -ItemType Directory

# Download srcenv to installation directory
Invoke-WebRequest https://raw.githubusercontent.com/ins0mniaque/srcenv/main/srcenv -OutFile "$Env:LOCALAPPDATA\srcenv\srcenv"
```

Add to `$HOME\Documents\PowerShell\Profile.ps1`:

```powershell
# Add POSIX shell (sh) to PATH
$Env:PATH += ";$Env:ProgramFiles\Git\usr\bin\"

# Initialize srcenv
Invoke-Expression (sh "$Env:LOCALAPPDATA\srcenv\srcenv" init pwsh)
```

</details>

### Manual

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

srcenv can integrate with your shell and add the following command to source `.env` scripts:

```text
src [options] [files]
    [-h|--help|-v|--version]
```

`src project.env` sources the `project.env` file in the current directory.

`src --restore` _(or `src -r`)_ reverts the changes made by the last `src` command.

### Shell integration

To add the `src` command, add the following to your shell's configuration file:

| Shell      | Command                                               |
|------------|-------------------------------------------------------|
| POSIX      | `source <(srcenv init bash)`                          |
|            | `source <(srcenv init dash)`                          |
|            | `source <(srcenv init ksh)`                           |
|            | `source <(srcenv init zsh)`                           |
| Csh/Tcsh   | `srcenv init csh \| source /dev/stdin`                |
|            | `srcenv init tcsh \| source /dev/stdin`               |
| Elvish     | `var src~ = { }; eval &on-end={\|ns\| set src~ = $ns[src] } (srcenv init elvish)` |
| Murex      | `srcenv init murex -> source`                         |
| Nushell    | `srcenv init nu \| save -f srcenv.init.nu` _(env.nu)_ |
|            | `source srcenv.init.nu` _(config.nu)_                 |
| Fish       | `srcenv init fish \| source`                          |
| PowerShell | `Invoke-Expression (sh "/path/to/srcenv" init pwsh)`  |

> [!TIP] Tip: Rename command
> To use a different command name _(e.g. `magicenv`)_, add `--cmd magicenv`.
>
> _e.g. `source <(srcenv init bash --cmd magicenv)`._

> [!TIP] Tip: More commands
> You can pass different arguments to srcenv with `--` at the end. Without `--`, the default options are `--backup --restore`.
>
> _e.g. `source <(srcenv init bash --cmd srcundo -- --restore)` creates a command named `srcundo` that restores the last backed up changes._

For a list of supported options, see `src --help`.

### Direct usage _(without shell integration)_

The following table shows how to source `.env` in different shells:

| Shell      | Command                                               |
|------------|-------------------------------------------------------|
| POSIX      | `source <(srcenv sh .env)`                            |
| Csh/Tcsh   | `srcenv csh .env \| source /dev/stdin`                |
| Elvish     | `eval (srcenv elvish .env \| slurp)`                  |
| Murex      | `srcenv murex .env -> source`                         |
| Nushell    | `srcenv json .env \| from json \| load-env`           |
| Fish       | `srcenv fish .env \| source`                          |
| PowerShell | `Invoke-Expression (sh "/path/to/srcenv" pwsh .env)`  |

For a list of supported shells and options, see `srcenv --help`.

For more advanced usage see the [srcenv(1) manpage](https://github.com/ins0mniaque/srcenv/blob/main/srcenv.1.md) (`man ./srcenv.1`).

## Roadmap

- [ ] Fill out roadmap

## Contributing

See [CONTRIBUTING.md](https://github.com/ins0mniaque/srcenv/blob/main/CONTRIBUTING.md) for more information on how to contribute.
