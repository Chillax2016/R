# Ctrl+Shift+C fast noted

getwd()
dir()
#################################
setwd("E:\\屈臣氏\\天猫旗舰订单数据")
dir <- dir()
n = length(dir) 
n
merge.data = read.csv(file = "E:\\屈臣氏\\天猫旗舰订单数据\\merge.csv",header=T,sep=",") 

# for (i in 2:n){
#    new.data = read.csv(file = dir[i], header=T, sep=",")
#    merge.data = rbind(merge.data,new.data)
#  }
# write.csv(merge.data,file = "E:\\屈臣氏\\天猫旗舰订单数据\\merge.csv",row.names=F)

head(merge.data)
nr <- nrow(merge.data)

library(stringr)
test.data = merge.data[1:100,]
test.data = cbind.data.frame(test.data[,1:3],baby_ID=test.data[,3],test.data[,4:ncol(test.data)])
test.data$订单号 = str_sub(test.data$订单号,2,50)
test.data$baby_ID = str_sub(test.data$baby_ID,36,147)
ID_Title = test.data$baby_ID[!duplicated(test.data$baby_ID)] 
basket_test = cbind.data.frame(OderID = test.data$订单号, babyID = test.data$baby_ID, babyTitle = test.data$宝贝标题)
# basket_test$OderID = as.character(basket_test$OderID)
# basket_test$babyID = as.character(basket_test$babyID)

# write.csv(basket_test,file = "E:\\屈臣氏\\天猫旗舰订单数据\\groceries.csv",row.names=F)
write.table(basket_test,file ="E:\\屈臣氏\\天猫旗舰订单数据\\groceries.txt" )
library(arules)  
groceries <- read.transactions("groceries.txt", format="single", sep=" ",cols = c(1,2))  
summary(groceries)  
class(groceries) 
groceries
dim(groceries)
basketSize = size(groceries)
summary(basketSize)
sum(basketSize)

itemFreq = itemFrequency(groceries)
itemFreq[1:5]
sum(itemFreq)

itemCount = (itemFreq/sum(itemFreq))*sum(basketSize)
summary(itemCount)

orderIterm = sort(itemCount,decreasing = )
orderIterm = sort(itemCount,decreasing = T)
orderIterm[1:10]
