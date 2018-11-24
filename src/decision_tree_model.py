#!/usr/bin/env python
# decision_tree_model.py
#Nov 23 2018
# This script inputs listing data and split the data to train data and test data. Then, find optimal hyper parameter to build up the best model
# We compare test data and predicted data and get a model accuracy score
# Finally, we list each features' importance to figure out two significant feature

# Dependencies: argparse, pandas, numpy, sklearn, pickle
#
# Usage: python src/decision_tree_model.py data/amsterdam_clean_listings.csv results/

# import libraries
import argparse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import tree
from sklearn.model_selection import train_test_split
import pickle
from sklearn.tree import DecisionTreeClassifier


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
    #depth_score_test_df.to_csv(output_path + 'depth_score.csv') 


    # Fit with best hyper parameters
    from sklearn import tree
    model = tree.DecisionTreeClassifier(max_depth=4)
    model.fit(X_train,y_train)

    
    #Compare y_test and predicted y
    predictions = model.predict(X_test)
    pred = y_test.to_frame()
    pred['prediction'] = predictions
    
    
    # score of test
    model_score = model.score(X_test,y_test)
    model_score=[model_score]
    model_score_df = pd.DataFrame(model_score,columns=['score'],dtype=float)
    
    # Calculate most important features
    feature_importances = model.feature_importances_
    importance_df = pd.DataFrame({"Feature":feature_cols,"Importance":feature_importances})
    importance_df = importance_df.sort_values(by="Importance",ascending=False)
    
    #save the model to disk

    model_save = output_path + "finalized_model.sav"
    pickle.dump(model,open(model_save,'wb'))
    
    
    #export the results as csv file 
    depth_score_test_df.to_csv(output_path + 'depth_score.csv')
    pred.to_csv(output_path + 'pred.csv')
    model_score_df.to_csv(output_path + 'model_score.csv')
    importance_df.to_csv(output_path + 'importance_df.csv')
    
    
    
    if __name__ == "__main__":
        main()
    
main()
    
    
    
    
    
    
    
    
 

    
