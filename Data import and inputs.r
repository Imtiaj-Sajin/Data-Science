#user input 

##readline
var1=readline(prompt="Enter any value:")
var2=readline(prompt = "enter any number:")

var2=as.integer(var2)

print(var1)
print(var2)


##scan()
x=scan()
print(x)

s=scan(what="") #scan strings
print(s)

d=scan(what=double()) #scan double
print(d)

c=scan(what=character()) #scan character
print(d)


#Entering data to dataframe
mydata=data.frame(age=numeric(0),Name=character(0),weight=numeric(0),name="")
mydata=edit(mydata)



#import from csv
csvData=read.csv("C:/Users/student/Downloads/customer.csv",header=TRUE, sep=",") #your csv file location
csvData
csvData=edit(csvData)


#add column
mydata
install.packages("tibble")
library(tibble)

g=c('M','f','f')
mydata=add_column(mydata, g, .after = 2)
mydata



#annoting datasets

mydata$g=factor(mydata$g,
                levels=c("m",'f'),
                labels = c(1,2)) #values convert to 1,2
mydata


#summery of the stucture of dataset
str(csvData)
str(mydata)

#descriptive statistics using Summery() Function
summary(mydata)
summary(csvData)

salary=read.csv("C:/Users/student/Downloads/position_salaries_dataset.csv",header=TRUE, sep=",") #your csv file location
summary(salary)


#standard deviation (column wise)
sd(salary$Salary)

#standard deviation with if numeric(column wise)
install.packages("dplyr") #deep layer
library(dplyr)

salary %>% summarise_if(is.numeric,sd)

#standard deviation (row wise)
install.packages("matrixStats")
library(matrixStats)
salary$score=rowSds(as.matrix(salary[,c(2,3)]))
salary
