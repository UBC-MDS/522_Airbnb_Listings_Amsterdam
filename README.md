# AirBnb Listing Prices in Amsterdam

What are the factors that can best predict the prices of an AirBnb listing in Amsterdam? In this project, we'll use AirBnB public data to better understand the underlying economics of rental prices in the platform.

We believe that AirBnb data represents an excellent online proxy of the local housing market and may generate insights to other industries such as real state and construction.

## Team

- [Gabriel Francisco Medeiros Bogo](www.github.com/GabrielBogo)
- [Yuwei Liu](https://github.com/liuyuwei169)
- [Jielin Yu](https://github.com/jielinyu)

## Data

Source:
* [Website](http://insideairbnb.com/get-the-data.html)  
* [File](http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2018-10-05/visualisations/listings.csv)

Summary information and metrics for AirBnb listings in Amsterdam. The data variables are:  
* **id**: Unique identification code for the listing
* **name**: Descriptive name of the listing
* **host_id**: Unique identification code for the host
* **host_name**: first name of the host (privacy is respected. The data is open.)
* **neighbourhood**
* **latitude**
* **longitude**
* **room_type**: Shared Room, Private Room or Entire Room/Apt.
* **price**
* **minimum_nights**: whether the host requires a minimum number of nights to book his property
* **number_of_reviews**: number of customer reviews regarding the listing
* **last_review**: date of the last review
* **reviews_per_month**
* **calculated_host_listings_count**: number of listings that host has simultaneously
* **availability_365**: the number of days that the listing is available in a year, which is pre-defined by the host.

## Main research question:

- What are the two strongest predictors of price for airbnb listings in Amsterdam?

- Type of Question: **Predictive**


## Analysis Plan

Our goal is to determine which of the features at hand have the highest dependence with the data.

Step 1. Data wrangling:

- Cleaning missing and null values
- Pre-selecting useful features
- Identifying outliers
- Converting the price column into a categorical variable with three levels: high, median and low

Step 2. Decision Tree classification:

- Separate the dataset into training and testing datasets
- Feature vectors are `minimum_nights`, `number_of_reviews`, `calculated_host_listings`, `availability_365`
- Target variable is the categorical price level
- Use `scikit-learn` to build a predictive model
- Identify the most important features


## Summarization and Visualization

First, we will make multiple scatterplots to show the relationships of different features with the prices. Then, we will draw a decision tree and report an ordered list of four predictors. Also, we will report a classification error of our model.
