#! /usr/bin/env Rscript
# exploratory_analysis.R


# Gabriel Bogo, Yuwei Liu, Jielin Yu
# December 4 2018

# Purpose: generate exploratory figures to provide insights for statistical modeling.

# Example usage: Rscript src/exploratory_analysis.R data/amsterdam_clean_listings.csv amsterdam

library(tidyverse)
library(here())
library(gridExtra)

#Capture command line arguments and convert into path strings
args <- commandArgs(trailingOnly = TRUE)
input_path <- args[1]
output_path <- here("results", paste("exploratory", args[2], sep="-"))


input_path <- "data/amsterdam_clean_listings.csv"
#Read data
clean_listings <- read_csv(input_path, col_types="iciccddciiiDdiici") %>%
    mutate(neighbourhood = as_factor(neighbourhood),
           neighbourhood = fct_reorder(neighbourhood, price, .desc=TRUE))%>%
    mutate(price_level= price_level%>%fct_relevel("low", "median", "high"))

#1)price and reviews
ylims_reviews <- clean_listings %>%
  group_by(price_level) %>%
  summarise(Q1 = quantile(number_of_reviews, 0), Q3 = quantile(number_of_reviews, 0.85)) %>%
  ungroup() %>%
  #get lowest Q1 and highest Q3
  summarise(lowQ1 = min(Q1), highQ3 = max(Q3))

(price_reviews <- clean_listings %>% ggplot(aes(y=price_level, x=number_of_reviews)) +
  geom_jitter(alpha=0.3) +
  scale_colour_brewer(palette="Spectral") +
  theme_classic()+
  ggtitle("Exploratory - Price vs Number of Reviews") +
  xlab("Number of reviews") +
  ylab("Price level") +
  coord_cartesian(xlim = as.numeric(ylims_reviews)*1.05))

ggsave(paste(output_path, "price-reviews.png", sep="_"), device="png")

#2)minimum nights VS price level
ylims_minNights <- clean_listings %>%
  group_by(price_level) %>%
  summarise(Q1 = quantile(minimum_nights, 0.1), Q3 = quantile(minimum_nights, 0.90)) %>%
  ungroup() %>%
  #get lowest Q1 and highest Q3
  summarise(lowQ1 = min(Q1), highQ3 = max(Q3))

(price_minNights <- clean_listings %>% 
    ggplot(aes(y=price_level,x=minimum_nights))+
    geom_jitter(alpha=0.3)+
    ggtitle("Price vs Minimum Nights")+
    xlab("Minimum Nights") +
    ylab("Price level") +
    coord_cartesian(xlim = as.numeric(ylims_minNights)*1.05))

ggsave(paste(output_path, "price-minNights.png", sep="_"), device="png")

#3)price and calculated_host_listing_counts
ylims_listingsCount <- clean_listings %>%
  group_by(price_level) %>%
  summarise(Q1 = quantile(calculated_host_listings_count, 0.1), Q3 = quantile(calculated_host_listings_count, 0.90)) %>%
  ungroup() %>%
  #get lowest Q1 and highest Q3
  summarise(lowQ1 = min(Q1), highQ3 = max(Q3))

(price_listingsCount <- clean_listings %>% ggplot(aes(y=price_level, x=calculated_host_listings_count)) +
    geom_jitter(alpha=0.5) +
    geom_violin() +
    scale_colour_brewer(palette="Spectral") +
    theme_classic()+
    ggtitle("Exploratory - Price vs Number of listings per host") +
    xlab("Number of listings per host") +
    ylab("Price level") +
    coord_cartesian(xlim = as.numeric(ylims_listingsCount)*1.05))

ggsave(paste(output_path, "price-listingsCount.png", sep="_"), device="png")

#4) Distribution of price per type of listing
(price_roomType <- clean_listings %>% ggplot(aes(x=room_type, y=price)) +
    geom_boxplot() +
    ggtitle("Exploratory - Room Type vs Price") +
    xlab("Room Type") +
    ylab("Price (US$)") +
    theme_minimal())

ggsave(paste(output_path, "price-roomType.png", sep="_"), device="png")

#5)price and availability_365
(price_availability <- clean_listings %>% ggplot(aes(y=price_level,x=availability_365)) +
    geom_jitter(alpha=0.4)+
    scale_colour_brewer(palette="Spectral") +
    theme_classic()+
    ggtitle("Exploratory - Price vs Number of days available per year") +
    ylab("Price level") +
    xlab("Number of days available per year"))

ggsave(paste(output_path, "price-availability.png", sep="_"), device="png")

#6)Boxplot of price per neighborhood
(price_neighborhood <- clean_listings %>% ggplot(aes(x=neighbourhood, y=price)) +
    geom_boxplot() +
    ggtitle("Exploratory - Price vs Neighborhood") +
    xlab("Neighborhood") +
    ylab("Price (US$)") +
    theme_minimal() +
    theme(axis.text.x=element_text(angle=90,hjust=1)))

ggsave(paste(output_path, "price-neighborhood.png", sep="_"), device="png")

#7)Histogram of price
threshold_1 <- quantile(clean_listings$price, 1/3)
threshold_2 <- quantile(clean_listings$price, 2/3)

(price_histogram <- clean_listings %>% ggplot(aes(x=price)) +
  geom_histogram(binwidth=20) +
  ggtitle("Exploratory - Price histogram") +
  ylab("Count") +
  xlab("Price (US$)") +
  theme_minimal() +
  geom_vline(xintercept = threshold_1, colour = "blue", linetype="dashed") +
  geom_vline(xintercept = threshold_2, colour = "blue", linetype="dashed")
  )

ggsave(paste(output_path, "price-histogram.png", sep="_"), device="png")

#Grid of figures
(plot_grid <- grid.arrange(price_reviews, price_minNights, price_listingsCount,
             price_roomType, price_availability,ncol=2, nrow=3))

ggsave(paste(output_path, "plot-grid.png", sep="_"), device="png")
