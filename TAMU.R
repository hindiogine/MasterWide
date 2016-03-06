# Load libraries
require(xlsx)
require(dplyr)
require(ggplot2)
require(reshape2)
require(likert)

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
raw_data <- na.omit(temp)
rm(temp)

# Shorten column names (predictors). 
data_pre <- data.frame(Condition = raw_data$Condition.Name,
                            School    = raw_data$School,
                            Class     = raw_data$Class,
                            problem1_opt_1 = as.character(raw_data$Pre.Test.LT_problem1_option1),
                            problem1_opt_2 = as.character(raw_data$Pre.Test.LT_problem1_option2),
                            problem1_opt_3 = as.character(raw_data$Pre.Test.LT_problem1_option3),
                            problem1_opt_4 = as.character(raw_data$Pre.Test.LT_problem1_option4),
                            problem1_opt_5 = as.character(raw_data$Pre.Test.LT_problem1_option5),
                            problem1_opt_6 = as.character(raw_data$Pre.Test.LT_problem1_option6),
                            problem2_opt_1 = as.character(raw_data$Pre.Test.LT_problem2_option1),
                            problem2_opt_2 = as.character(raw_data$Pre.Test.LT_problem2_option2),
                            problem2_opt_3 = as.character(raw_data$Pre.Test.LT_problem2_option3),
                            problem2_opt_4 = as.character(raw_data$Pre.Test.LT_problem2_option4),
                            problem2_opt_5 = as.character(raw_data$Pre.Test.LT_problem2_option5),
                            problem2_opt_6 = as.character(raw_data$Pre.Test.LT_problem2_option6),
                            eq_problem1    = as.character(raw_data$Pre.Test.eq_problem1_box),
                            eq_problem2    = as.character(raw_data$Pre.Test.eq_problem2_box),
                            eq_problem3    = as.character(raw_data$Pre.Test.eq_problem3_box),
                            eq_problem4    = as.character(raw_data$Pre.Test.eq_problem4_box),
                            eq_problem5    = as.character(raw_data$Pre.Test.eq_problem5_box),
                            eq_problem6    = as.character(raw_data$Pre.Test.eq_problem6_box),
                            eq_problem7    = as.character(raw_data$Pre.Test.eq_problem7_box),
                            eq_problem8    = as.character(raw_data$Pre.Test.eq_problem8_box),
                            eq_problem9    = as.character(raw_data$Pre.Test.eq_problem9_box))

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
data_post <- data.frame(Condition = raw_data$Condition.Name,
                        School    = raw_data$School,
                        Class     = raw_data$Class,
                        problem1_opt_1 = as.character(raw_data$Post.Test.LT_problem1_option1),
                        problem1_opt_2 = as.character(raw_data$Post.Test.LT_problem1_option2),
                        problem1_opt_3 = as.character(raw_data$Post.Test.LT_problem1_option3),
                        problem1_opt_4 = as.character(raw_data$Post.Test.LT_problem1_option4),
                        problem1_opt_5 = as.character(raw_data$Post.Test.LT_problem1_option5),
                        problem1_opt_6 = as.character(raw_data$Post.Test.LT_problem1_option6),
                        problem2_opt_1 = as.character(raw_data$Post.Test.LT_problem2_option1),
                        problem2_opt_2 = as.character(raw_data$Post.Test.LT_problem2_option2),
                        problem2_opt_3 = as.character(raw_data$Post.Test.LT_problem2_option3),
                        problem2_opt_4 = as.character(raw_data$Post.Test.LT_problem2_option4),
                        problem2_opt_5 = as.character(raw_data$Post.Test.LT_problem2_option5),
                        problem2_opt_6 = as.character(raw_data$Post.Test.LT_problem2_option6),
                        eq_problem1    = as.character(raw_data$Post.Test.eq_problem1_box),
                        eq_problem2    = as.character(raw_data$Post.Test.eq_problem2_box),
                        eq_problem3    = as.character(raw_data$Post.Test.eq_problem3_box),
                        eq_problem4    = as.character(raw_data$Post.Test.eq_problem4_box),
                        eq_problem5    = as.character(raw_data$Post.Test.eq_problem5_box),
                        eq_problem6    = as.character(raw_data$Post.Test.eq_problem6_box),
                        eq_problem7    = as.character(raw_data$Post.Test.eq_problem7_box),
                        eq_problem8    = as.character(raw_data$Post.Test.eq_problem8_box),
                        eq_problem9    = as.character(raw_data$Post.Test.eq_problem9_box))

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






# Create heatmaps for different levels of aggregation.  We start with the conditions "MetaTutor", "MetaTutorC", and "MetaTutorMC"
# and keep only the column for conditions
#
# temp_pre_metatutor   = filter(data_pre, Condition == "MetaTutor")
# temp_pre_metatutorc  = filter(data_pre, Condition == "MetaTutorC")
# temp_pre_metatutormc = filter(data_pre, Condition == "MetaTutorMC")
# 
# pre_metatutor = select(temp_pre_metatutor, problem1_opt_1, problem1_opt_2, problem1_opt_3,
#                                            problem1_opt_4, problem1_opt_5, problem1_opt_6,
#                                            problem2_opt_1, problem2_opt_2, problem2_opt_3,
#                                            problem2_opt_4, problem2_opt_5, problem2_opt_6,
#                                            eq_problem1, eq_problem2, eq_problem3, eq_problem4,
#                                            eq_problem5, eq_problem6, eq_problem7)
# 
# pre_metatutorc = select(temp_pre_metatutorc, problem1_opt_1, problem1_opt_2, problem1_opt_3,
#                                              problem1_opt_4, problem1_opt_5, problem1_opt_6,
#                                              problem2_opt_1, problem2_opt_2, problem2_opt_3,
#                                              problem2_opt_4, problem2_opt_5, problem2_opt_6,
#                                              eq_problem1, eq_problem2, eq_problem3, eq_problem4,
#                                              eq_problem5, eq_problem6, eq_problem7)
# 
# pre_metatutormc = select(temp_pre_metatutormc, problem1_opt_1, problem1_opt_2, problem1_opt_3,
#                                                problem1_opt_4, problem1_opt_5, problem1_opt_6,
#                                                problem2_opt_1, problem2_opt_2, problem2_opt_3,
#                                                problem2_opt_4, problem2_opt_5, problem2_opt_6,
#                                                eq_problem1, eq_problem2, eq_problem3, eq_problem4,
#                                                eq_problem5, eq_problem6, eq_problem7)
# 
# rm(temp_pre_metatutor, temp_pre_metatutorc, temp_pre_metatutormc)
