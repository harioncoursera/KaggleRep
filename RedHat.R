setwd("C:\\Users\\hariprasadg\\Desktop\\KaggleRedHat")

library(data.table)

#Read datasets ----------------------------
people <- as.data.frame(fread('people.csv'))
act_train <- as.data.frame(fread('act_train.csv'))
act_test <- as.data.frame(fread('act_test.csv'))

#Rename the column names --------------------
colnames(act_train) <- c("people_id","activity_id","date","activity_category","p1","p2","p3","p4","p5","p6","p7","p8","p9","p10","outcome")
colnames(act_test) <- c("people_id","activity_id","date","activity_category","p1","p2","p3","p4","p5","p6","p7","p8","p9","p10")

#Merge training and test data with people data ---------------
trainingData <- merge.data.frame(people,act_train,all.y = TRUE)
testingData <- merge.data.frame(people,act_test,all.y = TRUE)

#write merged data to csv files ---------------
write.csv(trainingData,"training.csv")
write.csv(testingData,"testing.csv")

#rpart algorithm ------------------------------
library(rpart)

model <- rpart(outcome~char_1+char_2+char_3+char_4+char_5+char_6+char_7+char_8+char_9+char_11+char_12+char_13+char_14+char_15+char_16+char_17+char_18+char_19+char_20+char_21+char_22+char_23+char_24+char_25+char_26+char_27+char_28+char_29+char_30+char_31+char_32+char_33+char_34+char_35+char_36+char_37+char_38+group_1+date+activity_category+activity_id+p1+p2+p3+p4+p5+p6+p7+p8+p9+p10, data=trainingData, method="class",control=rpart.control(cp=0.001, minsplit=1000, minbucket=1000, maxdepth=5))

predictData <- predict(model,testingData,type="class")

submission <- cbind(testingData$activity_id,predictData)
colnames(submission) <- c("activity_id", "outcome")
write.csv(submission, file="submission.csv")