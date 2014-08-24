##
## Script Name : run_analysis.R
## Author      : Manuel David Pandian
## Date	       : 24-Aug-2014
## Version     : 0.1 ( Initial Write)
##
## Performs the following
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
##    for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject. 
##

## Set directory location
dsloc <- "/Users/manueldavidpandian/Downloads/UCI HAR Dataset"
wkloc <- "/Users/manueldavidpandian/get_clean_course/"

setwd(wkloc)

# Create directory
if ( !file.exists("MLAssignment")) 
{
dir.create("MLAssignment")
}

setwd(dsloc)

# read data from test directory

setwd("./test")

tst_ds <- read.table("X_test.txt",header=FALSE,sep="")
tst_label <- read.table("y_test.txt",header=FALSE,sep="")
tst_subject <- read.table("subject_test.txt",header=FALSE,sep="")

# read training data from train directory

setwd("../train")

train_ds <- read.table("X_train.txt",header=FALSE,sep="")
train_label <- read.table("y_train.txt",header=FALSE,sep="")
train_subject <- read.table("subject_train.txt",header=FALSE,sep="")

# read activity labels
# and features list
# for reference
setwd(dsloc)

actv_label <- read.table("activity_labels.txt",header=FALSE,sep="")
ds_label <- read.table("features.txt",header=FALSE,sep="")

# add names to reference datasets
names(actv_label) <- c("activity_id","activity_description")

# ------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names. 
# adding column names to test & train features dataset from features list
# ------------------------------------------------------------------------------
names(tst_ds) <- ds_label$V2
names(train_ds) <- ds_label$V2

# adding column names to test/train lables dataset 
names(tst_label) <- "activity_id"
names(train_label) <- "activity_id"

# adding column name to test/train subject dataset
names(tst_subject) <-"subject_id"
names(train_subject) <-"subject_id"

# ------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# ------------------------------------------------------------------------------

# Identifing column names containing mean and standard deviation
# and pulling necessary columns only

col_req<- c(grep("mean\\(\\)",names(tst_ds)) ,grep("std\\(\\)",names(tst_ds)) )
tst_ds_f1 <- tst_ds[,col_req]
train_ds_f1 <- train_ds[,col_req]

# Consolidating all data into single dataset
# ------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------------

test_cons <- cbind(tst_subject,tst_label,tst_ds_f1)
train_cons <- cbind(train_subject,train_label,train_ds_f1)

cons_ds <- rbind(test_cons,train_cons)

str(actv_label)
str(cons_ds)

# ------------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
# including activity description based on activity_id
# ------------------------------------------------------------------------------

m1<- merge(cons_ds,actv_label,by.x="activity_id",by.y="activity_id",all=FALSE)

# ------------------------------------------------------------------------------
# 5. Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.
# ------------------------------------------------------------------------------

m2<-aggregate(m1,by=list(m1$subject_id,m1$activity_description),FUN=mean)

##m22<-aggregate( . ~ subject_id + activity_description ,data=m1,FUN=mean)

setwd(wkloc)
setwd("./MLAssignment")
write.table(x=m1,file="merge_one.txt",row.names=FALSE)
write.table(x=m2,file="merge_two_tidy_set.txt",row.names=FALSE)
