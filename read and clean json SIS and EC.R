library(pacman)
p_load(tidyverse, jsonlite)

getwd()

path <- "C:/Users/gmetz/OneDrive/Dokumenter/Python Scripts/EC_Reddit_CaseStudy-main/data/Categories_raw_data/provsantigun_01-01-2019_07-01-2019/provsantigun_01-01-2019_01-07-2019"
files <- dir(path, pattern = "*.json")

data <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data <- data$comments

data <- data %>%
	select(author, id, clean_text, date)

#data$pol_leaning <- 0

data_religion_vs_atheism <- data
# path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/proreligion_01-01-2021_08-01-2021/proreligion_01-01-2021_08-01-2021"
# files <- dir(path, pattern = "*.json")
#
# data_religion <- files %>%
# 	map_df(~fromJSON(file.path(path, .), flatten = TRUE))
#
# data_religion <- data_religion$posts
#
# data_religion <- data_religion %>%
# 	select(author, id, clean_text)
#
# data_religion$pol_leaning <- 1
#
# data_religion_vs_atheism <- full_join(data, data_religion)


data_religion_vs_atheism <- data_religion_vs_atheism %>%
	mutate(lessthansix = str_count(data_religion_vs_atheism$clean_text,"\\w+")<6) %>%
	filter(lessthansix == FALSE) %>%
	select(clean_text, author, id, date)

write_csv(data_religion_vs_atheism, "provsantigun1week.csv")

##-------------------------------------------------------------------------------##

path <- "C:/Users/gmetz/OneDrive/Dokumenter/Python Scripts/EC_Reddit_CaseStudy-main/data/Categories_raw_data/religionvsatheist_01-01-2019_07-01-2019/religionvsatheist_01-01-2019_01-07-2019"
files <- dir(path, pattern = "*.json")

data1 <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data1 <- data1$comments

data1 <- data1 %>%
	select(author, id, clean_text, date)

#data$pol_leaning <- 0

data_religion_vs_atheism1 <- data1

data_religion_vs_atheism1 <- data_religion_vs_atheism1 %>%
	mutate(lessthansix = str_count(data_religion_vs_atheism1$clean_text,"\\w+")<6) %>%
	filter(lessthansix == FALSE) %>%
	select(clean_text, author, id, date)

write_csv(data_religion_vs_atheism1, "rel1week.csv")
