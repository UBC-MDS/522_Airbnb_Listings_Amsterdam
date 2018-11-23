
# coding: utf-8

# In[ ]:


#!/usr/bin/env python 
# Decision_Tree_Model.py 
# Jielin Yu, Oct 2016
#
# This script inputs listing data and split the data to train data and test #data. Then, find optimal hyper parameter to build up the best model 
#We compare test data and predicted data and get a model accuracy score
# Finally, we list each features' importance to figure out two significant feature

# Dependencies: argparse, pandas, numpy, sklearn, pickle 
#
# Usage: python Decision_Tree_Model.py data/clean_listings.csv results/depth_score.csv results/finalized_model.sav results/pred.csv results/model_score.csv results/importance_df.csv

# import libraries
import argparse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import tree 
from sklearn.model_selection import train_test_split 
import pickle 

def get_args():
    parser=argparse.ArgumentParser()
    parser.add_argument('file_path', help='Data file path')
    parser.add_argument('output_path_0', help='Output file path 0')
    parser.add_argument('output_path_1', help='Output file path 1')
    parser.add_argument('output_path_2', help='Output file path 2')
    parser.add_argument('output_path_3', help='Output file path 3')
    parser.add_argument('output_path_4', help='Output file path 4')
    args = parser.parse_args()
    return args.file_path, args.output_path_0,args.output_path_1,args.output_path_2,args.output_path_3,args.output_path_4

def main():
    
    # set random state
    rstate = 1234
    
    # Get command line arguments
    input_path = get_args()[0]
    output_path_0 = get_args()[1]
    output_path_1 = get_args()[2]
    output_path_2 = get_args()[3]
    output_path_3 = get_args()[4]
    output_path_4 = get_args()[5]
    
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
    depth_score_test_df.to_csv(output_path_0)
    
    
    # Fit with best hyper parameters 
    model = tree.DecisionTreeClassifier(max_depth=4)
    model.fit(X_train,y_train)
    
    #save the model to disk 
    
    model_save = output_path_1
    pickle.dump(model,open(model_save,'wb'))
    
    #Compare y_test and predicted y
    predictions = model.predict(X_test)
    pred = y_test.to_frame()
    pred['prediction'] = predictions
    pred.to_csv(output_path_2)
    
    # score of test 
    model_score = model.score(X_test,y_test)
    model_score=[model_score]
    model_score_df = pd.DataFrame(model_score,columns=['score'],dtype=float)
    model_score_df.to_csv(output_path_3)
    
    
    
    # Calculate most important features
    feature_importances = model.feature_importances_
    importance_df = pd.DataFrame({"Feature":feature_cols,"Importance":feature_importances})
    importance_df.sort_values(by="Importance",ascending=False)
    importance_df.to_csv(output_path_4)
    
    
    
    if _name_ == "_main_":
        main()
    
    
    
    
    
    
    
    
    
    