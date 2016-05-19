# Calculo de Precisiones Estadisticas

Muchas de las encuestas en hogares tienen un esquema de muestreo complejo, esto significa que las observaciones no tienen la misma probabilidad de selección ni son independientes. Sin embargo, la mayoría de las técnicas estadísticas más comunes suponen que los datos provienen de un esquema de muestreo aleatorio simple. El problema surge al momento de pasar por alto dicho esquema de muestreo ya que se pueden obtener estimaciones sesgadas, o bien, subestimar la varianza de los datos que se están analizando.

El objetivo de este taller es brindar a los asistentes una introducción al cálculo de los errores de muestreo usando el método de **linealización por series de Taylor**. Se usa el paquete estadístico SPSS, así como las bases de datos de la ENOE segundo trimestre de 2015 y la Encuesta Intercensal 2015. En la carpeta Documentos se encuentran algunos ejemplos de cómo se pueden reproducir los cálculos en *Stata* y *R*.

En la carpeta [Bases](https://github.com/jcms2665/PrecisionesEstadisticas/tree/master/Bases) se encuentra la bases de datos en formato de SPSS; en la carpeta  [Codigo](https://github.com/jcms2665/PrecisionesEstadisticas/tree/master/Codigo) se encuentra la sintaxis para obtener las estimaciones de tasas, frecuencias y tablas. La presentación del taller está disponible en  [Documentos](https://github.com/jcms2665/PrecisionesEstadisticas/tree/master/Documentos), además se tiene  un breve tutorial (en PDF) sobre cómo replicar los ejericicos y algunos ejemplos de sintaxis en *Stata* y *R*.


Para aprender un poco sobre el diseño muestral de encuestas en hogares, se recomienda consultar algunos de los siguientes textos:

+ [Applied Survey Data Analysis](http://www.isr.umich.edu/src/smp/asda/)

+ [Complex Surveys: a guide to analysis using R](http://r-survey.r-forge.r-project.org/svybook/)

+ [Diseño de la muestra en proyectos de encuesta (INEGI)](http://www.snieg.mx/contenidos/espanol/normatividad/doctos_genbasica/muestra_encuesta.pdf)

+ [Diseño de la muestra para encuestas en hogares](http://unstats.un.org/unsd/publication/seriesf/Seriesf_98s.pdf)







