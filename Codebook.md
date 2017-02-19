# Intro

This repo contains the script `run_analysis.R` that performs all steps required for the final project:

* First, all the similar data is merged using the `rbind()` function. By similar, we address those files having the same number of columns and referring to the same entities.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `averages_data.txt`, and uploaded to this repository.

# Variables

* The data from the downloaded files are contained in the variables `train_x`, `train_y`, `test_x`, `test_y`, `subject_train` and `subject_test`.
* The previous data is merged into `data_x`, `data_y` and `subject_data`. 
* `all_features` contains the correct names for the `data_x` dataset, which are applied to the column names stored in `relevant_features`
* `activities` contains the activities names
* `x_data`, `y_data` and `subject_data` are merged into a big dataset `data_all`.
* The last step returns `data_mean_std_data` which contains the relevant averages, latter exported to `data_mean_std.txt`.