# run_all.sh

###################################################
## Date: 2018 Nov 24
## Author: Jielin Yu
## Script purpose: This driver script completes the data analysis of the project.
##                 This script takes no arguments.
## Usage: bash run_all.sh
##################################################

# step 1
Rscript src/clean_data.R data/amsterdam_listings.csv data/amsterdam_clean_listings.csv

# step 2
Rscript src/exploratory_analysis.R data/amsterdam_clean_listings.csv amsterdam


# step 3
python src/decision_tree_model.py data/amsterdam_clean_listings.csv results/

# step 4
python src/decision_tree_exports.py results/finalized_model.sav results/


# step 5 make report
Rscript -e "rmarkdown::render('./doc/main_report.Rmd','github_document')"
