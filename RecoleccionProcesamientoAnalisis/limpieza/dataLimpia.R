a<-read.csv("data.csv")
#procesado de peso
a$Peso<-as.character(a$Peso)
a$Peso<-gsub(" Kg","",a$Peso)
a$Peso<-gsub(",",".",a$Peso)
a$Peso<-gsub("-1","NA",a$Peso)
a$Peso<-as.numeric(a$Peso)#Si detecta letras vuelve la celda NA
pesomedio<-mean(a$Peso,na.rm=TRUE)
a$Peso[is.na(a$Peso)]<-pesomedio
hist(a$Peso)
summary(a$Peso)

#procesado de valoraciones
a$valoraciones<-as.character(a$valoraciones)
a$valoraciones<-gsub(" valoraciones","",a$valoraciones)
a$valoraciones<-gsub(" valoración","",a$valoraciones)
a$valoraciones<-as.numeric(a$valoraciones)
valormedio<-mean(a$valoraciones,na.rm=TRUE)
a$valoraciones[is.na(a$valoraciones)]<-valormedio

#procesado de precio
a$Precio<-as.character(a$Precio)
a$Precio<-gsub("\\€","",a$Precio)
a$Precio<-gsub(".","",a$Precio,fixed=TRUE)
a$Precio<-gsub(",",".",a$Precio)
a$Precio<-gsub("\u00A0","",a$Precio) #Eliminando espacio q habia al final
a$Precio<-as.numeric(a$Precio)
preciomedio<-mean(a$Precio,na.rm=TRUE)
a$Precio[is.na(a$Precio)]<-preciomedio

#eliminando la columna Color
a<-a[,-5]
write.csv(a,"dataLimpia.csv")
