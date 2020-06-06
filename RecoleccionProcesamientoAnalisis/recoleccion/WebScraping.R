pag<-paste0("s?k=laptop&page=",c(1:2),"&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&qid=1590460336&ref=sr_pg_",c(1:2))
paginas<-paste0("https://www.amazon.es/",pag)
dameLinksPagina<-function(url){
  library(rvest)
  selector <- "div > span > div > div > div:nth-child(3) > h2 > a"
  pagina <- read_html(url)
  nodo <- html_nodes(pagina,selector)
  nodo_text <- html_text(nodo)
  nodo_links <- html_attr(nodo,"href")
  urlcompleta <- paste0("https://www.amazon.es",nodo_links)
  urlcompleta
}
getArticulo<-function(url){
  library(rvest)
  pagina_web<-read_html(url)
  #nombre_texto
  nombre<-"#productTitle"
  nombre_nodo<-html_node(pagina_web, nombre)
  nombre_texto<-html_text(nombre_nodo)
  #opiniones_texto
  opiniones<-"#acrCustomerReviewText"
  opiniones_nodo<-html_node(pagina_web, opiniones)
  opiniones_texto<-html_text(opiniones_nodo)
  #precio_texto
  precio<-"#priceblock_ourprice"
  precio_nodo<-html_node(pagina_web, precio)
  precio_texto<-html_text(precio_nodo)
  #tabla
  tabla<-"#prodDetails > div.wrapper.ESlocale > div.column.col1 > div > div.content.pdClearfix > div > div > table"
  tabla_nodo<-html_node(pagina_web, tabla)
  if(!is.na(tabla_nodo)){ #SI el nodo no esta vacio!!!
    tabla_tab<-html_table(tabla_nodo)
    #tabla_tab
    val<-tabla_tab$X2
    res_tabla<-data.frame(t(val))
    tabla_name<-tabla_tab$X1
    colnames(res_tabla)<-tabla_name
  }
  col<-c("Marca", "Peso del producto", "Color")
  if( is.na(tabla_nodo)){ #Si tabla nodo esta vacia
    #Rellenar con campos vacio
    mitab<-data.frame(colnames(col))
    mitab<-rbind(mitab, c("-1", "-1", "-1", "-1"))
    colnames(mitab)<-col
  }else{
    #Evaluar cada uno de los campos
    zero<-matrix("-1", ncol=4, nrow=1)
    dfzero<-as.data.frame(zero)
    colnames(dfzero)<-col
    #dfzero
    marca<-as.character(res_tabla$`Marca`)
    if(length(marca)==0) marca <- "-1"
    pesoProducto<-as.character(res_tabla$`Peso del producto`)
    if(length(pesoProducto)==0) pesoProducto<- "-1"
    color<-as.character(res_tabla$Color)
    if(length(color)==0) color<- "-1"
    dfzero$Marca<-marca
    dfzero$`Peso del producto`<-pesoProducto
    dfzero$Color<-color
    #str(dfzero)
    mitab<-dfzero
    colnames(mitab)<-col
  }
  articulo<-c(nombre_texto, as.character(mitab$`Marca`[1]), as.character(mitab$`Peso del producto`[1]), as.character(mitab$Color[1]), opiniones_texto, precio_texto)  
  articulo
  #write.csv(articulo,"data.csv")
}
linksAsp<-sapply(paginas,dameLinksPagina)
vlink<-as.vector(unlist(linksAsp))
vlink
datosAsp<-sapply(vlink,getArticulo)
datosAsp<-as.data.frame(datosAsp)
names(datosAsp)<-NULL
b<-t(datosAsp)
colnames(b)<-c("Nombre","Marca","Peso","Color","valoraciones","Precio")
#rownames(b)<-c(1:6)
b
#datos<-as.vector((datosAsp))
write.csv(b,"data.csv")
