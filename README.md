# Utility Shell Scripts
A collection of utility shell scripts. Mostly used under MacOS.

## Overview
Following is a brief overview of the scripts included. Each scripts reports about its usage when it is invoked with the `--help` option.

| Script          | Description                                                                                                                                   |
|:----------------|:----------------------------------------------------------------------------------------------------------------------------------------------|
| `pathalias`     | Creates an alias switching into the current working directory for rapid file system navigation.                                               |
| `svnignore`     | Ignores a set of commonly unwanted files from svn version control.                                                                            |
| `givememake`    | Produces a short makefile for compilation of LaTeX documents.                                                                                 |
| `toggledesktop` | Toggles the visibility state of the macOS desktop. Good for presentations.                                                                    |
| `nextfreeport`  | Retrieves the next free port number starting at a specific port.                                                                              |
| `drjupyter`     | Start a datascience [jupyter docker stack](https://github.com/jupyter/docker-stacks) on a free port with working directory mounted as volume. |
| `dshiny`        | Start shiny [docker server](https://github.com/rocker-org/shiny) on next free port with with working directory mounted as volume.             |

## Shellcheck
All scripts are linted using [shellcheck](https://github.com/koalaman/shellcheck). There is also a travis job which automatically executes the linter.
