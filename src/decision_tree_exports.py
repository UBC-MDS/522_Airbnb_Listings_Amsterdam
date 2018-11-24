#!/usr/bin/env python
# decision_tree_results.py

#THIS SCRIPT IS JUST A DRAFT. IT HAS TO BE COMPLETED TO WORK

#STEP 0: Capture command line arguments. remember, it's only two arguments: an input and an output.
# See how I did in the exploratory_analysis, I think it's a good way to go when we have multiple outputs.

def main():

    #STEP 1: load machine learning model that was exported from decision_tree_model.property.property




    #STEP2: Export prediction table

    #Compare y_test and predicted y
    predictions = model.predict(X_test)
    pred = y_test.to_frame()
    pred['prediction'] = predictions
    pred.to_csv(output_path_2)

    #STEP 3: Export prediction score and most important features.
    # I think it's fine to do it in one single file.

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


    # STEP 4: Export drawing of the Decision Tree



if __name__ == "__main__":
    main()
