#importamos data
data<-read.csv("data.csv")
rownames(data)<-c("A","B","C","D","E","F","G","H","I","J","K","L","M","N")

#cluster usando kmeans
cluster <- kmeans(data,3,nstart=15,iter.max=30)

#Elbow: determinar el numero de clusters
a<-scale(data)
cluster<-kmeans(a,3,nstart=5,iter.max=30)
wss<-(nrow(a)-1)*sum(apply(a,2,var))
for(i in 2:13) wss[i]<-sum(kmeans(a,centers=i)$withinss)
plot(1:13,wss,type="b",xlab="Numero de clusters",ylab="withinss groups")

#grafica radar
cluster<-kmeans(a,3,nstart=5,iter.max=30)#elbow=3 en mi caso
library(fmsb)
par(mfrow=c(2,2)) #2 filas de 2 graficas
plotCentros<-function(centro){
	dat<-as.data.frame(t(cluster$centers[centro,]))
	dat<-rbind(rep(5,10),rep(-1.5,10),dat)
	radarchart(dat)
}
sapply(c(1:3),plotCentros)

