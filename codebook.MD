## Getting and Cleaning Data Project

### Description
Additonal information about the projects and the detailed steps taken.


### Section 1. There were a lot of files in the zip file, but only a handful were actually used to merge into a large data set:

- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

## Section 2. In this section, I extracted only the measurements for mean and standard deviation. To do this, I read throught the appropriate table looking for keywords such as "mean()" or "std()".

## Section 3. This section requires you to find the descriptive activity names and subset them.
For this I read through the text file "activity_labels.txt" and looked for the appropriate names.

## Section 4. Appropriately label the data set with descriptive activity names.
Because many abbreviations and shortcuts are used in the names, I used the gsub method to find these abbreviations and replace them with more appropriate, descriptive names.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
In order to create this second data set, I loaded the plyr package and use functions such as aggregate() and order() to make this independent tidy data set. I then used the write.table() function to make the actual text file I would later turn into Coursera.
