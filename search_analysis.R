library(tm)

source('data_processing/parse_json_data.R')


searches <- parseJsonSearches('data/searches')
searches$query <- tolower(searches$query)
searchesWithoutNavigation <- searches[! grepl('->', searches$query), ]

words <- paste(searchesWithoutNavigation$query, collapse = ' ')

wordCounts <- as.data.frame(table(strsplit(words, split = " ")))

wordCounts <- wordCounts[! wordCounts$Var1 %in% stopwords(), ]
