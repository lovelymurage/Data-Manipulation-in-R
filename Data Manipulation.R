#install tidyverse library
install.packages('tidyverse')

#load tidyverse library
library(tidyverse)

setwd("C:/Users/user/Documents/R programming/Online class")

data <- read.csv("students_scores_csv.csv")
print(data)

#viewing column names
colnames(data)

#Inspecting the data
head(data)
#Structure of the data
str(data)
#summary statistics of the data
summary(data)

#Checking for missing values
colSums(is.na(data))

#Remove missing rows:
data <- drop_na(data)
#Checking for missing values
colSums(is.na(data))

#Structure of the data
str(data)
#summary statistics of the data
summary(data)

#select only a few columns but retain all rows
select_few_cols <- select(data, "first_name", "last_name","email","gender")
head(select_few_cols)

#drop email column from select_few_cols dataset
select(select_few_cols, -email)

#select all rows but only columns starting with c
select(data, starts_with('c'))


#filter records for students who want to be Software Engineer (include all columns)
filter(data, career_aspiration=='Software Engineer')

#filter all students scoring 100% in Maths
filter(data, math_score==100)


#filter students scoring 95% and above in maths but less than 50% in history
filter(data, math_score >= 95 & history_score <= 60)


#create new columns using mutate() function
data <- mutate(data, total_marks = math_score + physics_score + history_score + 
                 chemistry_score + english_score + biology_score + geography_score)
head(data)

data <- mutate(data, average_marks = total_marks/7)
data <- mutate(data, student_category = 
                 ifelse(average_marks >= 80, "Good", "Need Support"))
head(data)


#Arrange students in the order of average marks
arrange(data, average_marks)

arrange(data, desc(average_marks))

#Average_score per career_aspiration
data %>%
  group_by(career_aspiration) %>%
  summarise(Average_score = mean(average_marks, na.rm=TRUE))
#na.rm = TRUE removes the N/A errors in the output calculation for MEAN()

#Multiple summaries
data %>%
  group_by(career_aspiration) %>%
  summarise(
    Average_score = mean(average_marks, na.rm=TRUE),
    Total_Students = n()
  )

#New Dataset
sales <- data.frame(
  Product = c("A", "B", "A", "B", "A", "B"),
  Months = c("Jan", "Jan", "Feb", "Feb", "Mar", "Mar"),
  Revenue = c(10200, 12300, 15600, 20700, 8700, 19425)
)
sales

library(tidyverse)
#pivoting wider (rows into columns)
sales_new = pivot_wider(sales, names_from = Months, values_from = Revenue)
sales_new

#pivoting longer
pivot_longer(sales_new,cols = Jan:Mar,
             names_to = "Months",
             values_to = "Revenue")
