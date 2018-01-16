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


#############################################################################
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

#############################################################################
library(stringr)
train.data = merge.data
train.data = cbind.data.frame(train.data[,1:3],baby_ID=train.data[,3],train.data[,4:ncol(train.data)])
train.data$订单号 = str_sub(train.data$订单号,2,50)
train.data$baby_ID = str_sub(train.data$baby_ID,36,147)
train.data = cbind.data.frame(train.data[,1],train.data[,4])

length(unique(train.data$baby_ID))
length(unique(train.data$宝贝标题))

aggregate(train.data[,c(1)],list(train.data[,1]),count)
train.data$宝贝标题[which(train.data$订单号=="8473482600617718")]

#############################################################################

write.table(train.data,file ="E:\\屈臣氏\\天猫旗舰订单数据\\groceries.txt" )
head(train.data)

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

itemFrequency(groceries[1:8,1:3])
itemFrequencyPlot(groceries,support=0.1)
itemFrequencyPlot(groceries,topN = 10 , horiz = T)

groceries_use = groceries[basketSize>1]
dim(groceries_use)

inspect(groceries[1:5])

image(groceries[1:5])
image(sample(groceries,100))

library(arules)
library(arulesViz)
library(RColorBrewer)

groceryrules = apriori(groceries,parameter = list(support=0.006,confidence = 0.25,minlen = 2))

summary(groceryrules)

inspect(groceryrules[1:5])

ordered_groceryrules <- sort(groceryrules, by="lift") 
inspect(ordered_groceryrules[1:5])

#yogurtrules <- subset(groceryrules, items %in% c("yogurt")) 
#inspect(yogurtrules)  

#fruitrules <- subset(groceryrules, items %pin% c("fruit") & lift > 2) 
#inspect(fruitrules)  

qualityMeasures <- interestMeasure(groceryrules, method=c("coverage","fishersExactTest","conviction", "chiSquared"), transactions=groceries) 
summary(qualityMeasures) 

quality(groceryrules) <- cbind(quality(groceryrules), qualityMeasures)
inspect(head(sort(groceryrules, by = "conviction", decreasing = F)))  

berriesInLHS <- apriori(groceries, parameter = list( support = 0.001, confidence = 0.1 ), appearance = list(lhs = c("berries"), default="rhs")) 
summary(berriesInLHS)  
inspect(berriesInLHS) 

write(groceryrules, file="groceryrules.csv", sep=",", quote=TRUE, row.names=FALSE)










