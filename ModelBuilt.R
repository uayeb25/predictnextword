setwd  (dir = "Google Drive/Courses/Data Science Specialization/Capstone/")

n2 <- read.csv("2ngramsV2.csv")
n3 <- read.csv("3ngramsV2.csv")
n4 <- read.csv("4ngramsV2.csv")

tn1 <- sort(table(n1), decreasing=T)
tn2 <- sort(table(n2), decreasing=T)
tn3 <- sort(table(n3), decreasing=T)
tn4 <- sort(table(n4), decreasing=T)

write.csv(tn1,"tn1V2.csv")
write.csv(tn2,"tn2V2.csv")
write.csv(tn3,"tn3V2.csv")
write.csv(tn4,"tn4V2.csv")

readTn1 <- read.csv("tn1V2.csv")
readTn2 <- read.csv("tn2V2.csv")
readTn3 <- read.csv("tn3V2.csv")
readTn4 <- read.csv("tn4V2.csv")

head(readTn1)
sum(readTn1$x)


totofwords <- 3283346

readTn1$prob <- lapply(readTn1$x, function(x) x/totofwords )
readTn2$prob <- lapply(readTn2$x, function(x) x/totofwords )
readTn3$prob <- lapply(readTn3$x, function(x) x/totofwords )
readTn4$prob <- lapply(readTn4$x, function(x) x/totofwords )

save(readTn1,file="readTn1V2.RData")
save(readTn2,file="readTn2V2.RData")
save(readTn3,file="readTn3V2.RData")
save(readTn4,file="readTn4V2.RData")



readTn4less <- readTn4[readTn4$x != 1,]
readTn3less <- readTn3[readTn3$x != 1,]
readTn2less <- readTn2[readTn2$x != 1,]


save(readTn2less,file="ngram2.RData")
save(readTn3less,file="ngram3.RData")
save(readTn4less,file="ngram4.RData")




predict <- function(x){
    
    x <- tolower(x)
    mysplit <- strsplit(x, ' ')[[1]]
    words <- c()
    l <- length(mysplit)
    
    if( l >= 1 ){
        s <- paste0("^",mysplit[l]," ")
        rows <- head(readTn2less[grepl(s,readTn2less$X), ],6)
        print(s)
        if(nrow(rows)>0)
            for(i in 1:nrow(rows)){
                print(rows[i,])
                phrase <- as.character(rows[i,]$X)
                word <- strsplit(phrase,' ')[[1]][2]
                words <- c(words,word)
            }
        
    }
    
    if( l >= 2 ){
        s <- paste0("^",mysplit[l-1]," ",mysplit[l]," ")
        rows <- head(readTn3less[grepl(s,readTn3less$X), ],6)
        print(s)
        if(nrow(rows)>0)
            for(i in 1:nrow(rows)){
                print(rows[i,])
                phrase <- as.character(rows[i,]$X)
                word <- strsplit(phrase,' ')[[1]][3]
                words <- c(words,word)
            }
    }
    
    if( l >= 3 ){
        s <- paste0("^",mysplit[l-2]," ",mysplit[l-1]," ",mysplit[l]," ")
        rows <- head(readTn4less[grepl(s,readTn4less$X), ],6)
        print(s)
        if(nrow(rows)>0)
            for(i in 1:nrow(rows)){
                print(rows[i,])
                phrase <- as.character(rows[i,]$X)
                word <- strsplit(phrase,' ')[[1]][4]
                words <- c(words,word)
            }
    }
    
    return(words)
    
    
}









