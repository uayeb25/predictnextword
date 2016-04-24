#install.packages("ngram")
library(ngram)



###Functions

Trim <- function( x ) {
    gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

Get_Ngrams <- function(sentence_splits, ngram_size=2) {
    ngrams <- c()
    for (sentence in sentence_splits) {
        sentence <- Trim(sentence)
       
        if ((nchar(sentence) > 0) && (sapply(gregexpr("\\W+", sentence), length) >= ngram_size)) {
            ngs <- ngram(sentence , n=ngram_size)
            ngrams <- c(ngrams, get.ngrams(ngs))
        }
    }
    return (ngrams)
}

Text_To_Clean_Sentences <- function(text_blob) {
    # swap all sentence ends with code 'ootoo'
    text_blob <- gsub(pattern=';|\\.|!|\\?', x=text_blob, replacement='ootoo')
    
    # remove all non-alpha text (numbers etc)
    text_blob <- gsub(pattern="[^[:alpha:]]", x=text_blob, replacement = ' ')
    
    # force all characters to lower case
    text_blob <- tolower(text_blob)
    
    # remove any small words {size} or {min,max}
    text_blob <- gsub(pattern="\\W*\\b\\w{1,2}\\b", x=text_blob, replacement=' ')
    
    # remove contiguous spaces
    text_blob <- gsub(pattern="\\s+", x=text_blob, replacement=' ')
    
    # split sentences by split code
    sentence_vector <- unlist(strsplit(x=text_blob, split='ootoo',fixed = TRUE))
    return (sentence_vector)
}


### Read Data
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
set.seed(23423)
blog_sample <- blog_data[sample(1:length(blog_data),50000)]

set.seed(2344)
news_sample <- news_data[sample(1:length(news_data),50000)]

set.seed(3334)
twitter_sample <- twitter_data[sample(1:length(twitter_data),50000)]

#combine 
master_sample <- c(blog_sample, news_sample, twitter_sample)

#clean
master_sample <- Text_To_Clean_Sentences(master_sample)

#N grams
n1 <- Get_Ngrams(master_sample, ngram_size=1)
n2 <- Get_Ngrams(master_sample, ngram_size=2)
n3 <- Get_Ngrams(master_sample, ngram_size=3)
n4 <- Get_Ngrams(master_sample, ngram_size=4)


# consolidate all n-gram vectors into one
#n_all <- c(n1, n2, n3, n4)

# save the n-grams in the same folder as your shiny code
#write.csv(n_all, 'ngrams.csv', row.names=FALSE)
write.csv(n1, '1ngramsV2.csv', row.names=FALSE)
write.csv(n2, '2ngramsV2.csv', row.names=FALSE)
write.csv(n3, '3ngramsV2.csv', row.names=FALSE)
write.csv(n4, '4ngramsV2.csv', row.names=FALSE)





