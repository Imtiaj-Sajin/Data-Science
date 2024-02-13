pId<-c(3,0,6)
age=c(8,6,4)
diabetes=c("Type1","Type2","Type1")

patientData=data.frame(pId,age,diabetes)
patientData

bg=c("A+","b+","o-")

patientData$BloodGroup=bg

patientData



install.packages("tibble")
library(tibble)

g=c('M','f','f')
patientData=add_column(patientData, g, .after = 2)
patientData

newrow=c(2, 6, 'f',    'Type3',        'b+')
updatedTable=rbind(patientData,newrow)
updatedTable
