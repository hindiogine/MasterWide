require(xlsx)
rm(list=ls(all=TRUE))

filename <- "MasterWide_StudyVI_TestScores_Sample.xlsx"
setwd("/home/henk/Code/MasterWide")

temp <- read.xlsx(file = filename, sheetName = "MasterWide_StudyVI_TestScores")

# Need to remove NAs.
raw_data <- na.omit(temp)
rm(temp)

data_pre <- data.frame(Condition = raw_data$Condition.Name,
                       School    = raw_data$School,
                       Class     = raw_data$Class,
                       LT_problem1_option1 = raw_data$Pre.Test.LT_problem1_option1,
                       LT_problem1_option2 = raw_data$Pre.Test.LT_problem1_option2,
                       LT_problem1_option3 = raw_data$Pre.Test.LT_problem1_option3,
                       LT_problem1_option4 = raw_data$Pre.Test.LT_problem1_option4,
                       LT_problem1_option5 = raw_data$Pre.Test.LT_problem1_option5,
                       LT_problem1_option6 = raw_data$Pre.Test.LT_problem1_option6,
                       LT_problem2_option1 = raw_data$Pre.Test.LT_problem2_option1,
                       LT_problem2_option2 = raw_data$Pre.Test.LT_problem2_option2,
                       LT_problem2_option3 = raw_data$Pre.Test.LT_problem2_option3,
                       LT_problem2_option4 = raw_data$Pre.Test.LT_problem2_option4,
                       LT_problem2_option5 = raw_data$Pre.Test.LT_problem2_option5,
                       LT_problem2_option6 = raw_data$Pre.Test.LT_problem2_option6,
                       eq_problem1_box     = raw_data$Pre.Test.eq_problem1_box,
                       eq_problem2_box     = raw_data$Pre.Test.eq_problem2_box,
                       eq_problem3_box     = raw_data$Pre.Test.eq_problem3_box,
                       eq_problem4_box     = raw_data$Pre.Test.eq_problem4_box,
                       eq_problem5_box     = raw_data$Pre.Test.eq_problem5_box,
                       eq_problem6_box     = raw_data$Pre.Test.eq_problem6_box,
                       eq_problem7_box     = raw_data$Pre.Test.eq_problem7_box)

data_post <- data.frame(Condition = raw_data$Condition.Name,
                        School    = raw_data$School,
                        Class     = raw_data$Class,
                        LT_problem1_option1 = raw_data$Post.Test.LT_problem1_option1,
                        LT_problem1_option2 = raw_data$Post.Test.LT_problem1_option2,
                        LT_problem1_option3 = raw_data$Post.Test.LT_problem1_option3,
                        LT_problem1_option4 = raw_data$Post.Test.LT_problem1_option4,
                        LT_problem1_option5 = raw_data$Post.Test.LT_problem1_option5,
                        LT_problem1_option6 = raw_data$Post.Test.LT_problem1_option6,
                        LT_problem2_option1 = raw_data$Post.Test.LT_problem2_option1,
                        LT_problem2_option2 = raw_data$Post.Test.LT_problem2_option2,
                        LT_problem2_option3 = raw_data$Post.Test.LT_problem2_option3,
                        LT_problem2_option4 = raw_data$Post.Test.LT_problem2_option4,
                        LT_problem2_option5 = raw_data$Post.Test.LT_problem2_option5,
                        LT_problem2_option6 = raw_data$Post.Test.LT_problem2_option6,
                        eq_problem1_box     = raw_data$Post.Test.eq_problem1_box,
                        eq_problem2_box     = raw_data$Post.Test.eq_problem2_box,
                        eq_problem3_box     = raw_data$Post.Test.eq_problem3_box,
                        eq_problem4_box     = raw_data$Post.Test.eq_problem4_box,
                        eq_problem5_box     = raw_data$Post.Test.eq_problem5_box,
                        eq_problem6_box     = raw_data$Post.Test.eq_problem6_box,
                        eq_problem7_box     = raw_data$Post.Test.eq_problem7_box)