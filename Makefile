
# Makefile
# author: Jielin Yu / Gabriel Bogo
# Date: 2018 Nov 29

# Usage example: make <Filename>
# or  					 make all
#	or						 make clean

# Run all targets
.PHONY: all
all : doc/main_report.md out.png

# Step 1 - clean data
data/amsterdam_clean_listings.csv: data/amsterdam_listings.csv src/clean_data.R
		Rscript src/clean_data.R data/amsterdam_listings.csv $@

# step 2 - Exploratory data analysis
results/exploratory*: src/exploratory_analysis.R data/amsterdam_clean_listings.csv
		Rscript $^ amsterdam

# step 3 - Build decision tree model
results/finalized_model.sav results/importance_df.csv results/model_score.csv results/pred.csv: data/amsterdam_clean_listings.csv src/decision_tree_model.py
		python src/decision_tree_model.py data/amsterdam_clean_listings.csv results/

# step 4 - Export decision tree png
results/tree_graph.png: results/finalized_model.sav src/decision_tree_exports.py
		python src/decision_tree_exports.py results/finalized_model.sav results/

# step 5 - Render Markdown file to generate project report
doc/main_report.md: doc/main_report.Rmd \
										data/amsterdam_clean_listings.csv \
										results/exploratory* \
										results/finalized_model.sav \
										results/importance_df.csv \
										results/model_score.csv \
										results/pred.csv \
										results/tree_graph.png
		Rscript -e "rmarkdown::render('./doc/main_report.Rmd','github_document')"

# step 6 - Create dependence diagram
out.png: Makefile
		make -Bnd | make2graph > output.dot
		make -Bnd | make2graph | dot -Tpng -o out.png
		make -Bnd | make2graph --format x > output.xml

# Remove all files
.PHONY : clean
clean :
		rm -f data/amsterdam_clean_listings.csv
		rm -f results/*
		rm -f doc/main_report.md doc/main_report.html
		rm -f output.dot
		rm -f out.png
		rm -f output.xml
