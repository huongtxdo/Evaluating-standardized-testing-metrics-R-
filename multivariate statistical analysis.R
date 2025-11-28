data <- read.csv("study_performance.csv", row.names = NULL)
colnames(data)
head(data)

##### DATA CLEANING/TRANSFORMATION

# Map Gender: 1-male, 2-female
old_gender <- c("male", "female")
new_gender <- c(1,2)
data$gender <- new_gender[match(data$gender, old_gender)]

# Map race_ethnicity
old_race <- c("group A","group B","group C","group D","group E")
new_race <- c(1,2,3,4,5)
data$race_ethnicity <- new_race[match(data$race_ethnicity, old_race)]

# Map parental_level_of_education
old_level <- c("some high school", "high school","associate's degree","some college","bachelor's degree","master's degree")
new_level <- c(1,2,3,4,5,6)
data$parental_level_of_education <- new_level[match(data$parental_level_of_education, old_level)]

# Map lunch
old_lunch <- c("standard", "free/reduced")
new_lunch <- c(1,2)
data$lunch <- new_lunch[match(data$lunch, old_lunch)]

# Map test_preparation_course
old_test <- c("none", "completed")
new_test <- c(1,2)
data$test_preparation_course <- new_test[match(data$test_preparation_course, old_test)]

# Map scores
coded_values <- c(1,2,3,4,5,6,7,8,9,10)
breaks <- c(seq(0, 100, by = 10))
data$math_score <- cut(data$math_score, breaks = breaks, labels = coded_values, include.lowest = TRUE)
data$math_score <- as.numeric(as.character(data$math_score))
data$reading_score <- cut(data$reading_score, breaks = breaks, labels = coded_values, include.lowest = TRUE)
data$reading_score <- as.numeric(as.character(data$reading_score))
data$writing_score <- cut(data$writing_score, breaks = breaks, labels = coded_values, include.lowest = TRUE)
data$writing_score <- as.numeric(as.character(data$writing_score))

# Change column name
colnames(data) <- c('gender', 'race', 'parent', 'lunch', 'prepare', 'math', 'read','write')

##### UNIVARIATE ANALYSIS

# - (e.g., means, medians, variances, median absolute deviations, skewness, and kurtosis) 

##### BIVARIATE ANALYSIS

# Students who do well on one subject tend to do well on other subjects as well.
genders <- data[,1]
pairs(data[6:8]
      , col = c("lightblue", "pink")[genders]
      , bg = c("lightblue", "pink")[genders],
      , upper.panel = NULL
      , pch = 22)
# Students whose parents have higher level of education are not in the lowest percentage 
# Students whose parents have a master's degree score at least 40 points in all subjects
parents <- data[,3]
pairs(data[c(3,6:8)], gap=0, upper.panel = NULL)
pairs(data, gap = 0, upper.panel = NULL, pch = 22
      , col = hcl.colors(5, "Reds")[parents]
      , bg = hcl.colors(5, "Reds")[parents])

# Students with standard lunch score at least 20 points in all subjects
# They are probably in a higher income family with better support
pairs(data[c(4,6:8)], gap=0, upper.panel = NULL)
lunches <- data[,4]
pairs(data[6:8]
      , col = c("lightblue", "blue")[lunches]
      , bg = c("lightblue", "blue")[lunches],
      , upper.panel = NULL
      , pch = 22)

# Students who completed the test preparation course score at least 30 in all subjects
pairs(data[c(5:8)], gap=0, upper.panel = NULL)
prepares <- data[,5]
pairs(data[6:8]
      , col = c("lightblue", "blue")[prepares]
      , bg = c("lightblue", "blue")[prepares],
      , upper.panel = NULL
      , pch = 22)
##### 
##### 
##### 
##### 
##### 
##### 
##### 
##### MULTIVARIATE ANALYSIS

# Data is categorical => Correspondence analysis helps identify the relationships between categories
library(ca)
data_mca <- ca::mjca(data, lambda="indicator", reti=TRUE)
data_summary <- summary(data_mca)
data_summary
# Plot to see how much of the variation is explained by the components
barplot(data_summary$scree[, 3], ylim = c(0, 10),
        names.arg = paste("PC", 1:38), las = 2, xlab = "Component",
        ylab = "% of variation explained", col = "skyblue")
# The first component only explains 7.9% of the variation.
# The first 10 components are needed to explain more than 50% of the variation.

# Function for scaling values from 0 to 1 (this is for visualization purposes):
normalize <- function(x) {
  (x- min(x)) / (max(x)- min(x))}http://127.0.0.1:36255/graphics/plot_zoom_png?width=1920&height=1017

# PC 1 and 2 
qlt <- data_summary$columns[, 3]
colpcoord <- data_mca$colpcoord
data_covariates <- data_mca$colpcoord[, 1:2]
plot(data_covariates,pch = 21, asp = 1, bg = "red", cex = normalize(qlt) + 1,
     xlab = paste0("Dimension 1", " (", data_summary$scree[1, 3], "%", ")"),
     ylab = paste0("Dimension 2", " (", data_summary$scree[2, 3], "%", ")"))
arrows(rep(0, 17), rep(0, 17), data_covariates[, 1], data_covariates[, 2],
       length = 0, col = rgb(1, 0, 0, 0.25))
abline(h = 0, v = 0, lty = 3)
text(data_covariates, data_mca$levelnames, pos = 3, cex = 0.75)
# => Students perform consistently the same in all subjects.
# => The top performers (percentile 70) are of race 5 (Group E) and are children of parents with either a bachelor's or a master's degree.
# => Top performers also complete the test preparation course and have standard lunches at school.
# => Top performers (percentile 70) tend to be female students. Interestingly, the lowest performers (percentile 10) are also female.
# => Male students tend to be in the middle.

plot(data_mca, arrows = c(FALSE,FALSE),what= c("all", "all"), labels= c(0,0), map = "rowprincipal")

plot(data_mca,arrows = c(FALSE,TRUE), what= c("all","all"),
     map = "colprincipal",labels= c(0,2), cex= 0.75)

# PC 3 and 4
qlt <- data_summary$columns[, 3]
colpcoord <- data_mca$colpcoord
data_covariates <- data_mca$colpcoord[, 3:4]
plot(data_covariates,pch = 21, asp = 1, bg = "red", cex = normalize(qlt) + 1,
     xlab = paste0("Dimension 3", " (", data_summary$scree[3, 3], "%", ")"),
     ylab = paste0("Dimension 4", " (", data_summary$scree[4, 3], "%", ")"))
arrows(rep(0, 17), rep(0, 17), data_covariates[, 1], data_covariates[, 2],
       length = 0, col = rgb(1, 0, 0, 0.25))
abline(h = 0, v = 0, lty = 3)
text(data_covariates, data_mca$levelnames, pos = 3, cex = 0.75)


plot(data_mca$rowcoord[,1:2], cex= 0.5, pch= 4, asp= 1,
     col = rgb(0, 0, 1,0.1),
     xlab= paste0("Dimension1"," (",data_summary$scree[1, 3], "%",")"),
     ylab= paste0("Dimension2"," (",data_summary$scree[2, 3], "%",")"))
points(data_covariates,pch= 21,bg= "red", cex= normalize(qlt)+ 1)
arrows(rep(0, 17), rep(0, 17),data_covariates[, 1],data_covariates[,2],
       length= 0,col= rgb(1, 0,0,0.25))
abline(h= 0, v= 0, lty= 3)
text(data_covariates, data_mca$levelnames, pos = 2, cex = 1)

