#!/bin/bash
# Author: Jiqiu j.wu18@imperial.ac.uk
# Script: combined.sh
# Desc: prepare the data for later model fitting
# Arguments: none
# Date: march 2019

#prepare the data for later model fitting
Rscript pre_data.R
python3 modelfitting.py
Rscript plot.R
bash CompileLaTeX.sh Miniproject_JiqiuWu
mv Miniproject_JiqiuWu.pdf ../Results/