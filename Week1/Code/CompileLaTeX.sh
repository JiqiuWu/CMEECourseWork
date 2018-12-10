#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: CompileLaTex.sh
# Desc: Compile a .tex file to a .pdf file
# Arguments: the  .tex file
# Date: Oct 2018


pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
# clean up all the auxiliary files