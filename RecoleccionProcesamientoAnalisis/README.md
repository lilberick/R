# Proceso para trabajar con Data de laptops en venta en la tienda de Amazon :computer: :moneybag: :money_with_wings:  
![](recoleccion/img/1.png)
1. Recolección: Web Scraping   
	1. Ejecutamos el script  
		```
		$ Rscript WebScraping.R
		```
	2. Nos genera la data sin limpiar en el archivo: **data.csv**  
		![](recoleccion/img/2.png)
2. Limpieza de datos  
	1. Ejecutamos el script  
		```
		$ Rscript dataLimpia.R	
		```
	2. Nos genera la data limpia en el archivo: **dataLimpia.csv**  
		![](limpieza/img/1.png)
3. kmeans: modelos no supervisados  
	1. Utilizaremos esta data que está limpia en la parte numérica: **dataLimpia.csv**    
		![](kmeans/img/1.png)
	2. Normalizamos la data: **dataNormalizada.csv**    
		![](kmeans/img/2.png)
	3. Elegimos el número óptimo de clusters usando el método Elbow   
		![](kmeans/img/3.png)
	4. Calculamos los clusters  
		![](kmeans/img/4.png)
