# AirBnb Listing Prices in Amsterdam

## Team 

- Gabriel Francisco Medeiros Bogo 
- Yuwei Liu 
- Jielin Yu 

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

## Proof of Loading Data

We can use the script under src to load data.

![Main report (sketch)](https://github.com/liuyuwei169/DSCI-522_Airbnb_Listings_Amsterdam/blob/master/img/load_data_screenshot.png)


## Questions:

- What are the strongest predictors of price for airbnb listings in Amsterdam?

- Type of Question: **Predictive**


## Analysis Plan 

Our goal is to determine which of the features at hand have the highest dependence with the data.

Step 1. Data wangling:

- Cleaning missing and null values 
- Selecting useful Columns 
- Mutating a column indicating price three levels as high, median and low 

Step 2. Linear Regression :

 A Multiple Linear Regression can provide this information by the weight of each of the features.

Step 3. Decision Tree regression:

- Separate the dataset into training and testing datasets
- Feature vectors are `minimum_nights`, `number_of_reviews`, `calculated_host_listings`, `availability_365`
- Target variable is the price level 
- Use `scikit-learn` to build a predictive model 


## Summarization and Visualization

First, we will make multiple scatterplots to show different feature relationships with prices. Then, we will draw a decision tree and report a ordered list of four predictors. Also, we will report a classification error of our model. 
