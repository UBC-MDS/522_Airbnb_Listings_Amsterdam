# Gabriel Bogo
# Nov 22 2018

# Purpose: simple record of non-permanent code to understand the data and
#check integrity

library(tidyverse)

listings = read_csv("data/listings.csv")

summary(listings)

#Apparently there is no missing values
listings %>%
na.omit(inverse = TRUE)

#But there are a few prices set to zero.
listings %>%
  filter(price == 0)

#Are there some hosts with a ridiculous number of listings?
#Yeah, apparently there are. Maybe they're rental companies or something?
absurd_num_listings <- listings %>%
  arrange(desc(calculated_host_listings_count))

#Minimum nights: 1001? Is that a joke or something?
#Sounds like an error, but could be that the host wants some kind of contract.
#Anyway, let's keep it there unless we want to do something with this feature.
absurd_min_nights <- listings %>%
  arrange(desc(minimum_nights))

#Is there any non-null neighborhood? No.
listings %>%
  filter(!is.na(neighbourhood_group))

#Checking whether clean_data.R worked
clean_listings <- read_csv("data/clean_listings.csv")
summary(clean_listings)
