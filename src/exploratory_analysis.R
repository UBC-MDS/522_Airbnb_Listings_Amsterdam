#! /usr/bin/env Rscript
# exploratory_analysis.R


# Gabriel Bogo, Yuwei Liu, Jielin Yu
# December 4 2018

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
           neighbourhood = fct_reorder(neighbourhood, price, .desc=TRUE))%>%
    mutate(price_level= price_level%>%fct_relevel("low", "median", "high"))



#1)price and reviews
price_reviews <- clean_listings %>% ggplot(aes(x=price_level, y=number_of_reviews)) +
  geom_bar(width=0.9, fill="#FF6666",stat="identity") +
  coord_flip()+
  scale_colour_brewer(palette="Spectral") +
  theme_classic()+
  ggtitle("Exploratory - Number of Reviews vs Price") +
  xlab("Price level") +
  ylab("Number of Reviews") 

# price_reviews
ggsave(paste(output_path, "price-reviews.png", sep="_"), device="png")




#2)minimum nights VS price level
clean_listings %>% group_by(price_level) %>% summarise(min_night_mean=mean(minimum_nights)) %>% 
  ggplot(aes(y=price_level,x=min_night_mean))+
  geom_point()+ggtitle("Price VS minimum_nights")+
  xlab("Minimum Nights") +
  ylab("Price level") 

#price_minNights
ggsave(paste(output_path, "price-minNights.png", sep="_"), device="png")

#3) Use Heatmap to find relationship between room type and price level
clean_listings %>% ggplot()+
  geom_bin2d(aes(x=room_type,y=price_level)) + 
  ggtitle("Price VS room type")+
  xlab("Room Type") +
  ylab("Price level") 

#price_roomType
ggsave(here("results/exploratory_price_roomType.png"), device="png")




#4)price and calculated_host_listing_counts
price_listingsCount <- clean_listings %>% ggplot(aes(x=price_level, y=calculated_host_listings_count)) +
    geom_bar(width=0.9, fill="#FF6666",stat="identity") +
    coord_flip()+
    scale_colour_brewer(palette="Spectral") +
    theme_classic()+
    ggtitle("Exploratory - Number of listings per host vs Price") +
    xlab("Price level") +

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




#5)price and availability_365
price_availability <- clean_listings %>% ggplot(aes(x=price_level, y=availability_365)) +
  geom_bar(width=0.9, fill="#FF6666",stat="identity") +
  coord_flip()+
  scale_colour_brewer(palette="Spectral") +
  theme_classic()+
  ggtitle("Exploratory - Number of days available per year vs Price") +
  ylab("Number of number of days available") +
  xlab("Price level") 

# price_availability
ggsave(paste(output_path, "price-availability.png", sep="_"), device="png")