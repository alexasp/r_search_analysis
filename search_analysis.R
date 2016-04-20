library(tm)
library(wordcloud)

source('data_processing/parse_json_data.R')


searches <- parseJsonSearches('data/searches')
searches$query <- tolower(searches$query)
searchesWithoutNavigation <- searches[! grepl('->', searches$query), ]

queryCounts <- as.data.frame(table(searchesWithoutNavigation$query))

words <- paste(searchesWithoutNavigation$query, collapse = ' ')

wordCounts <- as.data.frame(table(strsplit(words, split = " ")))

wordCounts <- wordCounts[! wordCounts$Var1 %in% stopwords(), ]

searchcloud_min_100 <- wordcloud(words, min.freq = 100)
searchcloud_min_50 <- wordcloud(words, min.freq=50)

