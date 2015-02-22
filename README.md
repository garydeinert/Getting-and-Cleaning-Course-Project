# Getting-and-Cleaning-Course-Project
runanalysis.R pulls down data from the UCI HAR Dataset on activity measured by subjects wearing a Samsung Galaxy 
smartphone while performing different activities.

The code first reads training data in from the website to create a basic jointraindata file, which consolidates the subject
and activity data on to the original data points.  The same is then done to creat a jointestdata file from the test dataframe.

Both separate dataframes are then selected only for column variables containing the means or standard deviations, 
using the "select-contains" functionality in R.

The two dataframes are joined with a simple rbind.  The new dataframe, final_df, is mutated to add a column that converts
activity as a number to the list of activities provided in the activity_labels.txt file from the UCI HAR Dataset.

Finally, a summary data frame "sumdata" is created by aggregating final_df by Activity and Subject according to the 
instructions.  Some additional tidying of data follows and the file is complete.


