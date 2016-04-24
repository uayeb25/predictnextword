#install.packages("tm")
#install.packages("stringi")
#install.packages("SnowballC")
#install.packages("wordcloud")
#install.packages("slam")


setwd("Google Drive/Courses/Data Science Specialization/Capstone/")

library(stringi)
library(tm)
library(SnowballC)
library(knitr)
library(ggplot2)
library(wordcloud)
library(slam)

con <- file("final/en_US/en_US.blogs.txt", "rb")
blog_data <- readLines(con)
close(con)

con <- file("final/en_US/en_US.news.txt", "rb")
news_data <- readLines(con)
close(con)

con <- file("final/en_US/en_US.twitter.txt", "rb")
twitter_data <- readLines(con)
close(con)

##read examples 
set.seed(1)
blog_sample <- blog_data[sample(1:length(blog_data),20000)]

set.seed(1)
news_sample <- news_data[sample(1:length(news_data),20000)]

set.seed(1)
twitter_sample <- twitter_data[sample(1:length(twitter_data),20000)]

#combine 
master_sample <- c(blog_sample, news_sample, twitter_sample)
rm(blog_sample, news_sample, twitter_sample)


stats <- lapply(list(blog_data, news_data, twitter_data), function(x) stri_count_words(x))

stats  <-data.frame(
    File=c("blogs","news","twitter"), 
    t(rbind(sapply(list(blog_data, news_data, twitter_data), stri_stats_general),
            words = sapply(list(blog_data, news_data, twitter_data), stri_stats_latex)[4,])),
    WPL=rbind(summary(stats[[1]]),summary(stats[[2]]),summary(stats[[3]]))
)

print(stats)

# Convert the binary input to ASCII.
master_sample <- stri_enc_toascii(master_sample)

# Removing unsual character sequences ('\032') that could stop data parsing.
master_sample <- stri_replace_all_regex(master_sample,'\032','')
master_sample <- Corpus(VectorSource(master_sample))

# Convert and remove undesriable features using tm
master_sample <- tm_map(master_sample, content_transformer(tolower))
master_sample <- tm_map(master_sample, removePunctuation)
master_sample <- tm_map(master_sample, removeNumbers)
master_sample <- tm_map(master_sample, removeWords, stopwords("english"))
master_sample <- tm_map(master_sample, stemDocument,language = ("english"))
master_sample <- tm_map(master_sample, stripWhitespace)
master_sample <- tm_map(master_sample, PlainTextDocument)

#Display results 
word_count <- DocumentTermMatrix(master_sample, control = list(wordLengths = c(0, Inf)))

word_count$dimnames


set.seed(5000)

wordcloud(words = colnames(word_count), freq = col_sums(word_count), 
          scale = c(3, 1), max.words = 200, random.order = FALSE, rot.per = 0.35, 
          use.r.layout = FALSE, colors = brewer.pal(8, "Dark2"))
