#' @Readthe @csv @file 
#' @PurpleComment
apple <- read.csv(file.choose(), header = T)
str(apple)

# Build corpus - text processing package
library(tm)

#corpus is type of documents each tweet(record/row) in this case is a document in itself
corpus <- iconv(apple$text, to = "utf-8") #' @converting the character to utf-8
corpus <- Corpus(VectorSource(corpus))

#same as head(df)
inspect(corpus[1:5])

# Clean text
corpus <- tm_map(corpus, tolower)  #transformation using map specific for corpus
inspect(corpus[1:5])

corpus <- tm_map(corpus, removePunctuation)  
inspect(corpus[1:5])

corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])

cleanset <- tm_map(corpus, removeWords, stopwords('english'))
inspect(cleanset[1:5])

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

cleanset <- tm_map(cleanset, removeWords, c('aapl', 'apple'))
cleanset <- tm_map(cleanset, gsub, 
                   pattern = 'stocks', 
                   replacement = 'stock')

cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])

# Term document matrix
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20] # first 10 rows and 20 columns

# Bar plot
w <- rowSums(tdm) 
w <- subset(w, w>=25)

#manually cleaning the special characters dots and other variants of dots
w <- w[!(names(w) %in% c('…'  , 'head...' , 'pos…' , 'head…', '•'))]
w <- sort(w)
barplot(w,
        las = 2,
        col = rainbow(100))

# Word cloud
library(wordcloud)
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)
wordcloud(words = names(w),
          freq = w,
          max.words = 150,
          random.order = F,
          min.freq = 5,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(5, 0.3),
          rot.per = 0.3)

library(wordcloud2)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')
wordcloud2(w,
           size = 0.7,
           shape = 'triangle',
           rotateRatio = 0.5,
           minSize = 1)

letterCloud(w,
            word = "e",
            size=2)

# Sentiment analysis
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

# Read file
apple <- read.csv(file.choose(), header = T)
tweets <- iconv(apple$text, to = 'utf-8')

# Obtain sentiment scores
s <- get_nrc_sentiment(tweets)
head(s)
tweets[4]
get_nrc_sentiment('delay')

# Bar plot
barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Apple Tweets')
