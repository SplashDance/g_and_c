# Note: this R script should do the following:
#    - merge TRAINING and TEST datasets into a single dataset
#    - extract only MEAN and STANDARD DEVIATION for each measurement
#    - name activity names DESCRIPTIVELY
#    - label dataset with said descriptive activity names
#    - create 2nd TIDY dataset with average of each variable
#          for each activity and each subject.


setwd("~/Desktop/MOOCs/Coursera/Data Science/3. Getting and Cleaning Data/Course Project")


current.path <- getwd()
data.directory.main <- "UCI HAR Dataset"
path <- paste(current.path, data.directory.main, sep='/')


## PATHS to DATA FILES:
data.types <- c("test", "train")
data.files <- paste(rep(c("X", "y", "subject"), each=2), data.types, sep='_')
data.files <- paste(data.types, data.files, sep='/')
data.files <- paste(data.files, 'txt', sep='.')
# Creates the necessary 6 paths:
data.paths <- paste(path, data.files, sep='/')


# Relevant features:
features.file <- paste(path, "features.txt", sep='/')
features.table  <- read.table(file=features.file, nrows=561, 
                              stringsAsFactors=FALSE)
# This greps the relevant columns:
relevant <- grep("-mean\\(\\)|-std\\(\\)", features.table[,2])
relevant.cols <- features.table[relevant, ]


# Combines the main data:
X.paths <- data.paths[1:2]
data.df <- data.frame()
for (i in X.paths){
    temp <- read.table(file=i, header=FALSE, sep="",
                   stringsAsFactors=FALSE)
    data.df <- rbind(data.df, temp)
}
data <- data.df
data <- data[, relevant]



# Adds the "Activity" data:
y.paths <- data.paths[3:4]
data.df <- data.frame()
for (i in y.paths){
    temp <- read.table(file=i, header=FALSE, sep="",
                   stringsAsFactors=FALSE)
    data.df <- rbind(data.df, temp)
}
data <- cbind(data.df, data)

# Adds the subject data:
subject.paths <- data.paths[5:6]
data.df <- data.frame()
for (i in subject.paths){
    temp <- read.table(file=i, header=FALSE, sep="",
                   stringsAsFactors=FALSE)
    data.df <- rbind(data.df, temp)
}
data <- cbind(data.df, data)


names(data)[1] <- "subject"
names(data)[2] <- "activity"



activities <- c("walking.regular", "walking.upstairs", "walking.downstairs",
                "sitting", "standing", "laying")
data$activity <- factor(data$activity, labels=activities)
data$subject <- as.factor(data$subject)



relevant.names <- relevant.cols[, 2]
names(data)[3:68] <- relevant.names


# Melts data into long data frame
tidy_data <- melt(data)
# Casts into appropriate data frame:
tidy_data <- dcast(test, subject + activity ~ variable, mean)
