#! /usr/bin/env Rscript 
# clean_data.R
# Nov 15 2018
#

#
# Usage: Rscript load_data.R
suppressPackageStartupMessages(library(tidyverse))
data=read.csv("data/listings.csv")
head(data)