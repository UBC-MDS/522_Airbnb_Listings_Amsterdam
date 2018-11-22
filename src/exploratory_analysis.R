#! /usr/bin/env Rscript
# exploratory_analysis.R
# Nov 22 2018

#Load libraries
library(tidyverse)

#Read data
clean_listings <- read_csv("data/clean_listings.csv")
clean_listings <- clean_listings %>% 
  filter(price > quantile(price, 0.025),
         price < quantile(price, 0.975))

#Scatter plot between price and reviews
clean_listings %>% ggplot(aes(x=number_of_reviews, y=price)) +
    geom_point()

#Scatter plot between price and reviews
clean_listings %>% ggplot(aes(x=number_of_reviews, y=price)) +
  geom_point()

#Distribution of price per type of listing
clean_listings %>% ggplot(aes(x=room_type, y=price)) +
  geom_boxplot()
