# Note: this R script should do the following:
#    - merge TRAINING and TEST datasets into a single dataset
#    - extract only MEAN and STANDARD DEVIATION for each measurement
#    - name activity names DESCRIPTIVELY
#    - label dataset with said descriptive activity names
#    - create 2nd TIDY dataset with average of each variable
#          for each activity and each subject.


# As per the instructions, I am assuming that the Samsung data is in
# the Current Working Directory when this script is run.
# Nevertheless, the dataset can be obtained via [this link][id]
# [id]<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

#########Important!#########
#  Note: The files are fixed width files with a fixed-width of 16.
############################


# setwd("./UCI HAR Dataset")
num_subjects = 30
m = 10299
n = 561

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
                              stringsAsFactors=FALSE, sep=' ')
# Grep the relevant columns:
grep.idx <- grep(pattern='mean|std()', x=features.table$V2, ignore.case=TRUE)
relevant.cols <- features.table[grep.idx, ]




X.paths <- data.paths[1:2]
data.df <- data.frame()
for (i in X.paths){
    temp <- read.table(file=i, header=FALSE, sep="",
                   stringsAsFactors=FALSE)
    data.df <- rbind(data.df, temp)
}
data <- data.df
data <- data[, grep.idx]


# y.paths <- data.paths[3:4]
# data.df <- data.frame()
# for (i in y.paths){
#     temp <- read.table(file=i, header=FALSE, sep="",
#                    stringsAsFactors=FALSE)
#     data.df <- rbind(data.df, temp)
# }
# data <- cbind(data, data.df)


# subject.paths <- data.paths[5:6]
# data.df <- data.frame()
# for (i in subject.paths){
#     temp <- read.table(file=i, header=FALSE, sep="",
#                    stringsAsFactors=FALSE)
#     data.df <- rbind(data.df, temp)
# }
# data <- cbind(data, data.df)













# Generates "X_test" "y_test":
paste(c('X_', 'y_'), c('test'), sep='')






