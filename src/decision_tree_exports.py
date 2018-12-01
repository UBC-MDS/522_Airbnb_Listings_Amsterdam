#!/usr/bin/env python
# decision_tree_results.py

# Jielin Yu
# Nov 23 2018

#This script outputs the decision tree graph
#
# Input:
#      - results/finalized_model.sav
#
# Output:
#       - "Tree_graph"

#Usage: python src/decision_tree_exports.py results/finalized_model.sav results/

import argparse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import tree
from sklearn.model_selection import train_test_split
import pickle
from sklearn.tree import DecisionTreeClassifier
import graphviz


parser=argparse.ArgumentParser()
parser.add_argument('input_file_path', help='File path of clean data for a specific city')
parser.add_argument('output_path', help='Output file to dump the finalized model')

args = parser.parse_args()


def save_and_show_decision_tree(model,class_names = ['low', 'median', 'high'],save_file_prefix = args.output_path + "tree_graph", **kwargs):
    """
    Saves the decision tree model as a pdf
    """
    feature_cols = ['minimum_nights','number_of_reviews','calculated_host_listings_count','availability_365','room_type_num']
    dot_data = tree.export_graphviz(model, out_file=None,
                             feature_names=feature_cols,
                             class_names=class_names,
                             filled=True, rounded=True,
                             special_characters=True, **kwargs)

    graph = graphviz.Source(dot_data, format = "png")
    graph.render(save_file_prefix)
    return graph

def main():
    '''
    This function loads the model and outputs a decision tree graph.

    '''

    # set random state
    rstate = 1234

    # Get command line arguments
    input_path = args.input_file_path

    #load decision tree model that built up in the third script
    loaded_model = pickle.load(open(input_path,'rb'))
    save_and_show_decision_tree(loaded_model)

if __name__ == "__main__":
    main()
