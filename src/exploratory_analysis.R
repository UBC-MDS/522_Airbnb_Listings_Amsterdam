#! /usr/bin/env Rscript
# exploratory_analysis.R


# Gabriel Bogo
# Nov 22 2018

# Purpose: generate exploratory figures to provide insights for statistical modeling.

# Example usage: Rscript src/exploratory_analysis.R data/amsterdam_clean_listings.csv amsterdam

library(tidyverse)
library(here())

#Capture command line arguments and convert into path strings
args <- commandArgs(trailingOnly = TRUE)
input_path <- args[1]
output_path <- here("results", paste("exploratory", args[2], sep="-"))

# input_path <- "data/amsterdam_clean_listings.csv"
#Read data
clean_listings <- read_csv(input_path, col_types="iciccddciiiDdiici") %>%
    mutate(neighbourhood = as_factor(neighbourhood),
           neighbourhood = fct_reorder(neighbourhood, price, .desc=TRUE))

#Scatter plot between price and reviews
price_reviews <- clean_listings %>% ggplot(aes(x=number_of_reviews, y=price)) +
    geom_point(alpha=0.25) +
    geom_smooth(method=lm, se=FALSE, color="blue") +
    ggtitle("Exploratory - Price vs Number of Reviews") +
    xlab("Number of Reviews") +
    ylab("Price (US$)") +
    scale_x_log10() +
    theme_minimal()
# price_reviews
ggsave(paste(output_path, "price-reviews.png", sep="_"), device="png")

#Scatter plot between price and minimum of nights
price_minNights <- clean_listings %>% ggplot(aes(x=minimum_nights, y=price)) +
    geom_jitter(alpha=0.25) +
    geom_smooth(method=lm, se=FALSE, color="blue") +
    scale_x_log10() +
    ggtitle("Exploratory - Price vs Number of Reviews") +
    xlab("Minimum number of nights") +
    ylab("Price (US$)") +
    theme_minimal()

price_minNights
ggsave(paste(output_path, "price-minNights.png", sep="_"), device="png")

#Distribution of price per type of listing
price_roomType <- clean_listings %>% ggplot(aes(x=room_type, y=price)) +
    geom_boxplot() +
    ggtitle("Exploratory - Price vs Room Type") +
    xlab("Room Type") +
    ylab("Price (US$)") +
    theme_minimal()

# price_roomType
ggsave(here("results/exploratory_price_roomType.png"), device="png")

#Boxplot of price per neighborhood
price_neighborhood <- clean_listings %>% ggplot(aes(x=neighbourhood, y=price)) +
  geom_boxplot() +
  ggtitle("Exploratory - Price vs Neighborhood") +
  xlab("Neighborhood") +
  ylab("Price (US$)") +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1))

# price_neighborhood
ggsave(paste(output_path, "price-neighborhood.png", sep="_"), device="png")

#Scatterplot of price and calculated_host_listing_counts
price_listingsCount <- clean_listings %>% ggplot(aes(x=calculated_host_listings_count, y=price)) +
  geom_point(alpha=0.25) +
  scale_x_log10() +
  geom_smooth(method=lm, color="blue") +
  ggtitle("Exploratory - Price vs Number of listings per host") +
  xlab("Number of listings per host") +
  ylab("Price (US$)") +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1))

# price_listingsCount
ggsave(paste(output_path, "price-listingsCount.png", sep="_"), device="png")

#Scatterplot of price and availability_365
price_availability <- clean_listings %>% ggplot(aes(x=availability_365, y=price)) +
  geom_point(alpha=0.25) +
  geom_smooth(method=lm, color="blue") +
  ggtitle("Exploratory - Price vs Number of days available per year") +
  xlab("Number of number of days available") +
  ylab("Price (US$)") +
  theme_minimal() +
  theme(axis.text.x=element_text(angle=90,hjust=1))

# price_availability
ggsave(paste(output_path, "price-availability.png", sep="_"), device="png")

#Map of price (FOR THE FUTURE)
# bbox = make_bbox(clean_listings$longitude, clean_listings$latitude)
#
# amsterdam_map <- ggmap::get_stamenmap(bbox, maptype = "toner-lite", zoom = 11) %>%
#   ggmap::ggmap()
#
# amsterdam_map +
#   geom_tile(
#     aes(x = longitude, y = latitude, fill = price),
#     size = 2, data = clean_listings)
