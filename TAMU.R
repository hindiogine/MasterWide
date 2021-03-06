# Load libraries
require(xlsx)
require(dplyr)
require(ggplot2)
require(reshape2)
require(likert)
require(betareg)

# General settings
options(scipen=999)
options(show.signif.stars=FALSE)
tau <- 2 * pi
rm(list=ls(all=TRUE))

# Project specific settings
filename <- "MasterWide_StudyVI_TestScores_Sample.xlsx"
setwd("/home/henk/Code/MasterWide")

# Load data and remove NAs
temp <- read.xlsx(file = filename, sheetName = "MasterWide_StudyVI_TestScores")
data_raw <- na.omit(temp)
rm(temp)

# Shorten column names (predictors). 
data_pre <- data.frame(Condition = data_raw$Condition.Name,
#                      School    = raw_data$School,
#                      Class     = raw_data$Class,
                  problem1_opt_1 = as.character(data_raw$Pre.Test.LT_problem1_option1),
                  problem1_opt_2 = as.character(data_raw$Pre.Test.LT_problem1_option2),
                  problem1_opt_3 = as.character(data_raw$Pre.Test.LT_problem1_option3),
                  problem1_opt_4 = as.character(data_raw$Pre.Test.LT_problem1_option4),
                  problem1_opt_5 = as.character(data_raw$Pre.Test.LT_problem1_option5),
                  problem1_opt_6 = as.character(data_raw$Pre.Test.LT_problem1_option6),
                  problem2_opt_1 = as.character(data_raw$Pre.Test.LT_problem2_option1),
                  problem2_opt_2 = as.character(data_raw$Pre.Test.LT_problem2_option2),
                  problem2_opt_3 = as.character(data_raw$Pre.Test.LT_problem2_option3),
                  problem2_opt_4 = as.character(data_raw$Pre.Test.LT_problem2_option4),
                  problem2_opt_5 = as.character(data_raw$Pre.Test.LT_problem2_option5),
                  problem2_opt_6 = as.character(data_raw$Pre.Test.LT_problem2_option6),
                  eq_problem1    = as.character(data_raw$Pre.Test.eq_problem1_box),
                  eq_problem2    = as.character(data_raw$Pre.Test.eq_problem2_box),
                  eq_problem3    = as.character(data_raw$Pre.Test.eq_problem3_box),
                  eq_problem4    = as.character(data_raw$Pre.Test.eq_problem4_box),
                  eq_problem5    = as.character(data_raw$Pre.Test.eq_problem5_box),
                  eq_problem6    = as.character(data_raw$Pre.Test.eq_problem6_box),
                  eq_problem7    = as.character(data_raw$Pre.Test.eq_problem7_box),
                  eq_problem8    = as.character(data_raw$Pre.Test.eq_problem8_box),
                  eq_problem9    = as.character(data_raw$Pre.Test.eq_problem9_box),
                  stringsAsFactors = FALSE)

# Create a copy for later analysis
data_raw_pre <- data_pre

# Convert numbers to their meaning
data_pre$problem1_opt_1 <- gsub("-1","incorrect", data_pre$problem1_opt_1)
data_pre$problem1_opt_1 <- gsub("0","unknown", data_pre$problem1_opt_1)
data_pre$problem1_opt_1 <- gsub("1","correct", data_pre$problem1_opt_1)

data_pre$problem1_opt_2 <- gsub("-1","incorrect", data_pre$problem1_opt_2)
data_pre$problem1_opt_2 <- gsub("0","unknown", data_pre$problem1_opt_2)
data_pre$problem1_opt_2 <- gsub("1","correct", data_pre$problem1_opt_2)

data_pre$problem1_opt_3 <- gsub("-1","incorrect", data_pre$problem1_opt_3)
data_pre$problem1_opt_3 <- gsub("0","unknown", data_pre$problem1_opt_3)
data_pre$problem1_opt_3 <- gsub("1","correct", data_pre$problem1_opt_3)

data_pre$problem1_opt_4 <- gsub("-1","incorrect", data_pre$problem1_opt_4)
data_pre$problem1_opt_4 <- gsub("0","unknown", data_pre$problem1_opt_4)
data_pre$problem1_opt_4 <- gsub("1","correct", data_pre$problem1_opt_4)

data_pre$problem1_opt_5 <- gsub("-1","incorrect", data_pre$problem1_opt_5)
data_pre$problem1_opt_5 <- gsub("0","unknown", data_pre$problem1_opt_5)
data_pre$problem1_opt_5 <- gsub("1","correct", data_pre$problem1_opt_5)

data_pre$problem1_opt_6 <- gsub("-1","incorrect", data_pre$problem1_opt_6)
data_pre$problem1_opt_6 <- gsub("0","unknown", data_pre$problem1_opt_6)
data_pre$problem1_opt_6 <- gsub("1","correct", data_pre$problem1_opt_6)

data_pre$problem2_opt_1 <- gsub("-1","incorrect", data_pre$problem2_opt_1)
data_pre$problem2_opt_1 <- gsub("0","unknown", data_pre$problem2_opt_1)
data_pre$problem2_opt_1 <- gsub("1","correct", data_pre$problem2_opt_1)

data_pre$problem2_opt_2 <- gsub("-1","incorrect", data_pre$problem2_opt_2)
data_pre$problem2_opt_2 <- gsub("0","unknown", data_pre$problem2_opt_2)
data_pre$problem2_opt_2 <- gsub("1","correct", data_pre$problem2_opt_2)

data_pre$problem2_opt_3 <- gsub("-1","incorrect", data_pre$problem2_opt_3)
data_pre$problem2_opt_3 <- gsub("0","unknown", data_pre$problem2_opt_3)
data_pre$problem2_opt_3 <- gsub("1","correct", data_pre$problem2_opt_3)

data_pre$problem2_opt_4 <- gsub("-1","incorrect", data_pre$problem2_opt_4)
data_pre$problem2_opt_4 <- gsub("0","unknown", data_pre$problem2_opt_4)
data_pre$problem2_opt_4 <- gsub("1","correct", data_pre$problem2_opt_4)

data_pre$problem2_opt_5 <- gsub("-1","incorrect", data_pre$problem2_opt_5)
data_pre$problem2_opt_5 <- gsub("0","unknown", data_pre$problem2_opt_5)
data_pre$problem2_opt_5 <- gsub("1","correct", data_pre$problem2_opt_5)

data_pre$problem2_opt_6 <- gsub("-1","incorrect", data_pre$problem2_opt_6)
data_pre$problem2_opt_6 <- gsub("0","unknown", data_pre$problem2_opt_6)
data_pre$problem2_opt_6 <- gsub("1","correct", data_pre$problem2_opt_6)

data_pre$eq_problem1 <- gsub("-1","incorrect", data_pre$eq_problem1)
data_pre$eq_problem1 <- gsub("0","unknown", data_pre$eq_problem1)
data_pre$eq_problem1 <- gsub("1","correct", data_pre$eq_problem1)

data_pre$eq_problem2 <- gsub("-1","incorrect", data_pre$eq_problem2)
data_pre$eq_problem2 <- gsub("0","unknown", data_pre$eq_problem2)
data_pre$eq_problem2 <- gsub("1","correct", data_pre$eq_problem2)

data_pre$eq_problem3 <- gsub("-1","incorrect", data_pre$eq_problem3)
data_pre$eq_problem3 <- gsub("0","unknown", data_pre$eq_problem3)
data_pre$eq_problem3 <- gsub("1","correct", data_pre$eq_problem3)

data_pre$eq_problem4 <- gsub("-1","incorrect", data_pre$eq_problem4)
data_pre$eq_problem4 <- gsub("0","unknown", data_pre$eq_problem4)
data_pre$eq_problem4 <- gsub("1","correct", data_pre$eq_problem4)

data_pre$eq_problem5 <- gsub("-1","incorrect", data_pre$eq_problem5)
data_pre$eq_problem5 <- gsub("0","unknown", data_pre$eq_problem5)
data_pre$eq_problem5 <- gsub("1","correct", data_pre$eq_problem5)

data_pre$eq_problem6 <- gsub("-1","incorrect", data_pre$eq_problem6)
data_pre$eq_problem6 <- gsub("0","unknown", data_pre$eq_problem6)
data_pre$eq_problem6 <- gsub("1","correct", data_pre$eq_problem6)

data_pre$eq_problem7 <- gsub("-1","incorrect", data_pre$eq_problem7)
data_pre$eq_problem7 <- gsub("0","unknown", data_pre$eq_problem7)
data_pre$eq_problem7 <- gsub("1","correct", data_pre$eq_problem7)

data_pre$eq_problem8 <- gsub("-1","incorrect", data_pre$eq_problem8)
data_pre$eq_problem8 <- gsub("0","unknown", data_pre$eq_problem8)
data_pre$eq_problem8 <- gsub("1","correct", data_pre$eq_problem8)

data_pre$eq_problem9 <- gsub("-1","incorrect", data_pre$eq_problem9)
data_pre$eq_problem9 <- gsub("0","unknown", data_pre$eq_problem9)
data_pre$eq_problem9 <- gsub("1","correct", data_pre$eq_problem9)

# Convert to factor and adjust levels.
data_pre$problem1_opt_1 <- factor(data_pre$problem1_opt_1, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem1_opt_2 <- factor(data_pre$problem1_opt_2, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem1_opt_3 <- factor(data_pre$problem1_opt_3, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem1_opt_4 <- factor(data_pre$problem1_opt_4, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem1_opt_5 <- factor(data_pre$problem1_opt_5, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem1_opt_6 <- factor(data_pre$problem1_opt_6, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem2_opt_1 <- factor(data_pre$problem2_opt_1, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem2_opt_2 <- factor(data_pre$problem2_opt_2, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem2_opt_3 <- factor(data_pre$problem2_opt_3, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem2_opt_4 <- factor(data_pre$problem2_opt_4, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem2_opt_5 <- factor(data_pre$problem2_opt_5, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$problem2_opt_6 <- factor(data_pre$problem2_opt_6, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem1    <- factor(data_pre$eq_problem1, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem2    <- factor(data_pre$eq_problem2, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem3    <- factor(data_pre$eq_problem3, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem4    <- factor(data_pre$eq_problem4, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem5    <- factor(data_pre$eq_problem5, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem6    <- factor(data_pre$eq_problem6, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem7    <- factor(data_pre$eq_problem7, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem8    <- factor(data_pre$eq_problem8, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_pre$eq_problem9    <- factor(data_pre$eq_problem9, ordered=TRUE, levels = c("incorrect","unknown","correct"))
#####################################################################################################
data_post <- data.frame(Condition = data_raw$Condition.Name,
                   problem1_opt_1 = as.character(data_raw$Post.Test.LT_problem1_option1),
                   problem1_opt_2 = as.character(data_raw$Post.Test.LT_problem1_option2),
                   problem1_opt_3 = as.character(data_raw$Post.Test.LT_problem1_option3),
                   problem1_opt_4 = as.character(data_raw$Post.Test.LT_problem1_option4),
                   problem1_opt_5 = as.character(data_raw$Post.Test.LT_problem1_option5),
                   problem1_opt_6 = as.character(data_raw$Post.Test.LT_problem1_option6),
                   problem2_opt_1 = as.character(data_raw$Post.Test.LT_problem2_option1),
                   problem2_opt_2 = as.character(data_raw$Post.Test.LT_problem2_option2),
                   problem2_opt_3 = as.character(data_raw$Post.Test.LT_problem2_option3),
                   problem2_opt_4 = as.character(data_raw$Post.Test.LT_problem2_option4),
                   problem2_opt_5 = as.character(data_raw$Post.Test.LT_problem2_option5),
                   problem2_opt_6 = as.character(data_raw$Post.Test.LT_problem2_option6),
                   eq_problem1    = as.character(data_raw$Post.Test.eq_problem1_box),
                   eq_problem2    = as.character(data_raw$Post.Test.eq_problem2_box),
                   eq_problem3    = as.character(data_raw$Post.Test.eq_problem3_box),
                   eq_problem4    = as.character(data_raw$Post.Test.eq_problem4_box),
                   eq_problem5    = as.character(data_raw$Post.Test.eq_problem5_box),
                   eq_problem6    = as.character(data_raw$Post.Test.eq_problem6_box),
                   eq_problem7    = as.character(data_raw$Post.Test.eq_problem7_box),
                   eq_problem8    = as.character(data_raw$Post.Test.eq_problem8_box),
                   eq_problem9    = as.character(data_raw$Post.Test.eq_problem9_box),
                   stringsAsFactors = FALSE)

# Create a copy for later analysis
data_raw_post <- data_post

data_post$problem1_opt_1 <- gsub("-1","incorrect", data_post$problem1_opt_1)
data_post$problem1_opt_1 <- gsub("0","unknown", data_post$problem1_opt_1)
data_post$problem1_opt_1 <- gsub("1","correct", data_post$problem1_opt_1)

data_post$problem1_opt_2 <- gsub("-1","incorrect", data_post$problem1_opt_2)
data_post$problem1_opt_2 <- gsub("0","unknown", data_post$problem1_opt_2)
data_post$problem1_opt_2 <- gsub("1","correct", data_post$problem1_opt_2)

data_post$problem1_opt_3 <- gsub("-1","incorrect", data_post$problem1_opt_3)
data_post$problem1_opt_3 <- gsub("0","unknown", data_post$problem1_opt_3)
data_post$problem1_opt_3 <- gsub("1","correct", data_post$problem1_opt_3)

data_post$problem1_opt_4 <- gsub("-1","incorrect", data_post$problem1_opt_4)
data_post$problem1_opt_4 <- gsub("0","unknown", data_post$problem1_opt_4)
data_post$problem1_opt_4 <- gsub("1","correct", data_post$problem1_opt_4)

data_post$problem1_opt_5 <- gsub("-1","incorrect", data_post$problem1_opt_5)
data_post$problem1_opt_5 <- gsub("0","unknown", data_post$problem1_opt_5)
data_post$problem1_opt_5 <- gsub("1","correct", data_post$problem1_opt_5)

data_post$problem1_opt_6 <- gsub("-1","incorrect", data_post$problem1_opt_6)
data_post$problem1_opt_6 <- gsub("0","unknown", data_post$problem1_opt_6)
data_post$problem1_opt_6 <- gsub("1","correct", data_post$problem1_opt_6)

data_post$problem2_opt_1 <- gsub("-1","incorrect", data_post$problem2_opt_1)
data_post$problem2_opt_1 <- gsub("0","unknown", data_post$problem2_opt_1)
data_post$problem2_opt_1 <- gsub("1","correct", data_post$problem2_opt_1)

data_post$problem2_opt_2 <- gsub("-1","incorrect", data_post$problem2_opt_2)
data_post$problem2_opt_2 <- gsub("0","unknown", data_post$problem2_opt_2)
data_post$problem2_opt_2 <- gsub("1","correct", data_post$problem2_opt_2)

data_post$problem2_opt_3 <- gsub("-1","incorrect", data_post$problem2_opt_3)
data_post$problem2_opt_3 <- gsub("0","unknown", data_post$problem2_opt_3)
data_post$problem2_opt_3 <- gsub("1","correct", data_post$problem2_opt_3)

data_post$problem2_opt_4 <- gsub("-1","incorrect", data_post$problem2_opt_4)
data_post$problem2_opt_4 <- gsub("0","unknown", data_post$problem2_opt_4)
data_post$problem2_opt_4 <- gsub("1","correct", data_post$problem2_opt_4)

data_post$problem2_opt_5 <- gsub("-1","incorrect", data_post$problem2_opt_5)
data_post$problem2_opt_5 <- gsub("0","unknown", data_post$problem2_opt_5)
data_post$problem2_opt_5 <- gsub("1","correct", data_post$problem2_opt_5)

data_post$problem2_opt_6 <- gsub("-1","incorrect", data_post$problem2_opt_6)
data_post$problem2_opt_6 <- gsub("0","unknown", data_post$problem2_opt_6)
data_post$problem2_opt_6 <- gsub("1","correct", data_post$problem2_opt_6)

data_post$eq_problem1 <- gsub("-1","incorrect", data_post$eq_problem1)
data_post$eq_problem1 <- gsub("0","unknown", data_post$eq_problem1)
data_post$eq_problem1 <- gsub("1","correct", data_post$eq_problem1)

data_post$eq_problem2 <- gsub("-1","incorrect", data_post$eq_problem2)
data_post$eq_problem2 <- gsub("0","unknown", data_post$eq_problem2)
data_post$eq_problem2 <- gsub("1","correct", data_post$eq_problem2)

data_post$eq_problem3 <- gsub("-1","incorrect", data_post$eq_problem3)
data_post$eq_problem3 <- gsub("0","unknown", data_post$eq_problem3)
data_post$eq_problem3 <- gsub("1","correct", data_post$eq_problem3)

data_post$eq_problem4 <- gsub("-1","incorrect", data_post$eq_problem4)
data_post$eq_problem4 <- gsub("0","unknown", data_post$eq_problem4)
data_post$eq_problem4 <- gsub("1","correct", data_post$eq_problem4)

data_post$eq_problem5 <- gsub("-1","incorrect", data_post$eq_problem5)
data_post$eq_problem5 <- gsub("0","unknown", data_post$eq_problem5)
data_post$eq_problem5 <- gsub("1","correct", data_post$eq_problem5)

data_post$eq_problem6 <- gsub("-1","incorrect", data_post$eq_problem6)
data_post$eq_problem6 <- gsub("0","unknown", data_post$eq_problem6)
data_post$eq_problem6 <- gsub("1","correct", data_post$eq_problem6)

data_post$eq_problem7 <- gsub("-1","incorrect", data_post$eq_problem7)
data_post$eq_problem7 <- gsub("0","unknown", data_post$eq_problem7)
data_post$eq_problem7 <- gsub("1","correct", data_post$eq_problem7)

data_post$eq_problem8 <- gsub("-1","incorrect", data_post$eq_problem8)
data_post$eq_problem8 <- gsub("0","unknown", data_post$eq_problem8)
data_post$eq_problem8 <- gsub("1","correct", data_post$eq_problem8)

data_post$eq_problem9 <- gsub("-1","incorrect", data_post$eq_problem9)
data_post$eq_problem9 <- gsub("0","unknown", data_post$eq_problem9)
data_post$eq_problem9 <- gsub("1","correct", data_post$eq_problem9)

data_post$problem1_opt_1 <- factor(data_post$problem1_opt_1, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem1_opt_2 <- factor(data_post$problem1_opt_2, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem1_opt_3 <- factor(data_post$problem1_opt_3, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem1_opt_4 <- factor(data_post$problem1_opt_4, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem1_opt_5 <- factor(data_post$problem1_opt_5, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem1_opt_6 <- factor(data_post$problem1_opt_6, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem2_opt_1 <- factor(data_post$problem2_opt_1, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem2_opt_2 <- factor(data_post$problem2_opt_2, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem2_opt_3 <- factor(data_post$problem2_opt_3, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem2_opt_4 <- factor(data_post$problem2_opt_4, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem2_opt_5 <- factor(data_post$problem2_opt_5, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$problem2_opt_6 <- factor(data_post$problem2_opt_6, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem1    <- factor(data_post$eq_problem1, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem2    <- factor(data_post$eq_problem2, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem3    <- factor(data_post$eq_problem3, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem4    <- factor(data_post$eq_problem4, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem5    <- factor(data_post$eq_problem5, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem6    <- factor(data_post$eq_problem6, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem7    <- factor(data_post$eq_problem7, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem8    <- factor(data_post$eq_problem7, ordered=TRUE, levels = c("incorrect","unknown","correct"))
data_post$eq_problem9    <- factor(data_post$eq_problem7, ordered=TRUE, levels = c("incorrect","unknown","correct"))

# data_pre <- mutate(data_pre, total = rowSums(data_pre[4:22]))
# data_pre <- mutate(data_pre, total = rowSums(data_pre[4:22]))

print(table(data_pre$Condition))
print(table(data_post$Condition))
###########################################################################
# Create Likert objects, grouped by Condition.
# Too many rows for all items.  Break by the 3 problems.

problem_1_pre <- select(data_pre, Condition, problem1_opt_1, problem1_opt_2, problem1_opt_3,
                                             problem1_opt_4, problem1_opt_5, problem1_opt_6)
problem_1_pre_likert <- likert(problem_1_pre[2:7], grouping = problem_1_pre$Condition)
plot(problem_1_pre_likert, center=2.5, ggtitle = "Problem 1, pre-test")
ggsave(filename = "Problem_1_pre.png") 

problem_2_pre <- select(data_pre, Condition, problem2_opt_1, problem2_opt_2, problem2_opt_3,
                        problem2_opt_4, problem2_opt_5, problem2_opt_6)
problem_2_pre_likert <- likert(problem_2_pre[2:7], grouping = problem_2_pre$Condition)
plot(problem_2_pre_likert, center=2.5, ggtitle = "Problem 2, pre-test")
ggsave(filename = "Problem_2_pre.png")

eq_problem_pre <- select(data_pre, Condition, eq_problem1, eq_problem2, eq_problem3,
                         eq_problem4, eq_problem5, eq_problem6, eq_problem7, eq_problem8, eq_problem9)
eq_problem_pre_likert <- likert(eq_problem_pre[2:10], grouping = eq_problem_pre$Condition)
plot(eq_problem_pre_likert, center=2.5, ggtitle = "Eq Problem, pre-test")
ggsave(filename = "Eq_Problem_pre.png", height=10)
###################################################################################
# Test difference in proportions of correct by Condition.
# We begin by looking at the proportion of correct answers
#
# Shorten again the column names (predictors). 
data_pre_prop <- data.frame(Condition = data_raw$Condition.Name,
#                           School    = raw_data$School,
#                           Class     = raw_data$Class,
                       problem1_opt_1 = as.character(data_raw$Pre.Test.LT_problem1_option1),
                       problem1_opt_2 = as.character(data_raw$Pre.Test.LT_problem1_option2),
                       problem1_opt_3 = as.character(data_raw$Pre.Test.LT_problem1_option3),
                       problem1_opt_4 = as.character(data_raw$Pre.Test.LT_problem1_option4),
                       problem1_opt_5 = as.character(data_raw$Pre.Test.LT_problem1_option5),
                       problem1_opt_6 = as.character(data_raw$Pre.Test.LT_problem1_option6),
                       problem2_opt_1 = as.character(data_raw$Pre.Test.LT_problem2_option1),
                       problem2_opt_2 = as.character(data_raw$Pre.Test.LT_problem2_option2),
                       problem2_opt_3 = as.character(data_raw$Pre.Test.LT_problem2_option3),
                       problem2_opt_4 = as.character(data_raw$Pre.Test.LT_problem2_option4),
                       problem2_opt_5 = as.character(data_raw$Pre.Test.LT_problem2_option5),
                       problem2_opt_6 = as.character(data_raw$Pre.Test.LT_problem2_option6),
                       eq_problem1    = as.character(data_raw$Pre.Test.eq_problem1_box),
                       eq_problem2    = as.character(data_raw$Pre.Test.eq_problem2_box),
                       eq_problem3    = as.character(data_raw$Pre.Test.eq_problem3_box),
                       eq_problem4    = as.character(data_raw$Pre.Test.eq_problem4_box),
                       eq_problem5    = as.character(data_raw$Pre.Test.eq_problem5_box),
                       eq_problem6    = as.character(data_raw$Pre.Test.eq_problem6_box),
                       eq_problem7    = as.character(data_raw$Pre.Test.eq_problem7_box),
                       eq_problem8    = as.character(data_raw$Pre.Test.eq_problem8_box),
                       eq_problem9    = as.character(data_raw$Pre.Test.eq_problem9_box))

# Convert numbers to one for correct and zero otherwise
#
data_pre_prop$problem1_opt_1 <- gsub("-1","0", data_pre_prop$problem1_opt_1)
data_pre_prop$problem1_opt_2 <- gsub("-1","0", data_pre_prop$problem1_opt_2)
data_pre_prop$problem1_opt_3 <- gsub("-1","0", data_pre_prop$problem1_opt_3)
data_pre_prop$problem1_opt_4 <- gsub("-1","0", data_pre_prop$problem1_opt_4)
data_pre_prop$problem1_opt_5 <- gsub("-1","0", data_pre_prop$problem1_opt_5)
data_pre_prop$problem1_opt_6 <- gsub("-1","0", data_pre_prop$problem1_opt_6)
data_pre_prop$problem2_opt_1 <- gsub("-1","0", data_pre_prop$problem2_opt_1)
data_pre_prop$problem2_opt_2 <- gsub("-1","0", data_pre_prop$problem2_opt_2)
data_pre_prop$problem2_opt_3 <- gsub("-1","0", data_pre_prop$problem2_opt_3)
data_pre_prop$problem2_opt_4 <- gsub("-1","0", data_pre_prop$problem2_opt_4)
data_pre_prop$problem2_opt_5 <- gsub("-1","0", data_pre_prop$problem2_opt_5)
data_pre_prop$problem2_opt_6 <- gsub("-1","0", data_pre_prop$problem2_opt_6)
data_pre_prop$eq_problem1    <- gsub("-1","0", data_pre_prop$eq_problem1)
data_pre_prop$eq_problem2    <- gsub("-1","0", data_pre_prop$eq_problem2)
data_pre_prop$eq_problem3    <- gsub("-1","0", data_pre_prop$eq_problem3)
data_pre_prop$eq_problem4    <- gsub("-1","0", data_pre_prop$eq_problem4)
data_pre_prop$eq_problem5    <- gsub("-1","0", data_pre_prop$eq_problem5)
data_pre_prop$eq_problem6    <- gsub("-1","0", data_pre_prop$eq_problem6)
data_pre_prop$eq_problem7    <- gsub("-1","0", data_pre_prop$eq_problem7)
data_pre_prop$eq_problem8    <- gsub("-1","0", data_pre_prop$eq_problem8)
data_pre_prop$eq_problem9    <- gsub("-1","0", data_pre_prop$eq_problem9)

# data_pre_prop <- data.frame(data_pre$Condition, apply(data_pre_prop[2:22], 2, as.integer))
temp_1 <- sapply(data_pre_prop[, 2:22], as.numeric)
temp_2 <- data.frame(temp_1)

data_pre_prop <- cbind(data_pre_prop$Condition, temp_2)
names(data_pre_prop)[names(data_pre_prop) == 'data_pre_prop$Condition'] <- 'Condition'
rm(temp_1, temp_2)

data_pre_prop_metatutor   <- filter(data_pre_prop, Condition == "MetaTutor")
data_pre_prop_metatutorc  <- filter(data_pre_prop, Condition == "MetaTutorC")
data_pre_prop_metatutormc <- filter(data_pre_prop, Condition == "MetaTutorMC")

metatutor_sums   <- colSums(data_pre_prop_metatutor[2:22])
metatutorc_sums  <- colSums(data_pre_prop_metatutorc[2:22])
metatutormc_sums <- colSums(data_pre_prop_metatutormc[2:22])

metatutor_count   <- dim(data_pre_prop_metatutor)[1]
metatutorc_count  <- dim(data_pre_prop_metatutorc)[1]
metatutormc_count <- dim(data_pre_prop_metatutormc)[1]

metatutor_prop   <- metatutor_sums / metatutor_count
metatutorc_prop  <- metatutorc_sums / metatutorc_count
metatutormc_prop <- metatutormc_sums / metatutormc_count

temp_3 <- rbind(metatutor_prop, metatutorc_prop, metatutormc_prop)
temp_4 <- data.frame(temp_3)
Condition <- c("MetaTutor", "MetaTutorC", "MetaTutorMC")
temp_5 <- cbind(Condition, temp_4)
data_pre_proportion <- melt(temp_5, id = "Condition")
rm(temp_3, temp_4, temp_5)

beta_pre <- betareg(data=data_pre_proportion, value ~ Condition - 1, hessian = TRUE)
summary(beta_pre)

# Test of equality of proportions for each outcome variable
# This has to be done pairwise
# Compare first MetaTutor and MetaTutorC.
#
print("MetaTutor vs. MetaTutorC")
for (i in 1:21)
{
  temp_prop <- prop.test(x = c(metatutor_sums[i], metatutorc_sums[i]), n = c(metatutor_count, metatutorc_count) )
  print(names(metatutor_sums)[i])
  print(temp_prop)
}
rm(temp_prop, i)

# Then we compare Metatutor with MetaTutorMC
print("MetaTutor vs. MetaTutorMC")
for (i in 1:21)
{
  temp_prop <- prop.test(x = c(metatutor_sums[i], metatutormc_sums[i]), n = c(metatutor_count, metatutormc_count) )
  print(names(metatutor_sums)[i])
  print(temp_prop)
}
rm(temp_prop, i)

# Finally we compare MetatutorC with MetaTutorMC
print("MetaTutorC vs. MetaTutorMC")
for (i in 1:21)
{
  temp_prop <- prop.test(x = c(metatutorc_sums[i], metatutormc_sums[i]), n = c(metatutorc_count, metatutormc_count) )
  print(names(metatutor_sums)[i])
  print(temp_prop)
}
rm(temp_prop, i)
#####################################################################3
# Analysis of the effect of the treatments
# I begin by calculating a "shift" in outcome between levels.
# 
# Create dataframe with differences
shift.df <- data.frame(Condition = data_raw$Condition.Name,
                  problem1_opt_1 = factor(as.numeric(data_raw_post[,2]) - as.numeric(data_raw_pre[,2]), ordered = TRUE),
                  problem1_opt_2 = factor(as.numeric(data_raw_post[,3]) - as.numeric(data_raw_pre[,3]), ordered = TRUE),
                  problem1_opt_3 = factor(as.numeric(data_raw_post[,4]) - as.numeric(data_raw_pre[,4]), ordered = TRUE),
                  problem1_opt_4 = factor(as.numeric(data_raw_post[,5]) - as.numeric(data_raw_pre[,5]), ordered = TRUE),
                  problem1_opt_5 = factor(as.numeric(data_raw_post[,6]) - as.numeric(data_raw_pre[,6]), ordered = TRUE),
                  problem1_opt_6 = factor(as.numeric(data_raw_post[,7]) - as.numeric(data_raw_pre[,7]), ordered = TRUE),
                  problem2_opt_1 = factor(as.numeric(data_raw_post[,8]) - as.numeric(data_raw_pre[,8]), ordered = TRUE),
                  problem2_opt_2 = factor(as.numeric(data_raw_post[,9]) - as.numeric(data_raw_pre[,9]), ordered = TRUE),
                  problem2_opt_3 = factor(as.numeric(data_raw_post[,10]) - as.numeric(data_raw_pre[,10]), ordered = TRUE),
                  problem2_opt_4 = factor(as.numeric(data_raw_post[,11]) - as.numeric(data_raw_pre[,11]), ordered = TRUE),
                  problem2_opt_5 = factor(as.numeric(data_raw_post[,12]) - as.numeric(data_raw_pre[,12]), ordered = TRUE),
                  problem2_opt_6 = factor(as.numeric(data_raw_post[,13]) - as.numeric(data_raw_pre[,13]), ordered = TRUE),
                  eq_problem1    = factor(as.numeric(data_raw_post[,14]) - as.numeric(data_raw_pre[,14]), ordered = TRUE),
                  eq_problem2    = factor(as.numeric(data_raw_post[,15]) - as.numeric(data_raw_pre[,15]), ordered = TRUE),
                  eq_problem3    = factor(as.numeric(data_raw_post[,16]) - as.numeric(data_raw_pre[,16]), ordered = TRUE),
                  eq_problem4    = factor(as.numeric(data_raw_post[,17]) - as.numeric(data_raw_pre[,17]), ordered = TRUE),
                  eq_problem5    = factor(as.numeric(data_raw_post[,18]) - as.numeric(data_raw_pre[,18]), ordered = TRUE),
                  eq_problem6    = factor(as.numeric(data_raw_post[,19]) - as.numeric(data_raw_pre[,19]), ordered = TRUE),
                  eq_problem7    = factor(as.numeric(data_raw_post[,20]) - as.numeric(data_raw_pre[,20]), ordered = TRUE),
                  eq_problem8    = factor(as.numeric(data_raw_post[,21]) - as.numeric(data_raw_pre[,21]), ordered = TRUE),
                  eq_problem9    = factor(as.numeric(data_raw_post[,22]) - as.numeric(data_raw_pre[,22]), ordered = TRUE))

# We can plot these shifts as Likert objects
problem_1_shift <- select(shift.df, Condition, problem1_opt_1, problem1_opt_2, problem1_opt_3,
                                               problem1_opt_4, problem1_opt_5, problem1_opt_6)
problem_1_shift_likert <- likert(problem_1_shift[2:7], grouping = problem_1_shift$Condition)
plot(problem_1_shift_likert, center=3, ggtitle = "Problem 1, shifts")
ggsave(filename = "Problem_1_shift.png", height=6) 

problem_2_shift <- select(shift.df, Condition, problem2_opt_1, problem2_opt_2, problem2_opt_3,
                                               problem2_opt_4, problem2_opt_5, problem2_opt_6)
problem_2_shift_likert <- likert(problem_2_shift[2:7], grouping = problem_2_shift$Condition)
plot(problem_2_shift_likert, center=3, ggtitle = "Problem 2, shifts")
ggsave(filename = "Problem_2_shift.png", height=6)

eq_problem_shift <- select(shift.df, Condition, eq_problem1, eq_problem2, eq_problem3, eq_problem4,
                                                eq_problem5, eq_problem6, eq_problem7, eq_problem8, eq_problem9)
eq_problem_shift_likert <- likert(eq_problem_shift[2:10], grouping = eq_problem_shift$Condition)
plot(eq_problem_shift_likert, center=3, ggtitle = "Eq Problem, shifts")
ggsave(filename = "Eq_Problem_shift.png", height=9)

# Statistical analyses
shift_narrow <- melt(shift.df, id="Condition")
names(shift_narrow) <- c("condition", "problem_item", "score_shift")
shift_narrow[,3] <- strtoi(shift_narrow[,3])

# Bartlett test for homogeneity of variances.  It is significant for problem,
# hence we can only use ANOVA for the 3 conditions.  The null-hypothesis
# is rejected in the case of conditions (p = 0.019).
#
bartlett.test(shift_narrow$score_shift ~ shift_narrow$condition)
bartlett.test(shift_narrow$score_shift ~ shift_narrow$problem_item)

anova(lm(data=shift_narrow, score_shift ~ condition))


# As an alternative we can perform the Kruskall-Wallis test. It is significant
# for both predictors
#
kruskal.test(score_shift ~ condition, data=shift_narrow)
kruskal.test(score_shift ~ problem_item, data=shift_narrow)

# Clustering
