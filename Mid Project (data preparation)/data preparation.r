#Load

install.packages("readxl")
library(readxl)
mainData <- read_excel("E:/Coding Practice/Data Science/mid_project/maternal__mod.xlsx")
mainData
edit(mainData)



num_instances <- nrow(mainData)
num_attributes <- ncol(mainData)
cat("Number of instances (rows):", num_instances, "\n")
cat("Number of Columns:", num_attributes, "\n")

str(mainData)


actualData <- mainData[, -c((num_attributes - 2):num_attributes)]  
actualData

num_instances <- nrow(actualData)
num_attributes <- ncol(actualData)
cat("Number of instances (rows):", num_instances, "\n")
cat("Number of Attributes:", num_attributes, "\n")



summary(actualData)

na_counts <- colSums(is.na(actualData))
print(na_counts)


install.packages("ggplot2")
library(ggplot2)

na_counts_df <- data.frame(Attribute = names(na_counts), NA_Count = na_counts)

ggplot(na_counts_df, aes(x = Attribute, y = NA_Count)) +
  geom_bar(stat = "identity", fill = "red") +
  theme_minimal() +
  labs(title = "Missing Values per Attribute", x = "Attribute", y = "Number of Missing Values") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  


unique(actualData$Infection)
unique(actualData$RiskLevel)


actualData$Infection <- ifelse(substr(tolower(actualData$Infection), 1, 1) == "y", "yes",
                               ifelse(substr(tolower(actualData$Infection), 1, 1) == "n", "no",
                                      ifelse(substr(tolower(actualData$Infection), 1, 1) == "m", "moderate",
                                             NA)))

unique(actualData$Infection)

barplot(na_counts)


barplot(na_counts, names.arg = names(na_counts),
        ylab = "Number of Missing Values", col = "red",cex.names = 0.9,
        main = "Missing Values per Attribute", las =2)



# Check for negative values in all numeric columns
sapply(cleanData1, function(x) if(is.numeric(x)) any(x < 0) else NA)
# Assuming actualData is your data frame

# Loop over each column in actualData
for (col_name in names(actualData)) {
  # Check if the column is numeric
  if (is.numeric(actualData[[col_name]])) {
    # Find the indices of negative values
    negative_indices <- which(actualData[[col_name]] < 0)
    
    # If there are negative values, print their indices and column name
    if (length(negative_indices) > 0) {
      cat("Negative values found in column", col_name, "at rows:", negative_indices, "\n")
    }
  }
}

str(actualData)


actualData$Infection <- factor(actualData$Infection,
                               levels = c("yes", "moderate", "no"),
                               labels = c(1, 0.5, 0))
actualData$Infection
str(actualData)

actualData$RiskLevel <- factor(actualData$RiskLevel,
                               levels = c("high risk", "low risk", "mid risk"),
                               labels = c(1, 0, 0.5))
actualData$RiskLevel
actualData
summary(actualData)


#omit
cleanData1 <- na.omit(actualData)
na_counts <- colSums(is.na(cleanData1))
print(na_counts)
barplot(na_counts, names.arg = names(na_counts),
        ylab = "Number of Missing Values", col = "red",cex.names = 0.9,
        main = "Missing Values per Attribute", las =2)



#remove by most frequent values

cleanData2 <- actualData

mode_Infection <- names(sort(table(cleanData2$Infection), decreasing = TRUE))[1]
cleanData2$Infection[is.na(cleanData2$Infection)] <- mode_Infection

mode_RiskLevel <- names(sort(table(cleanData2$RiskLevel), decreasing = TRUE))[1]
cleanData2$RiskLevel[is.na(cleanData2$RiskLevel)] <- mode_RiskLevel
cleanData2

na_counts <- colSums(is.na(cleanData2))
print(na_counts)
barplot(na_counts, names.arg = names(na_counts),
        ylab = "Number of Missing Values", col = "red",cex.names = 0.9,
        main = "Missing Values per Attribute", las =2)


for(col_name in names(cleanData2)) {
  if(is.numeric(cleanData2[[col_name]])) {
    column_mean <- mean(cleanData2[[col_name]], na.rm = TRUE)
    
    cleanData2[[col_name]][is.na(cleanData2[[col_name]])] <- column_mean
    cleanData2[[col_name]] <- round(cleanData2[[col_name]], digits = 0)
  }
}

na_counts <- colSums(is.na(cleanData2))
print(na_counts)
barplot(na_counts, names.arg = names(na_counts),
        ylab = "Number of Missing Values", col = "red",cex.names = 0.9,
        main = "Missing Values per Attribute", las =2)

summary(cleanData2)
str(cleanData2)




######----------mean median mode
getMode <- function(v) {
  tabulated <- table(v)
  mode_value <- names(sort(tabulated, decreasing = TRUE))[1]
  return(as.numeric(mode_value)) 
}


means <- sapply(cleanData2, function(x) if(is.numeric(x)) mean(x, na.rm = TRUE) else NA)
medians <- sapply(cleanData2, function(x) if(is.numeric(x)) median(x, na.rm = TRUE) else NA)
modes <- sapply(cleanData2, function(x) if(is.numeric(x) || is.factor(x) || is.character(x)) getMode(x) else NA)

stat_values <- rbind(means, medians, modes)

row_names <- c("Mean", "Median", "Mode")
rownames(stat_values) <- row_names

barplot(stat_values, beside = TRUE, 
        col = c("green", "orange", "brown"),
        legend.text = row_names, args.legend = list(x = "topright", cex = 0.7),
        cex.names = 0.7)



#outliers------------------

boxplot(cleanData2$Age, main = "Age")
boxplot(cleanData2$Smoking, main = "Smoking" )
boxplot(cleanData2$SystolicBP, main = "SystolicBP" )
boxplot(cleanData2$DiastolicBP, main = "DiastolicBP" )
boxplot(cleanData2$BS, main = "BS")
boxplot(cleanData2$BodyTemp, main = "BodyTemp" )
boxplot(cleanData2$HeartRate, main = "HeartRate" )


#cleaning outliers----

age_mean <- round(mean(cleanData2$Age, na.rm = TRUE))
age_outliers <- boxplot.stats(cleanData2$Age)$out
age_outliers
cleanData2$Age[cleanData2$Age %in% age_outliers] <- age_mean
boxplot(cleanData2$Age, main = "Age")
age_outliers <- boxplot.stats(cleanData2$Age)$out
age_outliers


bs_mean <- round(mean(cleanData2$BS, na.rm = TRUE))
bs_outliers <- boxplot.stats(cleanData2$BS)$out
bs_outliers
cleanData2$BS[cleanData2$BS %in% bs_outliers] <- bs_mean
boxplot(cleanData2$BS, main = "BS")


bodytemp_mean <- round(mean(cleanData2$BodyTemp, na.rm = TRUE))
bodytemp_outliers <- boxplot.stats(cleanData2$BodyTemp)$out
bodytemp_outliers
table(cleanData2$BodyTemp)
bodytemp_outliers <- bodytemp_outliers[bodytemp_outliers < 0]
bodytemp_outliers
cleanData2$BodyTemp[cleanData2$BodyTemp %in% bodytemp_outliers] <- bodytemp_mean
boxplot(cleanData2$BodyTemp, main = "BodyTemp" )
table(cleanData2$BodyTemp)



#-----normalization-----

min_SystolicBP <- min(cleanData2$SystolicBP, na.rm = TRUE)
max_SystolicBP <- max(cleanData2$SystolicBP, na.rm = TRUE)

cleanData2$SystolicBP <- (cleanData2$SystolicBP - min_SystolicBP) / (max_SystolicBP - min_SystolicBP)



#convert to categorical------
outputData<- cleanData2

outputData$Infection <- factor(outputData$Infection,
                               levels = c(1, 0.5, 0),
                               labels = c("yes", "moderate", "no"))

outputData$RiskLevel <- factor(outputData$RiskLevel,
                               labels = c("high risk", "low risk", "mid risk"),
                               levels = c(1, 0, 0.5))


