* Encoding: UTF-8.
*###################################################################################################
*
*                 ESTIMACIÓN DE LA VARIANZA EN ENCUESTAS COMPLEJAS.  
*
*###################################################################################################


* El objetivo de esta sintaxis es calcular los errores de muestreo de las estimaciones que provienen de encuestas con
diseño estadístico complejo.


*   Índice
*   0. Definir el esquema de muestreo.
*   1. Razones con muestras complejas.
*   2. Frecuencias de muestras complejas.
*   3. Tablas cruzadas de muestras complejas.
*   4. Regresión logística.




*  0. Definir el esquema de muestreo.

                    CSPLAN ANALYSIS
                      /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\sdemt215.csaplan'
                      /PLANVARS ANALYSISWEIGHT=fac       
                      /SRSESTIMATOR TYPE=WOR
                      /PRINT PLAN
                      /DESIGN STAGELABEL='uno' STRATA=est_d CLUSTER=upm 
                      /ESTIMATOR TYPE=WR.
                    
                    COMPUTE filtro=((r_def = '00') & (c_res= '1' | c_res= '3') & (eda >= '15' & eda<='98') ).
                    FILTER BY filtro.
                    

*  1. Razones con muestras complejas.
                
*        1.1 Razón (Totales).

                    *COMPUTE NUM_TASA=((r_def = '00') & (c_res= '1' | c_res= '3') & clase1=1 & (eda >= '15' & eda<='98')).
                    *COMPUTE DEN_TASA=((r_def = '00') & (c_res= '1' | c_res= '3') & (eda >= '15' & eda<='98')).
                    * Opcional: Se puede validar que los datos son los mismos.
                    *WEIGHT BY fac.
                    *FREQUENCIES VARIABLES=NUM_TASA DEN_TASA.

                    CSDESCRIPTIVES
                      /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\Sdemt215.csaplan'
                      /RATIO NUMERATOR=NUM_TASA DENOMINATOR=DEN_TASA
                      /STATISTICS SE CV CIN(90)
                      /MISSING SCOPE=ANALYSIS CLASSMISSING=EXCLUDE.
                
*        1.2 Razón (Subpoblación).

                    CSDESCRIPTIVES
                      /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\Sdemt215.csaplan'
                      /RATIO NUMERATOR=NUM_TASA DENOMINATOR=DEN_TASA
                      /STATISTICS SE CV CIN(90)
                      /SUBPOP TABLE=sex DISPLAY=LAYERED
                      /MISSING SCOPE=ANALYSIS CLASSMISSING=EXCLUDE.


*   2. Frecuencias de muestras complejas.

*        2.1 Frecuencias (Totales).

                    *COMPUTE filtro=((r_def = '00') & (c_res= '1' | c_res= '3') & (eda >= '15' & eda<='98')).
                    *COMPUTE clase2_bis=0.
                    *if (filtro=1 & clase2=1) clase2_bis=1.
                    *if (filtro=1 & clase2=2) clase2_bis=2.
                    *if (filtro=1 & clase2=3) clase2_bis=3.
                    *if (filtro=1 & clase2=4) clase2_bis=4.

                CSTABULATE
                  /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\sdemt215.csaplan'
                  /TABLES VARIABLES=clase2_bis
                  /CELLS POPSIZE 
                  /STATISTICS SE CV CIN(90) 
                  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.

*        2.2 Frecuencias (Subpoblación).

                    CSTABULATE
                      /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\sdemt215.csaplan'
                      /TABLES VARIABLES=clase2_bis
                      /SUBPOP TABLE=sex DISPLAY=LAYERED
                      /CELLS POPSIZE 
                      /STATISTICS SE CV CIN(90)  
                      /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.
                    

*   3. Tablas cruzadas de muestras complejas.

*        3.1 Tablas cruzadas (Totales).

                CSTABULATE
                  /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\Sdemt215.csaplan'
                  /TABLES VARIABLES=clase2_bis BY sex
                  /CELLS POPSIZE
                  /STATISTICS SE CV CIN(90)
                  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.

*        3.1 Tablas cruzadas (Subpoblación).

                CSTABULATE
                  /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\sdemt215.csaplan'
                  /TABLES VARIABLES=clase2_bis BY sex
                  /SUBPOP TABLE=ent DISPLAY=LAYERED
                  /CELLS POPSIZE
                  /STATISTICS SE CV CIN(90)  
                  /MISSING SCOPE=TABLE CLASSMISSING=EXCLUDE.


*   4. Regresión logística.

*        4.1 Variables para el análisis.
                *COMPUTE TI=((r_def = '00') & (c_res= '1' | c_res= '3') & (eda >= '15' & eda < '30') & clase2=1).
                *ALTER TYPE n_hij(f7.2).

*        4.1 Regresión logística, ignorando el diseño de la encuesta.
                LOGISTIC REGRESSION VARIABLES TI
                  /SELECT=filtro EQ 1
                  /METHOD=ENTER n_hij anios_esc 
                  /PRINT=GOODFIT
                  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*        4.2 Regresión logística de muestras complejas.
                CSLOGISTIC  TI(HIGH) WITH n_hij anios_esc
                  /PLAN FILE='C:\Users\JC\Desktop\WORKSHOP\Bases\sdemt215.csaplan' 
                  /DOMAIN VARIABLE=filtro(1.00)
                  /MODEL n_hij anios_esc
                  /INTERCEPT INCLUDE=YES SHOW=YES
                  /STATISTICS PARAMETER EXP SE TTEST DEFF
                  /TEST TYPE=F PADJUST=LSD
                  /MISSING CLASSMISSING=EXCLUDE
                  /CRITERIA MXITER=100 MXSTEP=5 PCONVERGE=[1e-006 RELATIVE] LCONVERGE=[0] CHKSEP=20 CILEVEL=95
                  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO.
                










