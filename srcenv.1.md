% SRCENV(1) srcenv 1.0.1 | General Commands Manual
%
% November 2024

NAME
====

**srcenv** — cross-shell tool for sourcing POSIX compliant .env scripts

SYNOPSIS
========

| **srcenv** \[_options_] \[_files_]
| **srcenv** \[**-h**|**\--help**|**-v**|**\--version**]

DESCRIPTION
===========

srcenv takes a snapshot of the POSIX shell environment, sources the .env scripts
and prints a script exporting the environment variables that have changed since
the snapshot, for one of the following shells:

    bash, csh/tcsh, dash, elvish, fish, murex, nushell, powershell, zsh

srcenv depends on jq(1) being available; see <https://jqlang.github.io/jq/> for
installation options.

Options
-------

\--bash

:   Format the output as a Bash script.

\--csh, \--tcsh

:   Format the output as a Csh/Tcsh script.

\--dash

:   Format the output as a Dash script.

\--elvish

:   Format the output as an Elvish script.

\--env

:   Format the output as a .env file.

\--fish

:   Format the output as a Fish script.

\--murex

:   Format the output as a Murex script.

\--nu, \--nushell

:   Format the output as a Nushell script.

\--posix, \--sh

:   Format the output as a POSIX shell script.

\--pwsh, \--powershell

:   Format the output as a PowerShell script.

\--zsh

:   Format the output as a Zsh script.

-

:   Source from STDIN.

-a ARG, -a=ARG, \--arg ARG, \--arg=ARG

:   Source from string value of ARG.

-e, \--export

:   Export all variables (Default for .env/.envrc files).

-n, \--noexport

:   Do not export all variables.

-s, \--sort

:   Sort the environment variables alphabetically.

-u, \--unsorted

:   Keep the environment variables unsorted.

-h, \--help

:   Display help and exit.

-v, \--version

:   Display the version number and exit.

EXAMPLES
========

The following examples show how to source `.env` in different shells:

Bash:

:   `source <(srcenv --bash .env)`

Fish:

:   `srcenv --fish .env | source`

PowerShell:

:   `Invoke-Expression (&srcenv --pwsh .env)`

Zsh:

:   `source <(srcenv --zsh .env)`

SEE ALSO
========

Repository: https://github.com/ins0mniaque/srcenv

**sh(1)**, **jq(1)**

AUTHOR
======

Jean-Philippe Leconte <https://github.com/ins0mniaque>

BUGS
====

See GitHub Issues: https://github.com/ins0mniaque/srcenv/issues