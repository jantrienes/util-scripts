#!/bin/bash
##====================================================
## This script creates makefiles to simplify the work
## with latex documents.
##
## Parametres:
## -$1 (name of main document) includes the name of latex
## main document, otherwise 00-main.tex is used.
##
##====================================================
nameOfPdf=${1%%.*}
nameOfFile=${2%%.*}

if [ -z "$nameOfPdf" ];
then
	nameOfPdf="00-main"
fi

if [ -z "$nameOfFile" ];
then
	nameOfFile="00-main"
fi
cat > makefile << EOF
all: main clean

main:
	pdflatex $nameOfFile.tex
	pdflatex $nameOfFile.tex

clean:
	rm -f *.log *.lof *.lot *.toc *~ *.aux *.fls *.out \
	*.bbl *.blg *.synctex.gz *.maf *.mtc *.mtc0 *.snm *.nav *.glo *.glsdefs \
	*.ist *.vrb
	mv $nameOfFile.pdf $nameOfPdf.pdf
EOF
