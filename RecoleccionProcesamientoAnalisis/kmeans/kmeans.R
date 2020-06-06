a<-read.csv("dataLimpia.csv")
a<-a[,-c(1:4)] #Obteniendo solo data numerica
write.csv(a,"dataNormalizada.csv")
#Elbow: determinar el numero de clusters
a<-scale(a)#para obtener la data normalizada
cluster<-kmeans(a,3,nstart=5,iter.max=30)
wss<-(nrow(a)-1)*sum(apply(a,2,var))
for(i in 2:20) wss[i]<-sum(kmeans(a,centers=i)$withinss)
plot(1:20,wss,type="b",xlab="Numero de clusters",ylab="withinss groups")
#calcular los clusters
cluster<-kmeans(a,5,nstart=5,iter.max=30)#elbow=5 en mi caso
library(fmsb)
par(mfrow=c(1,3)) #1 filas de 3 graficas
plotCentros<-function(centro){
	dat<-as.data.frame(t(cluster$centers[centro,]))
	dat<-rbind(rep(5,10),rep(-1.5,10),dat)
	radarchart(dat)
}
sapply(c(1:3),plotCentros) 
