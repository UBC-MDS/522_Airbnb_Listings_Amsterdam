# AirBnb Listing Prices in Amsterdam

What are the factors that can best predict the prices of an AirBnb listing in Amsterdam? In this project, we'll use AirBnB public data to better understand the underlying economics of rental prices in the platform.

We believe that AirBnb data represents an excellent online proxy of the local housing market and may generate insights to other industries such as real state and construction.

TL;DR: Here is our [final report](doc/main_report.md).

## Team

- [Gabriel Francisco Medeiros Bogo](https://github.com/GabrielBogo)
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


## Analysis Workflow

Our goal is to determine which of the features at hand have the highest
dependence with the data. To achieve that, we follow the steps below:

#### Step 1. Data wrangling:

- Clean missing and null values (for simplicity, we simply removed the
missing values for the features we used)
- Identify and remove outliers (removed top and bottom 2.5% quantile)
- Convert the price column into a categorical variable with three
levels: **high**, **median** and **low**. This will be our response variable.

Script: [src/clean_data.R](src/clean_data.R)  
Usage (all commands should be run from the root directory):  
`Rscript src/clean_data.R data/amsterdam_listings.csv data/amsterdam_clean_listings.csv`

#### Step 2. Exploratory Data Analysis

- Generate scatter plots to assess the relationship of multiple features and
the response variable

Script: [src/exploratory_analysis.R](src/exploratory_analysis.R)  
Usage:
`Rscript src/exploratory_analysis.R data/amsterdam_clean_listings.csv amsterdam`

#### Step 3. Decision Tree classification:

- Separate the dataset into training and testing datasets
- Feature vectors are `minimum_nights`, `number_of_reviews`, `calculated_host_listings`, `availability_365` and `room_type_num`
- This pre-selection of features was carried out based on the context - some
variables are just a mathematical transformation of another (`number_of_reviews` and `reviews_per_month`), others just don't make much sense (`name`, `id`, etc). Also, `neighborhood`
and geographical coordinates were not included in this first version of the analysis
because their treatment wouldn't fit in our time schedule.
- Target variable is the categorical price level
- Use `scikit-learn` to build a predictive model
- Identify the most important features
- Export the model as a binary file

Script: [src/decision_tree_model.py](src/decision_tree_model.py)  
Usage:
`python src/decision_tree_model.py data/amsterdam_clean_listings.csv results/`

#### Step 4. Draw the Decision Tree

- Load the binary file of the Decision Tree
- Export an image with the drawing of the Decision Tree

Script: [src/decision_tree_exports.py](src/decision_tree_exports.py)  
Usage:
`python src/decision_tree_exports.py results/finalized_model.sav results/`

#### Step 5: Final report

To render the report:
`rmarkdown::render("doc/main_report.Rmd")`  
Report: [doc/main_report.md](doc/main_report.md)


## Usage

### Run without Docker/Make

1. Clone this repository

2. Run the following commands:

```
# Removes all unnecessary files to start the analysis from scratch
make clean

# Runs all necessary scripts in order to generate the report
make all
```

### Run with Docker

1. Install [Docker](https://www.docker.com/get-started)
2. Download and clone this repository
3. Use the command line to navigate to the root of this repo
4. type the following (filling in <Absolute Path of Repo on Your Computer> with the absolute path to the root of this project on your computer):

```
docker run --rm -e PASSWORD=test -v <Absolute Path of Repo on Your Computer>:/home/rstudio/final_report <DOCKERHUB REPO NAME, eg: ads0713132/522_airbnb_listings_amsterdam> make -C '/home/rstudio/final_report' all
```

5. To clean up the analysis type:, use the following:

```
docker run --rm -e PASSWORD=test -v <Absolute Path of Repo on Your Computer>:/home/rstudio/final_report <DOCKERHUB REPO NAME, eg: ads0713132/522_airbnb_listings_amsterdam> make -C '/home/rstudio/final_report' clean
```


## Dependencies
#### R version 3.5.1
- tidyverse 1.2.1
- here 0.1

#### Python 3.6.5
- pandas==0.23.0
- numpy==1.14.3
- scikit-learn==0.19.1
- matplotlib==2.2.2
- graphviz==0.8.4
