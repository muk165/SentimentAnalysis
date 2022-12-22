# SentimentAnalysis
Sentiment Analysis done on Twitter Apple Tweets data before the apple earning report 

Insights Shots:
![alt text](https://github.com/muk165/SentimentAnalysis/blob/main/sentiment_barplots.png?raw=true)
![alt text](https://github.com/muk165/SentimentAnalysis/blob/main/traingle_wordcloud.png)
![alt text](https://github.com/muk165/SentimentAnalysis/blob/main/barplot_wordcounts.png)



Brief on whats happening inside the Sentiment.R Script

I am using an unstructured data to get insights on the senetiments of tweets, the data is converted to structured format by using an vector space model,In the Vector Space model, each document(record/row) from the corpus is represented as a multidimensional vector. Each unique term from the corpus represents one dimension of the vector space. A term can be a single word or sequence of words. The number of unique terms in the corpus determines the dimension of the vector space.

some steps invloved in the process:

1) loading the dataset by read_csv base function, filechoose() to browse the file(apple.csv) 
2) Using Text Mining Library tm to build the corpus dataset first using the iconv function to convert the intial character encoding to utf-8 encoding  and the cleaning operations
  *Cleaning of the text invloves
   a) lower case all the text
   b) remove punctuation
   c) remove numbers
   d) remove url's
   e) remove stop words
   f) strip whitespace 
   g) some manual cleaning from the named vector

3) making this cleaned data set as as TDM Matrix. In VSM, the corpus is represented in the form of the Term Document Matrix(TDM). This matrix represents documents vectors in matrix form in which the rows correspond to the terms in the document(row names), columns correspond to the documents(1000 records in apple.csv) in the corpus and cells correspond to the weights of the terms. In our code these weight are binary weights which simply provides the counts every sentence has for every single word in all the documents combined

4) row summing the tdm to get the counts of each word in full dataset, sorting the dataset and making a barplot to represent the counts

5) making other visualization using the wordclod, wordcloud2 libraries 

6) using the syuzhet library to get the sentiment scores for each tweet it gives different emotion scores like anger,sadness, disgust, positive, negative.
get_nrc_sentiment function to retrive these results and constructing a bar plot to analyze different sentiments observed in the dataset


pull request are welcome, fork it if you like!

Thanks!

######END#######


