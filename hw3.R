# Original script ---------------------------------------------------------

# If you don't have tidyverse package on your machine, run the following:
# install.packages("tidyverse")
library(tidyverse)

df <- read.csv("imdb_top_1000.csv")

View(df)
glimpse(df)

df2 <- df %>% 
  rename_with(tolower) %>%
  mutate(is_drama = str_detect(genre, 'Drama')) %>%
  filter(is_drama == TRUE) %>%
  select(series_title, released_year, runtime, imdb_rating, meta_score,
         director, no_of_votes, gross)

df2$released_year <- as.integer(df2$released_year)
df2[is.na(df2$released_year), ] # but https://www.imdb.com/title/tt0112384/!
df2[is.na(df2$released_year), ]$released_year <- 1995

df2$runtime <- gsub(" min", "", df2$runtime)
df2$runtime <- as.integer(df2$runtime)
df2$runtime <- df2$runtime / 60
colnames(df2)[colnames(df2) == "runtime"] <- "runtime_h"

df2$meta_score <- df2$meta_score / 10

df2$gross <- gsub(",", "", df2$gross)
df2$gross <- as.integer(df2$gross)

glimpse(df2)

# What director holds the highest average IMDB rating in our dataframe?
df2 %>% group_by(director) %>% 
  summarize(mean_imdb_rating = mean(imdb_rating)) %>%
  arrange(-mean_imdb_rating)
# It is Frank Darabont!

df3 <- df2 %>%
  mutate(log_no_of_votes = log(no_of_votes),
         log_gross = log(gross)) %>%
  select(-c(no_of_votes, gross))


ggplot(df3, aes(x = log_gross)) + 
  geom_histogram(color = "magenta", fill = "blue") +
  xlab("Logarithm of gross revenue") + 
  ylab("# of movies") +
  labs(title = "Histogram of revenues of top IMDB dramas",
       subtitle = "Note that we take a log of a revenue",
       caption = "Source: Kaggle")

df_final <- df3 %>%
  mutate(is_21_century = (df3$released_year >= 2000),
         is_longer_than_2h = (df3$runtime_h >= 2)) %>%
  drop_na() # for now we simply drop the rows with NA values 

glimpse(df_final)



# Three additional graphs -------------------------------------------------

# Create scatterplot of imdb and metascore ratings
ggplot(df_final, aes(x = imdb_rating, y = meta_score)) +
  geom_point(color = "red") +               
  geom_smooth(method = "lm", color = "blue", se = TRUE) +  
  xlab("IMDb Rating") +                     
  ylab("Meta Score") +                      
  labs(title = "IMDB vs. Metascore ratings", 
       caption = "Source: Kaggle")           

# Create boxplot of top IMDb ratings for long and short movies
ggplot(df_final, aes(x = is_longer_than_2h, y = imdb_rating)) +
  geom_boxplot() +                          
  scale_x_discrete(labels = c("FALSE", "TRUE")) +  
  xlab("is_longer_than_2h") +                    
  ylab("imdb_ratingRating") +                    
  labs(title = "Boxplot of IMDb Ratings for Short and Long Movies") 

ggplot(df_final, aes(x = log_no_of_votes, fill = is_21_century)) +
  geom_density(alpha = 0.5, linewidth = 1) +  # Increase line thickness with size parameter
  scale_fill_manual(values = c("lightpink", "lightblue"), guide = FALSE) +  
  xlab("log_no_of_votes") +            
  ylab("Density") +                           
  guides(fill = guide_legend(title = "is_21_century"))
