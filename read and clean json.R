library(pacman)
p_load(tidyverse, jsonlite)


<<<<<<< HEAD
path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/guncontrol_01-06-2020_01-01-2021/guncontrol_01-06-2020_01-01-2021"
path2 <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/guncontrol_01-01-2016_01-01-2021/guncontrol_01-01-2016_01-01-2021"
=======
path <- "/Users/gmetz/OneDrive/Dokumenter/Python Scripts/EC_Reddit_CaseStudy-main/data/Categories_raw_data/provsantigun_01-01-2019_07-01-2019/provsantigun_01-01-2019_01-07-2019"
>>>>>>> 48f557245d5523a98e7e599f932bdeae3dafe34e
files <- dir(path, pattern = "*.json")
files2 <- dir(path2, pattern = "*.json")


data <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data <- data$comments

#data <- data %>%
#	select(author, id, clean_text, subreddit)


data$pol_leaning <- case_when(
	data$subreddit == "guncontrol" ~ "anti",
	data$subreddit == "liberalgunowners" ~ "pro",
	data$subreddit == "progun" ~ "pro"
)

data2 <- files2 %>%
	map_df(~fromJSON(file.path(path2, .), flatten = TRUE))

data2 <- data2$comments

data2 <-  data2  %>%
	mutate(pol_leaning ="anti")


data_comb <- rbind(data,data2)
data_comb <- data_comb %>%
	select(-time_period) %>%
	distinct()


data_comb <- data_comb %>%
	select(author, id, clean_text, subreddit, pol_leaning)





<<<<<<< HEAD


path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/proreligion_01-01-2021_08-01-2021/proreligion_01-01-2021_08-01-2021"
files <- dir(path, pattern = "*.json")

data_religion <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data_religion <- data_religion$comments

data_religion <- data_religion %>%
	select(author, id, clean_text)

data_religion$pol_leaning <- 1

data_religion_vs_atheism <- full_join(data, data_religion)
=======
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
>>>>>>> 48f557245d5523a98e7e599f932bdeae3dafe34e


data_proantiguns <- data_comb %>%
	mutate(lessthansix = str_count(data_comb$clean_text,"\\w+")<6) %>%
	filter(lessthansix == FALSE) %>%
	select(author, clean_text, pol_leaning, id)

<<<<<<< HEAD
write_csv(data_proantiguns, "clean_proantiguns_6months")
=======
write_csv(data_religion_vs_atheism, "provsantigun1week.csv")
>>>>>>> 48f557245d5523a98e7e599f932bdeae3dafe34e
