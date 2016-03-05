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

data_pre$problem1_opt_1 <- factor(data_pre$problem1_opt_1, levels(data_pre$problem1_opt_1)[c(3,1,2)])
data_pre$problem1_opt_2 <- factor(data_pre$problem1_opt_1, levels(data_pre$problem1_opt_2)[c(3,1,2)])
data_pre$problem1_opt_3 <- factor(data_pre$problem1_opt_1, levels(data_pre$problem1_opt_3)[c(3,1,2)])
data_pre$problem1_opt_4 <- factor(data_pre$problem1_opt_1, levels(data_pre$problem1_opt_4)[c(3,1,2)])
data_pre$problem1_opt_5 <- factor(data_pre$problem1_opt_1, levels(data_pre$problem1_opt_5)[c(3,1,2)])
data_pre$problem1_opt_6 <- factor(data_pre$problem1_opt_1, levels(data_pre$problem1_opt_6)[c(3,1,2)])
data_pre$problem2_opt_1 <- factor(data_pre$problem2_opt_1, levels(data_pre$problem2_opt_1)[c(3,1,2)])
data_pre$problem2_opt_2 <- factor(data_pre$problem2_opt_1, levels(data_pre$problem2_opt_2)[c(3,1,2)])
data_pre$problem2_opt_3 <- factor(data_pre$problem2_opt_1, levels(data_pre$problem2_opt_3)[c(3,1,2)])
data_pre$problem2_opt_4 <- factor(data_pre$problem2_opt_1, levels(data_pre$problem2_opt_4)[c(3,1,2)])
data_pre$problem2_opt_5 <- factor(data_pre$problem2_opt_1, levels(data_pre$problem2_opt_5)[c(3,1,2)])
data_pre$problem2_opt_6 <- factor(data_pre$problem2_opt_1, levels(data_pre$problem2_opt_6)[c(3,1,2)])
data_pre$eq_problem1    <- factor(data_pre$eq_problem1, levels(data_pre$eq_problem1)[c(3,1,2)])
data_pre$eq_problem2    <- factor(data_pre$eq_problem2, levels(data_pre$eq_problem2)[c(3,1,2)])
data_pre$eq_problem3    <- factor(data_pre$eq_problem3, levels(data_pre$eq_problem3)[c(3,1,2)])
data_pre$eq_problem4    <- factor(data_pre$eq_problem4, levels(data_pre$eq_problem4)[c(3,1,2)])
data_pre$eq_problem5    <- factor(data_pre$eq_problem5, levels(data_pre$eq_problem5)[c(3,1,2)])
data_pre$eq_problem6    <- factor(data_pre$eq_problem6, levels(data_pre$eq_problem6)[c(3,1,2)])
data_pre$eq_problem7    <- factor(data_pre$eq_problem7, levels(data_pre$eq_problem7)[c(3,1,2)])
data_pre$eq_problem8    <- factor(data_pre$eq_problem7, levels(data_pre$eq_problem8)[c(3,1,2)])
data_pre$eq_problem9    <- factor(data_pre$eq_problem7, levels(data_pre$eq_problem9)[c(3,1,2)])

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

data_post$problem1_opt_1 <- factor(data_post$problem1_opt_1, levels(data_post$problem1_opt_1)[c(3,1,2)])
data_post$problem1_opt_2 <- factor(data_post$problem1_opt_1, levels(data_post$problem1_opt_2)[c(3,1,2)])
data_post$problem1_opt_3 <- factor(data_post$problem1_opt_1, levels(data_post$problem1_opt_3)[c(3,1,2)])
data_post$problem1_opt_4 <- factor(data_post$problem1_opt_1, levels(data_post$problem1_opt_4)[c(3,1,2)])
data_post$problem1_opt_5 <- factor(data_post$problem1_opt_1, levels(data_post$problem1_opt_5)[c(3,1,2)])
data_post$problem1_opt_6 <- factor(data_post$problem1_opt_1, levels(data_post$problem1_opt_6)[c(3,1,2)])
data_post$problem2_opt_1 <- factor(data_post$problem2_opt_1, levels(data_post$problem2_opt_1)[c(3,1,2)])
data_post$problem2_opt_2 <- factor(data_post$problem2_opt_1, levels(data_post$problem2_opt_2)[c(3,1,2)])
data_post$problem2_opt_3 <- factor(data_post$problem2_opt_1, levels(data_post$problem2_opt_3)[c(3,1,2)])
data_post$problem2_opt_4 <- factor(data_post$problem2_opt_1, levels(data_post$problem2_opt_4)[c(3,1,2)])
data_post$problem2_opt_5 <- factor(data_post$problem2_opt_1, levels(data_post$problem2_opt_5)[c(3,1,2)])
data_post$problem2_opt_6 <- factor(data_post$problem2_opt_1, levels(data_post$problem2_opt_6)[c(3,1,2)])
data_post$eq_problem1    <- factor(data_post$eq_problem1, levels(data_post$eq_problem1)[c(3,1,2)])
data_post$eq_problem2    <- factor(data_post$eq_problem2, levels(data_post$eq_problem2)[c(3,1,2)])
data_post$eq_problem3    <- factor(data_post$eq_problem3, levels(data_post$eq_problem3)[c(3,1,2)])
data_post$eq_problem4    <- factor(data_post$eq_problem4, levels(data_post$eq_problem4)[c(3,1,2)])
data_post$eq_problem5    <- factor(data_post$eq_problem5, levels(data_post$eq_problem5)[c(3,1,2)])
data_post$eq_problem6    <- factor(data_post$eq_problem6, levels(data_post$eq_problem6)[c(3,1,2)])
data_post$eq_problem7    <- factor(data_post$eq_problem7, levels(data_post$eq_problem7)[c(3,1,2)])
data_post$eq_problem8    <- factor(data_post$eq_problem7, levels(data_post$eq_problem8)[c(3,1,2)])
data_post$eq_problem9    <- factor(data_post$eq_problem7, levels(data_post$eq_problem9)[c(3,1,2)])


# data_pre <- mutate(data_pre, total = rowSums(data_pre[4:22]))
# data_pre <- mutate(data_pre, total = rowSums(data_pre[4:22]))

print(table(data_pre$Condition))
print(table(data_post$Condition))

# Convert the numbers 0, -1, and 1 to their meaning "unknown", "incorrect", and "correct".

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
