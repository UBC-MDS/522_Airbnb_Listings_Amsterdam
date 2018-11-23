Main Report
================

Airbnb is Amsterdam!
--------------------

Airbnb renting has always been interesting. Some spots can be rented in higher prices, whereas other spots can only be rented in very low prices. Suppose you would like to be a host in Amsterdam, in order to be a successful host, it is a good idea to investgate the host listing data from airbnb and see what are the major factors affecting the room price. Luckily, we are going to do this job for you! We are going to analyse the host listing data in Amsterdam and find out the major factors affecting the price.

Prediction
----------

'minimum\_nights','number\_of\_reviews','calculated\_host\_listings\_count','availability\_365'

From the [Website](http://insideairbnb.com/get-the-data.html), we found the host listing data of Airbnb in Amsterdam. Before starting analyze the data, let's take a look at the data.

``` r
data=read_csv("data/listings.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   id = col_integer(),
    ##   name = col_character(),
    ##   host_id = col_integer(),
    ##   host_name = col_character(),
    ##   neighbourhood_group = col_character(),
    ##   neighbourhood = col_character(),
    ##   latitude = col_double(),
    ##   longitude = col_double(),
    ##   room_type = col_character(),
    ##   price = col_integer(),
    ##   minimum_nights = col_integer(),
    ##   number_of_reviews = col_integer(),
    ##   last_review = col_date(format = ""),
    ##   reviews_per_month = col_double(),
    ##   calculated_host_listings_count = col_integer(),
    ##   availability_365 = col_integer()
    ## )

``` r
head(data)
```

    ## # A tibble: 6 x 16
    ##      id name  host_id host_name neighbourhood_g… neighbourhood latitude
    ##   <int> <chr>   <int> <chr>     <chr>            <chr>            <dbl>
    ## 1  2818 Quie…    3159 Daniel    <NA>             Oostelijk Ha…     52.4
    ## 2  3209 Quie…    3806 Maartje   <NA>             Westerpark        52.4
    ## 3 20168 100%…   59484 Alex      <NA>             Centrum-Oost      52.4
    ## 4 25428 Love…   56142 Joan      <NA>             Centrum-West      52.4
    ## 5 27886 Roma…   97647 Flip      <NA>             Centrum-West      52.4
    ## 6 28658 Cosy…  123414 Michele   <NA>             Bos en Lommer     52.4
    ## # ... with 9 more variables: longitude <dbl>, room_type <chr>,
    ## #   price <int>, minimum_nights <int>, number_of_reviews <int>,
    ## #   last_review <date>, reviews_per_month <dbl>,
    ## #   calculated_host_listings_count <int>, availability_365 <int>

From the data, we can see that there are several features inside:

-   **id**: Unique identification code for the listing
-   **name**: Descriptive name of the listing
-   **host\_id**: Unique identification code for the host
-   **host\_name**: First name of the host (privacy is respected. The data is open.)
-   **neighbourhood**: A categorical character variable that specifies the name of neighbourhood of the listing
-   **latitude**: A numeric variable that combining the **longitude** to represent the location of the listing
-   **longtitude**A numeric variable that combining the **latitude** to represent the location of the listing
-   **room\_type**: A categorical variable including **Shared Room**, **Private Room** or **Entire Room/Apt**.
-   **price**: The price of the listing.
-   **minimum\_nights**: The minimum number of nights the host requires to book their property.
-   **number\_of\_reviews**: Number of customer reviews regarding the listing.
-   **last\_review**: Date of the last review.
-   **reviews\_per\_month**: Number of customer reviews per month.
-   **calculated\_host\_listings\_count**: Number of listings each host has simultaneously.
-   **availability\_365**: The number of days that the listing is available in a 365 days, which is pre-defined by the host.

After looking at the data, we predict that **neighbourhood**, **location(latitude and longtitude)**, room\_type, minimum\_nights, number\_of\_reviews, reviews\_per\_month, calculated\_host\_listings\_count, and availability\_365 can possibly be the factors affecting the price. However, we found out neighbouhood and room\_type are categorical, which can be hard to analyze together with numeric data, so we decide to put them on the shelf at the moment. For the location, since we must combine two features (latitude and longtitude) together when analyzing(otherwise it won't make sense to use them individually), at the present, we haven't learn how to combine two features into one feature and implement it in the decision tree, we are not going to use these two features in the decision tree. However, we will demostrate how latitude and longtitude affect the price in a map later. Therefore, we can going to take a closer look to the remining factors: minimum\_nights, number\_of\_reviews, reviews\_per\_month, calculated\_host\_listings\_count, and availability\_365

neighbourhood, latitude, longitude, room\_type, price, minimum\_nights, number\_of\_reviews, reviews\_per\_month, availability\_365.
