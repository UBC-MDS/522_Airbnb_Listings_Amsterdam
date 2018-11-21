#! /usr/bin/env Rscript 
# clean_data.R
# Nov 20 2018
#

#
# Usage: Rscript load_data.R
suppressPackageStartupMessages(library(tidyverse))
data=read.csv("data/listings.csv")
head(data)

#clean data
library(tidyverse)
# feature vector: `minimum_nights`, `number_of_reviews`, `calculated_host_listings`,`availability_365`
#target: price level
data<-data[,-c(3,4,5,7,8,9,13,14)]
sum(is.na(data))
#no na
xs=quantile(data$price,c(0,1/3,2/3,1))
xs
# classify the price into three groups 
data %>% mutate(price_level=cut(price,breaks=xs,labels=c("low","median","low")))
