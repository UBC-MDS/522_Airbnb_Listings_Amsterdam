# AirBnb Listing Prices in Amsterdam

## Data 

Source: 
* [Website](http://insideairbnb.com/get-the-data.html)  
* [File](http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2018-10-05/visualisations/listings.csv)

Summary information and metrics for AirBnb listings in Amsterdam. The data variables are:  
* id: Unique identification code for the listing
* name: Descriptive name of the listing
* host_id: Unique identification code for the host
* host_name: first name of the host (privacy is respected. The data is open.)
* neighbourhood
* latitude
* longitude
* room_type: Shared Room, Private Room or Entire Room/Apt.
* price
* minimum_nights: whether the host requires a minimum number of nights to book his property
* number_of_reviews: number of customer reviews regarding the listing
* last_review: date of the last review
* reviews_per_month
* calculated_host_listings_count: number of listings that host has simultaneously
* availability_365: the number of days that the listing is available in a year, which is pre-defined by the host.

## Proof of Loading Data

![Main report (sketch)](reports/main_report.md)


## Questions:

- What are the strongest predictors of price for airbnb listings in Amsterdam?

- Type of Question: Predictive


## Analysis Plan 

Our goal is to determine which of the features at hand have the highest dependence with the data. A Multiple Linear Regression can yield us this information by the weight of each of the features.

As a parallel approach, we believe that a Decision Tree regression may be used as proxy for the best predictors. As a greedy algorithm, for each "decision stump", the tree will choose the features that yield the least Residual Sum of Squares in that single division, which is an indicator of the variables that best predict the price of the listings.

## Summarization and Visualization

 We will clean and filter the data and summarize the data as 5-number summary table. 
 We will make a map to visualize prices over different neighborhoods. 
 We will make multiple scatterplots to show different feature relationships with prices. 