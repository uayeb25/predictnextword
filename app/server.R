load("ngram2.RData")
load("ngram3.RData")
load("ngram4.RData")

shinyServer(function(input, output) {
    
    
    
    output$oid1 = renderPrint({"We are ready To predict"})
    
    output$predictions <- renderUI({
        
        HTML('<span style="font-size: 1em !important; color: #009933;">predincting...</span>')
        
        predictions <- predict(input$txtPredict)
        
        html <- '<span style="font-size: 1em !important; color: #009933;"><ul>'
        if(length(predictions)>0)
            for(i in 1:length(predictions))
                html <- paste0(html,'<li>',predictions[i], '</li>')
        
        html <- paste0(html,'</ul></span>')
        
        HTML(html)
    })
    
    
    
    
    
    predict <- function(x){
        
        x <- tolower(x)
        mysplit <- strsplit(x, ' ')[[1]]
        words <- c()
        l <- length(mysplit)
        
        if( l >= 1 ){
            s <- paste0("^",mysplit[l]," ")
            rows <- head(readTn2less[grepl(s,readTn2less$X), ],6)
            
            if(nrow(rows)>0)
                for(i in 1:nrow(rows)){
                    phrase <- as.character(rows[i,]$X)
                    word <- strsplit(phrase,' ')[[1]][2]
                    words <- c(words,word)
                }
            
        }
        
        if( l >= 2 ){
            s <- paste0("^",mysplit[l-1]," ",mysplit[l]," ")
            rows <- head(readTn3less[grepl(s,readTn3less$X), ],6)
            
            if(nrow(rows)>0)
                for(i in 1:nrow(rows)){
                    phrase <- as.character(rows[i,]$X)
                    word <- strsplit(phrase,' ')[[1]][3]
                    words <- c(words,word)
                }
        }
        
        if( l >= 3 ){
            s <- paste0("^",mysplit[l-2]," ",mysplit[l-1]," ",mysplit[l]," ")
            rows <- head(readTn4less[grepl(s,readTn4less$X), ],6)
            
            if(nrow(rows)>0)
                for(i in 1:nrow(rows)){
                    phrase <- as.character(rows[i,]$X)
                    word <- strsplit(phrase,' ')[[1]][4]
                    words <- c(words,word)
                }
        }
        
        return(words)
        
        
    }
    
    
})