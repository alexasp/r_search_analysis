library(RJSONIO)

parseJsonSearches <- function(path){
  files <- as.character(list.files(path=path, full.names = TRUE))
  
  searches = data.frame()
  
  for (file in files){
    lines <- readLines(file)
    
    data <- fromJSON(lines)$event
    
    fileSearches = plyr::ldply(data, function(event)c(event$query$query_text, event$query$id[[1]][[1]]))
    names(fileSearches) <- c("query", "time")
    
    searches = rbind(searches, fileSearches) 
  }
  
  searches$time <- as.POSIXct(as.numeric(searches$time)/1000000, origin = "1970-01-01")

  return(searches)
}
