#! /usr/bin/env Rscript
# clean_data.R
# Nov 20 2018


# Usage: Rscript clean_data.R input_file output_file

# Load libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(here))
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = here())

#Capture command line arguments and convert into path strings
args <- commandArgs(trailingOnly = TRUE)
input_path <- file.path("data/", args[1])
output_path = file.path("data/", args[2])

#Read file
listings=read.csv(input_path)

#DATA CLEANING
#There is no missing values coded as NA, but there are a few prices set to zero. Let's eliminate those.
listings <- listings %>% 
  filter(price != 0)

#All neighborhood groups are null. Let's drop this column.
listings <- listings %>% 
  select(-neighbourhood_group)

#Now let's create a categorical value based on the price.
xs <- quantile(listings$price,c(0,1/3,2/3,1))
listings <- listings %>% 
  mutate(price_level=cut(price,breaks=xs,labels=c("low","median","high")))

#Finally, let's save the dataset to a file
listings %>% write_csv(output_path)
