library("dplyr")
library("reshape2")
setwd("C:/Users/Gary/Desktop/Data Science Specialzation/Course Project/UCI HAR Dataset")
currentwd <- getwd()
testwd <- paste(currentwd, "/test",sep = "")
trainwd <- paste(currentwd, "/train", sep = "")
consoliwd <- dir.create(paste(currentwd,"consolidated", sep ="/"))
consolpath <- paste(currentwd,"/consolidated", sep = "")
Activities <- c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting","Standing","Laying")

## ===========   read training data first  ================
subjectdata <- NULL
xdata <- NULL
ydata <- NULL

subjectdata <- read.table(paste(trainwd,"subject_train.txt", sep = "/"), header = FALSE)
xdata <- read.table(paste(trainwd,"X_train.txt", sep = "/"), header = FALSE)
ydata <- read.table(paste(trainwd,"Y_train.txt", sep = "/"), header = FALSE)

jointraindata <- as.data.frame(cbind(subjectdata,ydata,xdata))

## ===========  read test data next  =======================

subjectdata <- NULL
xdata <- NULL
ydata <- NULL

subjectdata <- read.table(paste(testwd,"subject_test.txt", sep = "/"), header = FALSE)
xdata <- read.table(paste(testwd,"X_test.txt", sep = "/"), header = FALSE)
ydata <- read.table(paste(testwd,"Y_test.txt", sep = "/"), header = FALSE)

jointestdata <- as.data.frame(cbind(subjectdata,ydata,xdata))

## ============ select mean and std columns for the two data frames ====================
headerdata <- NULL
activitydata <- NULL
totaltestdata <- NULL
SDmeanonly <- NULL
FinalDataCols <- NULL

headerdata <- read.table(paste(currentwd,"features.txt", sep = "/"), header = FALSE)
activitydata <- read.table(paste(currentwd,"activity_labels.txt", sep = "/"), header = FALSE)

FullColNames <- c("Subject","Activity", as.character(headerdata$V2))
FullColNames <- make.names(FullColNames, unique = TRUE)

colnames(jointestdata) <- FullColNames
colnames(jointraindata) <- FullColNames

x1 <- select(jointestdata,contains("mean"))
x2 <- select(jointestdata,contains("std"))
testfinal <- cbind(jointestdata$Subject,jointestdata$Activity,x1,x2)
colnames(testfinal)[1] <- "Subject"
colnames(testfinal)[2] <- "Activity"

y1 <- select(jointraindata, contains("mean"))
y2 <- select(jointraindata, contains("std"))
trainfinal <- cbind(jointraindata$Subject,jointraindata$Activity,y1,y2)
colnames(trainfinal)[1] <- "Subject"
colnames(trainfinal)[2] <- "Activity"

## ==== merge the two data frames, add descriptive Activity names, reorder ====
final_df <- rbind(testfinal,trainfinal)
final_df <- mutate(final_df,Activity_Name = activitydata$V2[final_df$Activity])
final_df <- final_df[,c(1,2,89,3:88)]

sumdata <- aggregate(final_df, by=list(final_df$Subject,final_df$Activity), FUN=mean, na.rm=TRUE)
sumdata <- mutate(sumdata,Activity_Name2 = activitydata$V2[sumdata$Activity])
sumdata$Activity_Name <- sumdata$Activity_Name2
sumdata <- select(sumdata, -starts_with("Group"), -Activity_Name2, -Activity)

write.table(sumdata, paste(consolpath,"activitydata.txt", sep = "/"), row.names = FALSE)
