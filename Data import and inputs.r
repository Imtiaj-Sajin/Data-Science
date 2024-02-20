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
mydata=data.frame(age=numeric(0),gender=character(0),weight=numeric(0),name="")
mydata=edit(mydata)
