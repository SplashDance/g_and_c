# Note: this R script should do the following:
#    - merge TRAINING and TEST datasets into a single dataset
#    - extract only MEAN and STANDARD DEVIATION for each measurement
#    - name activity names DESCRIPTIVELY
#    - label dataset with said descriptive activity names
#    - create 2nd TIDY dataset with average of each variable
#          for each activity and each subject.

require(reshape2)

# setwd("~/Desktop/MOOCs/Coursera/Data Science/3. Getting and Cleaning Data/Course Project")

# PART 1 - Construct path to data sets:
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


# Part 2 - Retrieve relevant features:
# Relevant features:
features.file <- paste(path, "features.txt", sep='/')
features.table  <- read.table(file=features.file, nrows=561, 
                              stringsAsFactors=FALSE)

# This greps the relevant columns:
relevant <- grep("-mean\\(\\)|-std\\(\\)", features.table[,2])

#### Note: Previously, I had used this line of code for my "grepping":
# grep.idx <- grep(pattern='mean|std()', x=features.table$V2, ignore.case=TRUE)
#### However, I changed this to the above line as suggested by multiple 
#### students on the boards.
relevant.cols <- features.table[relevant, ]


# Part 3 - Combine data sets into a single data.frame:
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



# Part 4 - Cleaning up data names / re-classifying as "factors":
# Replaces activity integers with more descriptive names:
names(data)[1] <- "subject"
names(data)[2] <- "activity"
activities <- c("walking.regular", "walking.upstairs", "walking.downstairs",
                "sitting", "standing", "laying")
# Re-classifying the "activity" and "subject" columns as FACTORS:
data$activity <- factor(data$activity, labels=activities)
data$subject <- as.factor(data$subject)


relevant.names <- relevant.cols[, 2]
names(data)[3:68] <- relevant.names


# Part 5 - "Melting" and "Casting" -- the final step of the "tidy data" process
# Melts data into long data frame
tidy_data <- melt(data)
# Casts into appropriate data frame:
tidy_data <- dcast(tidy_data, subject + activity ~ variable, mean)



# The following line can be un-commented if a written csv file of the
# tidy data set is required:
write.table(tidy_data, file="tidy_data.txt", sep=',')
