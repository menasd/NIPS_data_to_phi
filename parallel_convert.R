#Using parallel computing to create a long format file that lists the cells 
#  of each contingency table corresponding to a word pair.

#This file calculates the cells of contingency tables for a given word i (word1), and other (non redundant) words indexed by j (word2). 

#Input: wd = working directory
#       NCORES = number of cores for parallel computing
#       i = index for a word. 
#       total.words = total number of words (11463)
#       word_mat = (11463 x 5811) matrix containing 11463 unique words (rows) and 5811 published papers (columns), with values 0 or 1:
#        0 = word does not appear
#        1 = word appears

#Output: Files named "res_[i]_[j].txt containing four values corresponding to the cells of a single contingency table. 
#        Number of files is determined by the number of non-overlapping word-pairs that correspond to i. 

library(parallel)

#vector of variables passed from command line or SH file. 
RUNVARS     <- commandArgs(T)

wd     <- RUNVARS[1]
NCORES <- as.numeric(RUNVARS[2])
i      <- as.numeric(RUNVARS[3])
total.words <- as.numeric(RUNVARS[4])

setwd(wd)

results.path <- paste0(wd,"/results/")

#FUNCTIONS:

#Input: j = index of other (word2) word within the pair (word 1 is i).
#Output: file in results folder with cells of contingency table.
get.cont <- function(j){

  off.diagonal <- i != j #ensures word pair is not with itself.

  # j > 1 ensures non-symmetrical word pairs: e.g., hello-word, and world-hello. 
  if((j > i) & off.diagonal){

 # Grabbing row that corresponds to word2. Lets us know which articles contain word j. 
    word2.data <- c(unlist(read.csv("word_mat.csv",skip=(j-1),header=F,nrow=1)))
    names(word2.data) <- NULL

    both <- sum(word1.data &
                  word2.data) #total number of articles where word1 and word2 were present.

    only2 <- sum((word1.data == 0) &
                   word2.data) # total number of articles where word1 is NOT present, and word2 and is present. 

    only1 <- sum(word1.data &
                   (word2.data == 0)) #total number of words where word2 is NOT present, and word2 is present.

    neither <- sum(word1.data == 0 &
                     word2.data == 0) #total number of words where neither word is present. 

    cat(paste0(both,",",only2,",",only1,",",neither),
        file=paste0(results.path,"res",i,"_",j,".txt")) #tried using cat this time to try something new. 
    return(NA)
  }else{
    return(NA)
  }
}


#Getting word 1 (constant for this entire file):
word1.data <- c(unlist(read.csv("word_mat.csv",skip=(i-1),header=F,nrow=1)))
names(word1.data) <- NULL

#Calling function in a parallel fashion.
mclapply(X=2:total.words,FUN = get.cont,mc.cores = NCORES)

