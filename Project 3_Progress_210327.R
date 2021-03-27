library(dplyr)
library(tidyverse)

df <- read_delim("https://raw.githubusercontent.com/jhumms/DATA607/main/project-3/all-jobs.csv", delim="|")

###Separated description so that a team member can work on the natural language processing
###write.csv(df$Description, "Project3_Description-Data.csv", row.names = TRUE)

df2 <- df %>% select(-description)

#Clean up of position column
df2$position <- str_remove(df2$position, "- reed.co.uk")

#Separating the salary column
df3 <- separate(df2, salary, into = c("Min.Salary", "Max.Salary"), sep = "-")

#Extract_Numeric was a good function to extract the salary value.  Regex was not necessary
df4 <- df3 %>% mutate(Min.Salary.Lbs = extract_numeric(df3$Min.Salary))
df5 <- df4 %>% mutate(Max.Salary.Lbs = extract_numeric(df4$Max.Salary))   
  
#Was not able to figure out regex where I can identify the first space only. 
#Used '0_' to seperate text and numbers in the max.salary column
df6 <- separate(df5, Max.Salary, into = c("X1", "X2"), sep = "0 ")

df7 <- df6 %>% select(-Min.Salary, -X1)

df8 <- df7 %>% separate(X2, into = c("X3", "X4", "X5"), sep = ", ")

#Relocated, Renamed and Removed Column for workable data for analysis
df9 <- df8 %>% relocate(Min.Salary.Lbs, .after = c(2)) %>% 
  relocate(Max.Salary.Lbs, .after = c(3)) %>% 
  rename( 'Salary.Period' = c(5)) %>%
  select(-'X4', -'X5')

##Progress CSV file for team review. Data is tidy. 210325.
##write.csv(df9, "Project3_Progress_210325")
