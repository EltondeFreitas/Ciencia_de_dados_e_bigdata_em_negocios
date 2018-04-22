# link do tutorial para realizar o exericio
# http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know

# Bibliotecas necessárias para a realização do exercício

# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# o arquivo baixado é no formato pdf
# o modelo foi convertido para txt, isso deve ser feito manualmente
# devem ser substituidos caracteres com acentuação e ç
# com o texto carregado no computador selecionar o arquivo.
text <- readLines(file.choose())


# Load the data as a corpus
docs <- Corpus(VectorSource(text))


inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, "..")
docs <- tm_map(docs, toSpace, ">")
docs <- tm_map(docs, toSpace, "(")
docs <- tm_map(docs, toSpace, ")")
docs <- tm_map(docs, toSpace, """)





# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
# docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("que", "uma", "das", "com", "como", "para", "por", "seus", "dos", "nao", "sao", "ser")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)




dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)




set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))