
getwd()
dir()
#################################
setwd("\\***\\***")
dir <- dir()
n = length(dir) 
n
merge.data = read.csv(file = dir[1],header=T,sep=",") 

for (i in 2:n){
   new.data = read.csv(file = dir[i], header=T, sep=",")
   merge.data = rbind(merge.data,new.data)
 }

merge.data[,1:2]
write.csv(merge.data,file = "E:\\***\\***\\merge.csv",row.names=F)
