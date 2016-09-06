#!/bin/bash
##====================================================
## A simple script to handle svn ignore settings.
## The script can add java and latex ignores to
## the svn proplist.
##
## Parametres:
## -a (Append) appends the new ignores to the existing ones
## -l (LaTeX) LaTeX files to be ignored
## -j (Java) Java files to be ignored
## -c (C++) c++ files to be ignored
## -cs (C#) c# files to be ignored
## -xc (Xcode) ignores private project settings
##
##====================================================
# Directory which contains the arguments that shall be ignored
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Specify resources
JAVARES=${DIR}/SVNJAVAPROPSET
TEXRES=${DIR}/SVNTEXPROPSET
CPPRES=${DIR}/SVNCPPPROPSET
CSPRES=${DIR}/SVNCSHARPPROPSET
XCRES=${DIR}/SVNXCPROPSET
#specify flags in order to handle command line arguments
aflag=off
ignore_set=/dev/null
while [ $# -gt 0 ]
do
  case "$1" in
    -a) aflag=on;;
    -l) ignore_set="${ignore_set} $TEXRES";;
    -j) ignore_set="${ignore_set} $JAVARES";;
    -c) ignore_set="${ignore_set} $CPPRES";;
    -cs) ignore_set="${ignore_set} $CSPRES";;
    -xc) ignore_set="${ignore_set} $XCRES";;
    -*) echo >&2 "usage: $0 svnignore [-a] [-l] [-j] [-c] [-cs] [-xc]"
    break;;
  esac
  shift
done

cat ${ignore_set} >> tmp.ignore

if [ $aflag = on ];
then
  svn proplist -v | grep -vE 'ignore|Properties' > current.ignore
  perl -lape 's/\s+//sg' current.ignore > current.ignore.formatted
  cat tmp.ignore >> current.ignore.formatted
  cat current.ignore.formatted | sort | uniq >> current.ignore.formatted.uniq
  svn propset svn:ignore -F current.ignore.formatted.uniq . --recursive
  rm -f current.ignore.formatted current.ignore.formatted.uniq current.ignore
else
  svn propset svn:ignore -F tmp.ignore . --recursive
fi
rm tmp.ignore
