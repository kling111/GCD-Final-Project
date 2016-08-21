## This run.analysis script will unzip data from a file and clean the data through the functions learned in this course.


## Create a directory, download the data, and unzip the file
if(!file.exists("./GCD Course Project"))
	{dir.create("./GCD Course Project"")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl,destfile="./GCD Course Project/data.zip")

unzip(zipfile="./GCD Course Project/data.zip",exdir="./GCD Course Project")


dir <- "./data/UCI HAR Dataset"

## Read the data files into individual variables

aTest  <- read.table(file.path(dir, "test" , "Y_test.txt" ),header = FALSE)
aTrain <- read.table(file.path(dir, "train", "Y_train.txt"),header = FALSE)

sTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
sTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

fTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
fTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

## Combine the rows using rbind()

combinedS <- rbind(sTrain, sTest)
combinedA <- rbind(aTrain, aTest)
combinedF <- rbind(fTrain, fTest)

## Give names to the columns so they are appropriate and make one large data set

fnames <- read.table(file.path(dir, "features.txt"),head=FALSE)
names(combinedF) <- fnames$V2

names(combinedS) <- "Subject"

names(combinedA)<- "Activity"

combine <- cbind(combinedS, combinedA)
large <- cbind(combinedF, combine)

## Take the names of the features with the keywords "mean()" or "std()" and subset the "large" dataset by the names that were just found

subsetFNAMES <- fnames$V2[grep("mean\\(\\)|std\\(\\)", fnames$V2)]

selected <- c(as.character(subsetFNAMES), "Activity", "Subject")
large <- subset(large, select = selected)

## ---------------------------------------------------------------

## Now read the appropriate names from file “activity_labels.txt”

actNames <- read.table(file.path(dir, "activity_labels.txt"),header = FALSE)

## Label the data set with descriptive names instead of the abbreviations used already

names(large) <- gsub("^f", "frequency", names(large))
names(large) <- gsub("BodyBody", "Body", names(large))
names(large) <- gsub("^t", "time", names(large))
names(large) <- gsub("Acc", "Accelerometer", names(large))
names(large) <- gsub("Gyro", "Gyroscope", names(large))
names(large) <- gsub("Mag", "Magnitude", names(large))


## Finally, create a second data set that will be based upon the cleaning we did throughout this function (plyr package is involved)

library(plyr)
secondLarge <- aggregate(. ~Subject + Activity, large, mean)
secondLarge <-secondLarge[order(secondLarge$Subject,secondLarge$Activity),]
write.table(secondLarge, file = "courseraGCDdataSet.txt",row.name=FALSE)

## Produce Codebook describing the variables

library(knitr)
knit2html("codebook.Rmd")

return(secondLarge)













