# Code Book for Assignment

This code book describes the Input Dataset, variables and transformations performed in creating this tidy dataset


## Background
One of the most exciting areas in all of data science right now is wearable computing.[see link](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Input Dataset Description

###HumanActivity Recognition Using Smartphones Dataset Version 1.0

Experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. 

###For each record following are provided

* Triaxial acceleration from the accelerometer (total acceleration) and
the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

### Actual Dataset includes the following

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

### Following files are available for the train and test data. 
Their descriptions are equivalent.

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt files for the Y and Z axis.
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


## Code Description

R script `run_analysis.R` performs the following

1. Reads the test data from respective locations
2. Stores the data  as Dataframe `tst_ds` , `tst_label` and `tst_subject`.
3. Reads the training data  from respective locations
4. Stores the data  as Dataframe `train_ds` , `train_label` and `train_subject`.
5. Reads the activity label from `activity_labels.txt` into Dataframe `actv_label`.
6. Reads the features label from `features.txt` into Dataframe `ds_label`.
7. Adds appropriate column name to `actv_label`
8. Extracts column name stored in `ds_label$V2` and applies it to `tst_ds` and `train_ds`.
9. Adds `activity_id` label to `tst_label` and `train_label` dataframe.
10. Adds `subject_id` label to `tst_subject` and `train_subject` dataframe.
11. Identify column names containing `mean` and `std` and retain these columns from features dataset
12. Consolidates all Training dataset `Features`, `Activity` and `Subject` into singe dataset
13. Consolidates all Test dataset `Features`, `Activity` and `Subject` into singe dataset
14. Combine Test and Training dataset as one single dataset `cons_ds`
15. Include Activity Description from `actv_label` based on `activity_id` of `cons_ds`
16. Export as File `merge_one.txt`
17. Creates a Tidy dataset `m2` by calculating means of features for each Activity and Subject
18. Export as File `merge_two_tidy_set.txt`

## End of Code Book . Copyright Manuel David Pandian.