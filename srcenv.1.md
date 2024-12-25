% SRCENV(1) srcenv 1.5.17 | General Commands Manual
%
% December 2024

NAME
====

**srcenv** — cross-shell tool for sourcing POSIX compliant .env scripts

SYNOPSIS
========

| **srcenv** \<_shell_\> \[_options_] \[_files_]
| **srcenv** init|rc \<_shell_\> \[\--cmd _name_] \[\--sh _sh_] \[\-- _options_]
| **srcenv** \[**-h**|**\--help**|**\--version**]

DESCRIPTION
===========

srcenv takes a snapshot of the POSIX shell environment, sources the .env scripts
and prints a shell specific script exporting the environment variables that have
changed since the snapshot, with support for reverting those changes.

srcenv depends on jq(1) ≥ 1.5 being available; see <https://jqlang.github.io/jq> for
installation options.

EXIT STATUS
===========

srcenv exits 0 on success, 1 on error, 2 on invalid option, 5 on JSON parsing error and 127 on command not found.

COMMANDS
========

init

:   Generate the integration script to be sourced with command name `` ` ``src`` ` `` _(change with \--cmd)_ and POSIX shell `` ` ``sh`` ` `` _(change with \--sh)_. For details, see SHELL INTEGRATION section below.

rc

:   Generate the command to add to your shell's configuration file to source the integration script. For details, see SHELL INTEGRATION section below.

SHELLS
======

ash, dash

:   Format the output as an Ash/Dash script.

bash

:   Format the output as a Bash script.

clink

:   Format the output as a Clink/Windows Command shell script.

cmd, command

:   Format the output as a Windows Command shell script.

csh, tcsh

:   Format the output as a Csh/Tcsh script.

elvish

:   Format the output as an Elvish script.

env

:   Format the output as a .env file.

fish

:   Format the output as a Fish script.

ion

:   Format the output as an ion script.

json

:   Format the output as JSON.

ksh, pdksh, mksh

:   Format the output as a Ksh script.

murex

:   Format the output as a Murex script.

launchd

:   Format the output as a launchd environment script.

nu, nushell

:   Format the output as a Nushell script.

posix, sh

:   Format the output as a POSIX shell script.

pwsh, powershell

:   Format the output as a PowerShell script.

xonsh

:   Format the output as a Xonsh script.

zsh

:   Format the output as a Zsh script.

OPTIONS
=======

\--color WHEN, \--color=WHEN

:   Specify when to use colored output: \*auto\*, never or always. `` ` ``auto`` ` `` disables colors if the output goes to a pipe.

\--export-colors

:   Cache terminal capabilities to SRCENV_RESTORE to improve performance. For details, see ENVIRONMENT section below.

\--clear-colors

:   Clear cached terminal capabilities from SRCENV_RESTORE.

-x VAR, \--exclude VAR, -x=VAR, \--exclude=VAR

:   Exclude VAR from exported variables (can be used multiple times).

-f FORMAT, -f=FORMAT, \--format FORMAT, \--format=FORMAT

:   Format the output as anything (shell or jq interpolated string). For details, see FORMAT section below.

-i INPUT, -i=INPUT, \--input INPUT, \--input=INPUT

:   Source from string value of INPUT.

-

:   Source from STDIN.

-b, \--backup

:   Backup changes to SRCENV_RESTORE for restore.

-r, \--restore

:   Restore backed up changes from SRCENV_RESTORE.

-c, \--clear

:   Clear backed up changes from SRCENV_RESTORE.

-n

:   Do not backup changes and do not restore backed up changes.

\--no-backup

:   Do not backup changes to SRCENV_RESTORE for restore.

\--no-restore

:   Do not restore backed up changes from SRCENV_RESTORE.

-m, \--modify

:   Allow modifying existing environment variables (Default).

-w, \--write-protect

:   Do not allow modifying existing environment variables.

-j, \--json

:   Treat input as JSON.

-p, \--posix

:   Treat input as POSIX (Default).

-e, \--export

:   Export all variables (Default for .env files).

-l, \--local

:   Do not export all variables.

-s, \--sort

:   Sort the environment variables alphabetically (Default).

-u, \--unsorted

:   Keep the environment variables unsorted.

-q, \--quiet

:   Do not display changed environment variables.

-v, \--verbose

:   Display changed environment variables.

-h, \--help

:   Display help and exit.

\--version

:   Display the version number and exit.

\--debug

:   Display jq filter without sourcing and exit.

SHELL INTEGRATION
=================

srcenv can integrate with your shell and add the following command to source `.env` scripts:

Usage
-----

```bash
src [options] [files]
    [-h|--help|--version]
```

Example
-------

```bash
❯ src project.env     # Sources `project.env`
srcenv: +COMPILER_OPTIONS +PROJECT_PATH

❯ src project2.env    # Reverts `project.env` and sources `project2.env`
srcenv: ~COMPILER_OPTIONS -PROJECT_PATH +PROJECT2_PATH

❯ src --restore       # Reverts `project2.env` (same as src -r)
srcenv: -COMPILER_OPTIONS -PROJECT2_PATH

❯ src --version       # Shows the version of srcenv
srcenv x.y.z

❯ _
```

Integration
-----------

To add the `` ` ``src`` ` `` command, add the following to your shell's configuration file:

POSIX:

:   `source <(srcenv init sh)`

Csh/Tcsh:

:   `srcenv init csh | source /dev/stdin`

Elvish:

:   `var src~ = { }; eval &on-end={|ns| set src~ = $ns[src] } (srcenv init elvish)`

Murex:

:   `srcenv init murex -> source`

Nushell _(env.nu)_:

:   `srcenv init nu | save -f srcenv.init.nu`

Nushell _(config.nu)_:

:   `source srcenv.init.nu`

Fish:

:   `srcenv init fish | source`

ion:

:   `eval "$(srcenv init ion)"`

```text
NOTE: Usage is different; see ION SHELL section below.
```

PowerShell:

:   `Invoke-Expression (sh "/path/to/srcenv" init pwsh)`

Xonsh:

:   `execx($(srcenv init xonsh))`

Windows Command shell _(HKCU\\SOFTWARE\\Microsoft\\Command Processor\\AutoRun)_:

:   `@echo off & sh "/path/to/srcenv" init cmd > %TEMP%\srcenv.init.cmd && call %TEMP%\srcenv.init.cmd & del %TEMP%\srcenv.init.cmd & echo on`

Windows Command shell (Clink) _(%LOCALAPPDATA%\\clink\\srcenv.lua)_:

:   `os.execute(io.popen('sh /path/to/srcenv init clink'):read('*a'))`

Tips
----

To use a different command name (e.g. `` ` ``magicenv`` ` ``), add `` ` ``\--cmd magicenv`` ` ``. You can also pass different arguments to srcenv with `` ` ``\--`` ` `` at the end. Without `` ` ``\--`` ` ``, the default options are `` ` ``\--backup \--restore \--verbose`` ` ``.

:   e.g. `` ` ``source <(srcenv init bash \--cmd srcundo \-- \--restore)`` ` `` creates a command named `` ` ``srcundo`` ` `` that restores the last backed up changes.

To improve performance or compatibility, you can specify different POSIX shell with `` ` ``\--sh`` ` ``. If available, dash or ksh usually outperform bash and zsh.

To further improve performance when using colored output, use `` ` ``src \--export-colors`` ` `` **once** to cache terminal capabilities in the `` ` ``SRCENV_COLORS`` ` `` environment variable.

For non-standard integration, use `` ` ``srcenv rc \<shell> [\--cmd name] [\--sh sh] [\-- options]`` ` `` to output what needs to be added to your shell's configuration file.

ION SHELL
=========

ion shell implements variadic functions using the array syntax `` ` ``[...]`` ` ``.

`` ` ``src`` ` `` arguments must be provided inside brackets.

:   e.g. `` ` ``src [ project.env ]`` ` `` or `` ` ``src [ \--help ]`` ` ``

WARNING: ion shell has no way to unset environment variables; they are instead set to an empty string.

EXAMPLES
========

The following examples show how to source `.env` in different shells:

POSIX:

:   `source <(srcenv sh .env)`

Csh/Tcsh:

:   `srcenv csh .env | source /dev/stdin`

Elvish:

:   `eval (srcenv elvish .env | slurp)`

Murex:

:   `srcenv murex .env -> source`

Nushell:

:   `srcenv json .env | from json | load-env`

Fish:

:   `srcenv fish .env | source`

ion:

:   `eval "$(srcenv ion .env)"`

PowerShell:

:   `Invoke-Expression (sh "/path/to/srcenv" pwsh .env)`

Xonsh:

:   `execx($(srcenv xonsh .env))`

Windows Command shell:

:   `@echo off & sh "/path/to/srcenv" cmd .env > %TEMP%\srcenv.temp.cmd && call %TEMP%\srcenv.temp.cmd & del %TEMP%\srcenv.temp.cmd & echo on`

FORMAT
======

The format is either a shell (e.g. `` ` ``json`` ` ``) or a jq(1) interpolated string `` ` ``\\(...)`` ` `` where the key is `` ` ``$k`` ` ``, and the value `` ` ``.[\$k]`` ` ``. A second interpolated string can be appended with the `` ` ``??`` ` `` delimiter to format null values _(unset environment variables)_.

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

ENVIRONMENT
===========

SRCENV_JQ

:   If this environment variable is defined, srcenv will use it as the location for jq(1).

SRCENV_JQ_BINARY

:   If this environment variable is defined, srcenv will pass the \--binary option to jq(1).

SRCENV_COLOR

:   If this environment variable is defined, it will be the default value for the \--color option.

SRCENV_COLORS

:   If this environment variable is defined, terminal capabilities will be read from it as a list of ANSI sequences separated by `` ` ``\032`` ` ``. It can also be used to theme srcenv.

```bash
# Default theme
SRCENV_COLORS=$(printf "$(tput sgr0)\032$(tput bold)\032$(tput dim)\032$(tput sitm)\032$(tput smul)\032$(tput setaf 0)\032$(tput setaf 1)\032$(tput setaf 2)\032$(tput setaf 3)\032$(tput setaf 4)\032$(tput setaf 5)\032$(tput setaf 6)\032$(tput setaf 7)")
```

COMSPEC, MUREX_PID, BASH_VERSION, KSH_VERSION, ZSH_VERSION

:   These environment variables are checked to detect Windows, Murex, Bash, Ksh and Zsh respectively.

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
