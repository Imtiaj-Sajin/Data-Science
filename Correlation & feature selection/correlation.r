
diabetes_data <- read.csv("C:/Users/User/Downloads/diabetes.csv",header=TRUE, sep=",")

diabetes_data

summary(diabetes_data)
str(diabetes_data)

df=diabetes_data
df

PregVsGluc <- cor(df$Pregnancies, df$Glucose, method = "pearson")
print(PregVsGluc)


df1 <- subset(diabetes_data, select = -Outcome)

df1
str(df1)

pearson_result=cor(df1,method = "pearson")
pearson_result



install.packages("dplyr")
library(dplyr) 


PregnanciesVsOutcome <- aov(df$Pregnancies ~ df$Outcome)
summary(PregnanciesVsOutcome)

GlucoseVsOutcome <- aov(df$Glucose ~ df$Outcome)
summary(GlucoseVsOutcome)

BloodPressureVsOutcome <- aov(df$BloodPressure ~ df$Outcome)
summary(BloodPressureVsOutcome)

SkinThicknessVsOutcome <- aov(df$SkinThickness ~ df$Outcome)
summary(SkinThicknessVsOutcome)

InsulinVsOutcome <- aov(df$Insulin ~ df$Outcome)
summary(InsulinVsOutcome)

BMIvsOutcome <- aov(df$BMI ~ df$Outcome)
summary(BMIvsOutcome)

DiabetesPedigreeFunctionVsOutcome <- aov(df$DiabetesPedigreeFunction ~ df$Outcome)
summary(DiabetesPedigreeFunctionVsOutcome)

AgeVsOutcome <- aov(df$Age ~ df$Outcome)
summary(AgeVsOutcome)












p_values_outcome <- c(
  summary(PregnanciesVsOutcome)[[1]]$`Pr(>F)`[1],
  summary(GlucoseVsOutcome)[[1]]$`Pr(>F)`[1],
  summary(BloodPressureVsOutcome)[[1]]$`Pr(>F)`[1],
  summary(SkinThicknessVsOutcome)[[1]]$`Pr(>F)`[1],
  summary(InsulinVsOutcome)[[1]]$`Pr(>F)`[1],
  summary(BMIvsOutcome)[[1]]$`Pr(>F)`[1],
  summary(DiabetesPedigreeFunctionVsOutcome)[[1]]$`Pr(>F)`[1],
  summary(AgeVsOutcome)[[1]]$`Pr(>F)`[1]
)



anova_result <- data.frame(Attribute = c("Pregnancies", "Glucose", "BloodPressure", "SkinThickness", "Insulin", "BMI", "DiabetesPedigreeFunction", "Age"),
                           P_Value_Outcome = p_values_outcome)

anova_result
