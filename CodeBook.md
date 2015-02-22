Code book identifying variables and transformations for the Getting and Cleaning Data Course Project.
File name:  runanalysis.r

All "wd" variable names were created for filehandling:  currentwd, testwd, and trainwd, with one more for consolidated output:
consoliwd.

subjectdata -- reads data from both the test and training data into a subject field
xdata -- reads data from both the test and training data into the main data collection (561 different variables)
ydata -- reads activity data for both the test and training data

jointestdata, jointraindata --> these are the base working dataframes of each of the data sources, and each is appended with
the subject data and the activity data before processing.

headerdata -- used to apply the same header columns to both dataframes for later merging.
FullColNames -- used to clean up header columns that are appended with additional subject and activity column headers.  
  Eventually FullColNames wasn't entirely necessary but came in handy when we had to apply the "make.names" function 
  to ensure that column headings (variable names) were unique (unique = TRUE; for some reason R was identifying them
  as not unique).
  
y1 and y2 were used as intermediary data frames following the selection of the "mean" and "std" variables.
  
final_df is the dataframe used to combine the test data and the training data.  
sumdata was the transformation of the final_df through the aggregate data function, to group by activity and subject and
  calculate the means of each of these for final output.
  

