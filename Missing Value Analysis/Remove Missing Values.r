#import from csv
csvData=read.csv("C:/Users/student/Downloads/loan_data_test.csv",header=TRUE, sep=",") 
csvData
csvData=edit(csvData)

myData=csvData


#delete missing value by omit
remove=na.omit(myData) #(delete all rows where data is NULL)

myData[myData=='']=NA #to remove catagorical values

remove=na.omit(myData) 
