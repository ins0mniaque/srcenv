% SRCENV(1) srcenv 1.5.1 | General Commands Manual
%
% November 2024

NAME
====

**srcenv** — cross-shell tool for sourcing POSIX compliant .env scripts

SYNOPSIS
========

| **srcenv** \<_shell_\> \[_options_] \[_files_]
| **srcenv** init \<_shell_\>
| **srcenv** \[**-h**|**\--help**|**-v**|**\--version**]

DESCRIPTION
===========

srcenv takes a snapshot of the POSIX shell environment, sources the .env scripts
and prints a shell specific script exporting the environment variables that have
changed since the snapshot.

srcenv depends on jq(1) being available; see <https://jqlang.github.io/jq> for
installation options.

Commands
--------

init

:   Generate the initialization script.

Shells
------

ash, dash

:   Format the output as an Ash/Dash script.

bash

:   Format the output as a Bash script.

bat, cmd

:   Format the output as a Windows batch script.

csh, tcsh

:   Format the output as a Csh/Tcsh script.

elvish

:   Format the output as an Elvish script.

env

:   Format the output as a .env file.

fish

:   Format the output as a Fish script.

json

:   Format the output as JSON.

ksh, pdksh, mksh

:   Format the output as a Ksh script.

murex

:   Format the output as a Murex script.

launchctl

:   Format the output as a launchctl calls (macOS).

nu, nushell

:   Format the output as a Nushell script.

posix, sh

:   Format the output as a POSIX shell script.

pwsh, powershell

:   Format the output as a PowerShell script.

zsh

:   Format the output as a Zsh script.

Options
-------

-f FORMAT, -f=FORMAT, \--format FORMAT, \--format=FORMAT

:   Format the output as anything (jq interpolated string). For details, see FORMAT section below.

-

:   Source from STDIN.

-i INPUT, -i=INPUT, \--input INPUT, \--input=INPUT

:   Source from string value of INPUT.

-b, \--backup

:   Backup changes to SRCENV_RESTORE for restore.

-r, \--restore

:   Restore backed up changes from SRCENV_RESTORE.

-e, \--export

:   Export all variables (Default for .env/.envrc files).

-l, \--local

:   Do not export all variables.

-s, \--sort

:   Sort the environment variables alphabetically (Default).

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

:   `source <(srcenv bash .env)`

Fish:

:   `srcenv fish .env | source`

PowerShell:

:   `Invoke-Expression (&srcenv pwsh .env)`

Zsh:

:   `source <(srcenv zsh .env)`

FORMAT
======

The format is a jq(1) interpolated string `` ` ``\\(...)`` ` `` where the key is `` ` ``$k`` ` ``, and the value `` ` ``.[\$k]`` ` ``. A second interpolated string can be appended with the `` ` ``??`` ` `` delimiter to format null values _(unset environment variables)_.

Key:

:   `\($k)`

Value:

:   `\(.[$k])`

Single quoted value:

:   `(.[$k]|@sh)`

Double quoted value:

:   `(.[$k]|@json)`

POSIX format:

:   `export \($k)=\(.[$k]|@sh)??unset \($k)`

SEE ALSO
========

Repository: https://github.com/ins0mniaque/srcenv

**sh(1)**, **jq(1)**

AUTHOR
======

Jean-Philippe Leconte <ins0mniaque@gmail.com>

BUGS
====

See GitHub Issues: https://github.com/ins0mniaque/srcenv/issues
