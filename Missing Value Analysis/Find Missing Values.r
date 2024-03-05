#import from csv
csvData=read.csv("C:/Users/student/Downloads/employee_data.csv",header=TRUE, sep=",") 
csvData
csvData=edit(csvData)


install.packages("dplyr") #deep layer
library(dplyr)
salData=select(csvData,salary) #selects a coulumn
salData


#now delete some data to explore
csvData=edit(csvData)
csvData


##Missing Value Finding

#now need to know if there's any missing values in our dataset
colSums(is.na(csvData)) #to check which col has how much missing values
sapply(csvData, function(x) sum(is.na(x))) #alternative of coulumn sums(colSums)

#missing value number from a coulumn
which(is.na(csvData$salary))


csvData
