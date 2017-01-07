#!/bin/bash
##====================================================
## A simple script to handle svn ignore settings.
##
## The script reads svnignore properties from files
## located in svnignore.d. Each file in this directory
## represents a proplist. This script is to be called
## with the name of this proplist.
##
## Parametres:
## -a (Append) appends the new ignores to the existing ones
## [proplist ...]
##====================================================
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

config=$dir/svnignore.d

append=false
ignore_set=/dev/null
while [ $# -gt 0 ]
do
  case "$1" in
    -a)
    append=true;;
    -*)
    echo >&2 "usage: $0 svnignore [-a] [proplist ...]"
    exit 1;;
    *)
    if [ -e $config/$1 ]
    then
      ignore_set="${ignore_set} $config/$1"
    else
      echo >&2 "no such ignore propset: $1"
      exit 1
    fi
    ;;
  esac

  shift
done

cat $ignore_set >> tmp.ignore

if [ "$append" = true ];
then
  svn proplist -v | grep -vE 'ignore|Properties' > current.ignore
  perl -lape 's/\s+//sg' current.ignore > current.ignore.formatted
  cat tmp.ignore >> current.ignore.formatted
  sort current.ignore.formatted | uniq >> current.ignore.formatted.uniq
  svn propset svn:ignore -F current.ignore.formatted.uniq . --recursive
  rm -f current.ignore.formatted current.ignore.formatted.uniq current.ignore
else
  svn propset svn:ignore -F tmp.ignore . --recursive
fi
rm tmp.ignore
