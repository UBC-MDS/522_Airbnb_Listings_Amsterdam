Main Report
================

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
str(data)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    19930 obs. of  16 variables:
    ##  $ id                            : int  2818 3209 20168 25428 27886 28658 28871 29051 29554 31080 ...
    ##  $ name                          : chr  "Quiet Garden View Room & Super Fast WiFi" "Quiet apt near center, great view" "100%Centre-Private Floor/Bathroom-Lockable Studio" "Lovely apt in City Centre (Jordaan)" ...
    ##  $ host_id                       : int  3159 3806 59484 56142 97647 123414 124245 124245 127233 133488 ...
    ##  $ host_name                     : chr  "Daniel" "Maartje" "Alex" "Joan" ...
    ##  $ neighbourhood_group           : chr  NA NA NA NA ...
    ##  $ neighbourhood                 : chr  "Oostelijk Havengebied - Indische Buurt" "Westerpark" "Centrum-Oost" "Centrum-West" ...
    ##  $ latitude                      : num  52.4 52.4 52.4 52.4 52.4 ...
    ##  $ longitude                     : num  4.94 4.87 4.89 4.88 4.89 ...
    ##  $ room_type                     : chr  "Private room" "Entire home/apt" "Private room" "Entire home/apt" ...
    ##  $ price                         : int  69 160 80 125 150 65 75 55 130 219 ...
    ##  $ minimum_nights                : int  3 4 1 14 2 3 2 2 3 3 ...
    ##  $ number_of_reviews             : int  243 42 221 1 164 426 199 367 112 32 ...
    ##  $ last_review                   : Date, format: "2018-10-01" "2018-08-29" ...
    ##  $ reviews_per_month             : num  2.1 1.08 2.11 0.12 2 4.17 2.01 3.99 1.1 0.37 ...
    ##  $ calculated_host_listings_count: int  1 1 2 2 1 2 3 3 2 1 ...
    ##  $ availability_365              : int  90 96 132 65 209 297 175 225 0 277 ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 16
    ##   .. ..$ id                            : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ name                          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ host_id                       : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ host_name                     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ neighbourhood_group           : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ neighbourhood                 : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ latitude                      : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
    ##   .. ..$ longitude                     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
    ##   .. ..$ room_type                     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ price                         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ minimum_nights                : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ number_of_reviews             : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ last_review                   :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr  "collector_date" "collector"
    ##   .. ..$ reviews_per_month             : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
    ##   .. ..$ calculated_host_listings_count: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ availability_365              : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"
