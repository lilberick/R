pag<-paste0("https://link.springer.com/search/page/",c(1:24),"?facet-content-type=%22Book%22&package=mat-covid19_textbooks")
pag
dameLinksPagina<-function(url){
	library(rvest)
	selector <- "div.text > h2 > a"
	pagina <- read_html(url)
	nodo <- html_nodes(pagina,selector)
	#nodo_text <- html_text(nodo)
	nodo_links <- html_attr(nodo,"href")
	urlcompleta <- paste0("https://link.springer.com",nodo_links)
	urlcompleta
}
dameLinksPDF<-function(url){
	library(rvest)
	pagina<-read_html(url)
	selector1<-"article.main-wrapper.main-wrapper--no-gradient.main-wrapper--dual-main > div > div > div.cta-button-container.cta-button-container--inline.cta-button-container--stacked.u-pt-36.test-download-book-separate-buttons > div:nth-child(1) > a"
        selector2<-"article.main-wrapper.main-wrapper--no-gradient.main-wrapper--dual-main > div > div > div.cta-button-container.cta-button-container--stacked.u-pt-36 > div > div > a"
	nodo<-html_nodes(pagina,selector1)
	text<-html_text(nodo)
	if(identical(text,character(0))){nodo<-html_nodes(pagina,selector2)}
	text2<-html_text(nodo)
	if(!(identical(text2,character(0)))){
		nodo_links<-html_attr(nodo,"href")
		urlcompleta<-paste0("https://link.springer.com",nodo_links)
		urlcompleta
	}
}
linksAsp<-sapply(pag,dameLinksPagina)
vlink<-as.vector(unlist(linksAsp))
vlink
linksAsp2<-sapply(vlink,dameLinksPDF)
vlink2<-as.vector(unlist(linksAsp2))
for(i in seq_along(vlink2)){
	download.file(vlink2[i], basename(vlink2[i]),mode="wb")
}
