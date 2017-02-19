setwd("C:/Users/carlo/Dropbox/GitHub/datasciencecoursera/data-cleaning/week4")

library(plyr)

#lets download the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "dataset.zip")
download.file(url, f)
unzip(f)

# lets get each file data
#train
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#test
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#lets bind train, test and subject data
data_x <- rbind(train_x, test_x)
data_y <- rbind(train_y, test_y)
subject_data <- rbind(subject_train, subject_test)

#lets get all the features
all_features <- read.table("UCI HAR Dataset/features.txt")

#we only need the mean and std features, lets filter those
relevant_features <- grepl("(mean|std)", all_features[, 2])

# filter out the non relevant data
relevant_data <- data_x[, relevant_features]

# now we correct the names for relevant data
names(relevant_data) <- all_features[relevant_features, 2]

#lets get all activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# lets corrrect the activity names
data_y[, 1] <- activities[data_y[, 1], 2]

# now lets correct the data_y column name to activity
names(data_y) <- "Activity"

# correct column name
names(subject_data) <- "Subject"

# bring all data to a single data set
data_all <- cbind(relevant_data, data_y, subject_data)

# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
##############################################################################
data_mean_std <- ddply(data_all, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

#lets save the new dataset
#more efficient way
#saveRDS(data_mean_std, "data_mean_std.rds")
#required
write.table(data_mean_std, "data_mean_std.txt", row.name = FALSE)
