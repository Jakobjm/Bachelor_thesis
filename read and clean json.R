library(pacman)
p_load(tidyverse, jsonlite)


path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/atheism_01-01-2021_08-01-2021/atheism_01-01-2021_08-01-2021"
files <- dir(path, pattern = "*.json")

data <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data <- data$posts

data <- data %>%
	select(author, id, clean_text)

data$pol_leaning <- 0


path <- "../EC_Reddit_CaseStudy-main/data/Categories_raw_data/proreligion_01-01-2021_08-01-2021/proreligion_01-01-2021_08-01-2021"
files <- dir(path, pattern = "*.json")

data_religion <- files %>%
	map_df(~fromJSON(file.path(path, .), flatten = TRUE))

data_religion <- data_religion$posts

data_religion <- data_religion %>%
	select(author, id, clean_text)

data_religion$pol_leaning <- 1

data_religion_vs_atheism <- full_join(data, data_religion)


data_religion_vs_atheism <- data_religion_vs_atheism %>%
	mutate(lessthansix = str_count(data_religion_vs_atheism$clean_text,"\\w+")<6) %>%
	filter(lessthansix == FALSE) %>%
	select(clean_text, pol_leaning, id)

write_csv(data_religion_vs_atheism, "cleaned_atheism_religion_data_1_week")
