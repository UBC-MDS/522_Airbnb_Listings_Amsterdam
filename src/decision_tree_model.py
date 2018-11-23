#!/usr/bin/env python
# decision_tree_model.py
#
# This script inputs listing data and split the data to train data and test data. Then, find optimal hyper parameter to build up the best model
# We compare test data and predicted data and get a model accuracy score
# Finally, we list each features' importance to figure out two significant feature

# Dependencies: argparse, pandas, numpy, sklearn, pickle
#
# Usage: python Decision_Tree_Model.py data/[city]_clean_listings.csv [city]_finalized_model.sav

# import libraries
import argparse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import tree
from sklearn.model_selection import train_test_split
import pickle


parser=argparse.ArgumentParser()
parser.add_argument('input_file_path', help='File path of clean data for a specific city')
parser.add_argument('output_path', help='Output file to dump the finalized model')

args = parser.parse_args()

def main():

    # set random state
    rstate = 1234

    # Get command line arguments
    input_path = args.input_file_path
    output_path = args.output_path

    # Load data
    data=pd.read_csv(input_path)

    #separate features and target
    feature_cols =   ['minimum_nights','number_of_reviews','calculated_host_listings_count','availability_365','room_type_num']
    X = data.loc[:, feature_cols]
    y = data.price_level


    # Split data into test and train
    X_train, X_test, y_train, y_test = train_test_split(
     X, y, test_size=0.20,train_size=0.80)


    # Calculate best hyper parameter (max_depth) for DecisionTreeClassfier
    train_accuracy=[]
    test_accuracy=[]
    depths=range(2,13)
    for max_depth in depths:
        tree=DecisionTreeClassifier(max_depth=max_depth)
        tree.fit(X_train,y_train)
        train_accuracy.append(np.mean(y_train==tree.predict(X_train)))
        test_accuracy.append(np.mean(y_test==tree.predict(X_test)))

    depth_score_test_df = pd.DataFrame(test_accuracy, index=depths, columns=['score'])
    depth_score_test_df = depth_score_test_df.sort_values(by="score",ascending=False)
    depth_score_test_df.to_csv(output_path_0) #this should go in the decision_tree_exports script


    # Fit with best hyper parameters
    model = tree.DecisionTreeClassifier(max_depth=4)
    model.fit(X_train,y_train)

    #save the model to disk

    model_save = output_path
    pickle.dump(model,open(model_save,'wb'))


if __name__ == "__main__":
    main()
