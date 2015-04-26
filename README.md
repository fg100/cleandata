## Getting and Cleaning Data Course Project

### "run_analysis.R"

"run_analysis.R" works through following processes

* Selecting variables and editing the names
After reading "features.txt", selection of measurements on the mean and standard deviation.
Variable names were modified to tidy forms using "sub", "tolower", "gsub" functions.
* Making the activity names
After reading "activity_labels.txt", activity names were made from modifying the labels.
* Building the data set
Train set and test set were merged by using "cbind" and "rbind" function.
* Making the average data set
Tidy average data set was calculated from total data set by "ddply" function.
