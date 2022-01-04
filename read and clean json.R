library(pacman)
p_load(tidyverse, jsonlite)


path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/religion_01-06-2020_01-01-2021/religion_01-06-2020_01-01-2021"

files <- dir(path, pattern = "*.json")
files2 <- dir(path2, pattern = "*.json")


data <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data <- data$comments

data <- data %>%
	select(author, id, clean_text, subreddit)


data$pol_leaning <- case_when(
	data$subreddit == "atheism" ~ "anti",
	data$subreddit == "Catholicism" ~ "pro",
	data$subreddit == "Christianity" ~ "pro",
	data$subreddit == "Buddhism" ~ "pro",
	data$subreddit == "islam" ~ "pro",
	data$subreddit == "hinduism" ~ "pro",
	data$subreddit == "Trueatheism" ~ "anti",
	data$subreddit == "Antitheism" ~ "anti"
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





# path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/proreligion_01-01-2021_08-01-2021/proreligion_01-01-2021_08-01-2021"
# files <- dir(path, pattern = "*.json")
#
# data_religion <- files %>%
# 	map_df(~fromJSON(file.path(path, .), flatten = TRUE))
#
# data_religion <- data_religion$comments
#
# data_religion <- data_religion %>%
# 	select(author, id, clean_text)
#
# data_religion$pol_leaning <- 1
#
# data_religion_vs_atheism <- full_join(data, data_religion)
#
# #data$pol_leaning <- 0
#
# data_religion_vs_atheism <- data
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



data_atheismvsreligion <- data %>%
	mutate(lessthansix = str_count(data$clean_text,"\\w+")<6) %>%
	filter(lessthansix == FALSE) %>%
	select(author, clean_text, pol_leaning, id)


# data_religion_vs_atheism <- data_religion_vs_atheism %>%
# 	mutate(lessthansix = str_count(data_religion_vs_atheism$clean_text,"\\w+")<6) %>%
# 	filter(lessthansix == FALSE) %>%
# 	select(author, clean_text, pol_leaning, id)

write_csv(data_atheismvsreligion, "clean_atheismvsreligion_6months")
#write_csv(data_religion_vs_atheism, "provsantigun1week.csv")
#write_csv(data_religion_vs_atheism, "provsantigun1week.csv")
