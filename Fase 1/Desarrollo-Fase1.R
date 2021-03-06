shell("cls")

######################################################################################
##########         MODELOS ESTADISTICOS APLICADOS - MBI - EAN - 2020-2		######
###########################      TO DO :  FASE 1        ##############################
######################################################################################
#  By:  Alexandra Sastoque                                                         ###
#       Carlos Melo                                   Group Name: EL TRI           ###
#       Cristian Lopez                                                             ###
######################################################################################


rm(list=ls())
getwd()
setwd("C:/MAESTRIA - EAN/2020-201/2020-2 MODELOS ESTADISTICOS APLICADOS/Fase 1")

library(readxl)
informacion_clientes <- read_excel("C:/MAESTRIA - EAN/2020-201/2020-2 MODELOS ESTADISTICOS APLICADOS/informacion_clientes.xlsx", sheet = "Respuestas")


########                    Actividad 2 (Colaborativa)                      #########

#La empresa colombiana En la Red, está dedicada al diseño y montaje de la arquitectura
#tecnológica para empresas y requiere asesorar a uno de sus clientes. Este cliente es
#una empresa que ha crecido considerablemente en los últimos dos años, se vio en la
#necesidad de contratar a En la Red para analizar información de sus clientes que permita
#dirigir sus acciones a mejorar las utilidades. La información de los clientes la
#encuentra en el siguiente archivo: Información clientes.
#Esta empresa los ha responsabilizado a ustedes para hacer las siguientes actividades:

######################  1. Informe descriptivo de la caracterización de los clientes de la empresa. #############

# Para realizar este informe debe:
#           i).   Identificar las variables presentes en el estudio, su tipo y nivel de medición.

library(Hmisc)

summary(informacion_clientes)
sapply(informacion_clientes, class)
str(informacion_clientes)
describe(informacion_clientes)


#         ii).  Identificar para cada variable el tipo de gráfico que mejor la resume y cree el gráfico. Para ver una manera de crear las gráficas en el software R revise el siguiente objeto de aprendizaje.
#         iii). Identificar por cada variable las medidas estadísticas que mejor las describen y hallarlas.
#         iv).  Organizar los gráficos y las medidas halladas de forma que se presenten los resultados de forma clara en un archivo.

#Revisaremos una a una las variables de la siguiente manera
#         PRIMERO
#Tener en cuenta las variables que poseen valores faltantes

sapply(informacion_clientes,function(x) sum(is.na(x)))
#r no tiene un comando para calcular la moda por lo que creamos la funcion

Moda <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
       
#ahora si cargamos la libreria para los graficos
library(ggplot2)
#################################################          P6016                    ###
#       QUIEN PROPORCIONA LA MAYOR PARTE DE LA INFORMACIÓN DE ESTE MIEMBRO DEL HOGAR

summary(informacion_clientes$P6016)
describe(informacion_clientes$P6016)
mean(informacion_clientes$P6016, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P6016)
sd(informacion_clientes$P6016)
var(informacion_clientes$P6016)
quantile(informacion_clientes$P6016)
range(informacion_clientes$P6016)


ggplot(informacion_clientes, aes(P6016)) + geom_bar(aes(fill= P6020)) + labs(title= "¿Quien Proporciona La Informacion?", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="Categoria", caption = "Info Clientes - Fase1")

#################################################           P6020                   ###
#                                                    ¿ES HOMBRE O MUJER?
table(informacion_clientes$P6020)
prop.table(table(informacion_clientes$P6020))
names(which(table(informacion_clientes$P6020) == max(table(informacion_clientes$P6020))))

ggplot(informacion_clientes, aes(P6020)) + geom_bar(fill= c("grey", "pink")) + labs(title= "Clientes En la Red por Género", subtitle="Informacion Clientes Empresa En la Red", y= "Cant.", x="Género", caption = "Info Clientes - Fase1")


#################################################           P6030                  ###
#                                            ¿CUÁL ES LA FECHA DE NACIMIENTO DE … ?
#Aca contamos con respuesta binaria "si responde" o "no responde"
table(informacion_clientes$P6030)
prop.table(table(informacion_clientes$P6030))
names(which(table(informacion_clientes$P6030) == max(table(informacion_clientes$P6030))))

pie(table(informacion_clientes$P6030), col = c("yellow"), main = "¿CUÁL ES LA FECHA DE NACIMIENTO?")


#################################################           P6030S1                  ###
#                                                      MES (MM):
#contiene faltantes por lo que debemos hacer un subset con la variable sin faltantes para analizarla
#la variable debe ser numerica


subset1 <- informacion_clientes[!is.na(informacion_clientes$P6030S1),]

summary(subset1$P6030S1)
describe(subset1$P6030S1)
mean(subset1$P6030S1, trim = 10)
median(subset1$P6030S1)
Moda(subset1$P6030S1)
sd(subset1$P6030S1)
var(subset1$P6030S1)
quantile(subset1$P6030S1)
range(subset1$P6030S1)

ggplot(subset1, aes(P6030S1)) + geom_bar(fill = "pink") + labs(title= "MESES DE NACIMIENTO CLIENTES EN LA RED", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="Mes de Nacimiento", caption = "Info Clientes - Fase1")


#################################################           P6030S3                  ###
#                                                      AÑO (AAAA):
#contiene faltantes por lo que debemos hacer un subset con la variable sin faltantes para analizarla
#la variable debe ser numerica

subset2 <- informacion_clientes[!is.na(informacion_clientes$P6030S3),]

summary(subset2$P6030S3)
describe(subset2$P6030S3)
mean(subset2$P6030S3, trim = 10)
median(subset2$P6030S3)
Moda(subset2$P6030S3)
sd(subset2$P6030S3)
var(subset2$P6030S3)
quantile(subset2$P6030S3)
range(subset2$P6030S3)

ggplot(subset2, aes(P6030S3)) + geom_boxplot(fill = "orange", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Año de Nacimiento", subtitle="Informacion Clientes Empresa En la Red", y="", x="Año", caption = "Info Clientes - Fase1")

#################################################           P6040                  ###
#                     ¿CUÁNTOS AÑOS CUMPLIDOS TIENE...? (SI ES MENOR DE 1 AÑO, ESCRIBA 00)

summary(informacion_clientes$P6040)
describe(informacion_clientes$P6040)
mean(informacion_clientes$P6040, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P6040)
sd(informacion_clientes$P6040)
var(informacion_clientes$P6040)
quantile(informacion_clientes$P6040)
range(informacion_clientes$P6040)

table(informacion_clientes$P6040)

ggplot(informacion_clientes, aes(P6040)) + geom_boxplot(fill = "orange", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Edades", subtitle="Informacion Clientes Empresa En la Red", y="", x="Edad", caption = "Info Clientes - Fase1")


#################################################           P6050                  ###
#                          ¿CUÁL ES EL PARENTESCO DE ... CON EL JEFE O JEFA DEL HOGAR?

describe(informacion_clientes$P6050)
quantile(informacion_clientes$P6050)
table(informacion_clientes$P6050)
prop.table(table(informacion_clientes$P6050))
names(which(table(informacion_clientes$P6050) == max(table(informacion_clientes$P6050))))

ggplot(informacion_clientes, aes(P6050)) + geom_bar(fill = "red") + labs(title= "COMPOSICION FAMILIAR CLIENTES EN LA RED", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="Parentezco con Jefe de Hogar", caption = "Info Clientes - Fase1")

#################################################           P6070                ###
#                                                 ACTUALMENTE: ESTADO CIVIL

describe(informacion_clientes$P6070)
table(informacion_clientes$P6070)
prop.table(table(informacion_clientes$P6070))
names(which(table(informacion_clientes$P6070) == max(table(informacion_clientes$P6070))))

ggplot(informacion_clientes, aes(P6070)) + geom_bar(aes(fill= P6020)) + labs(title= "ESTADO CIVIL POR GÉNERO CLIENTES EN LA RED", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="Estado civil", caption = "Info Clientes - Fase1")

#################################################           P6090                ###
#¿...ESTÁ AFILIADO, ES COTIZANTE O ES BENEFICIARIO DE ALGUNA ENTIDAD DE SEGURIDAD SOCIAL EN SALUD?

describe(informacion_clientes$P6090)
table(informacion_clientes$P6090)
prop.table(table(informacion_clientes$P6090))
names(which(table(informacion_clientes$P6090) == max(table(informacion_clientes$P6090))))

ggplot(informacion_clientes, aes(P6090)) + geom_bar(fill= "steelblue") + labs(title= "Afiliaciones a Seguridad Social", subtitle="Informacion Clientes Empresa En la Red", y= "Cant.", x="Tiene - No tiene SS", caption = "Info Clientes - Fase1")
pie(table(informacion_clientes$P6090), col = c("orange", "white", "steelblue"), main = "Afiliaciones a Seguridad Social")


#################################################           P6140                ###
#¿ANTERIORMENTE ESTUVO ... AFILIADO, FUE COTIZANTE O BENEFICIARIO DE ALGUNA ENTIDAD DE SEGURIDAD SOCIAL EN SALUD?

subset3 <- informacion_clientes[!is.na(informacion_clientes$P6140),]

describe(subset3$P6140)
table(subset3$P6140)
prop.table(table(subset3$P6140))
names(which(table(subset3$P6140) == max(table(subset3$P6140))))

ggplot(subset3, aes(P6140)) + geom_bar(fill= "pink") + labs(title= "Tuvo SS en el pasado (Sin SS Actualmente)", subtitle="Informacion Clientes Empresa En la Red", y= "Cant.", x="Tuvo - No tuvo SS", caption = "Info Clientes - Fase1")

#################################################           P6150                ###
#¿CUÁNTOS MESES HACE QUE ... NO ESTÁ AFILIADO O NO COTIZA A LA SEGURIDAD SOCIAL EN SALUD?

subset4 <- informacion_clientes[!is.na(informacion_clientes$P6150),]

summary(subset4$P6150)
describe(subset4$P6150)
mean(subset4$P6150, trim = 10)
median(subset4$P6150)
Moda(subset4$P6150)
sd(subset4$P6150)
var(subset4$P6150)
quantile(subset4$P6150)
range(subset4$P6150)

ggplot(subset4, aes(P6150)) + geom_boxplot(fill = "orange", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Tiempo Sin Afiliacion a SS (Meses)", subtitle="Informacion Clientes Empresa En la Red", y="", x="Cantidad de Meses", caption = "Info Clientes - Fase1")


#################################################           P6100                ###
#    ¿A CUAL DE LOS SIGUIENTES REGÍMENES DE SEGURIDAD SOCIAL EN SALUD ESTÁ AFILIADO:


subset5 <- informacion_clientes[!is.na(informacion_clientes$P6100),]

describe(subset5$P6100)
table(subset5$P6100)
prop.table(table(subset5$P6100))
names(which(table(subset5$P6100) == max(table(subset5$P6100))))

ggplot(subset5, aes(P6100)) + geom_bar(fill= "aquamarine2") + labs(title= "Régimenes de Seguridad Social", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="Regimen", caption = "Info Clientes - Fase1")


#################################################           P6110               ###
#                                ¿QUIÉN PAGA MENSUALMENTE POR LA AFILIACIÓN DE ...?

subset6 <- informacion_clientes[!is.na(informacion_clientes$P6110),]

describe(subset6$P6110)
table(subset6$P6110)
prop.table(table(subset6$P6110))
names(which(table(subset6$P6110) == max(table(subset6$P6110))))

pie(table(subset6$P6110), col = c("cyan", "orange", "white", "pink", "steelblue", "yellow"), main = "¿QUIÉN PAGA MENSUALMENTE POR LA AFILIACIÓN DE...?")

ggplot(subset6, aes(P6110)) + geom_bar(fill= c("aquamarine2", "orange", "grey", "pink", "steelblue", "yellow")) + labs(title= "¿QUIÉN PAGA MENSUALMENTE POR LA AFILIACIÓN DE...?", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="Aportante", caption = "Info Clientes - Fase1")

#################################################           P6120                ###
#¿CUÁNTO PAGA O CUÁNTO LE DESCUENTAN MENSUALMENTE? (SI NO SABE CUANTO PAGA O CUANTO LE DESCUENTAN ESCRIBA 98)

subset7 <- informacion_clientes[!is.na(informacion_clientes$P6120),]

summary(subset7$P6120)
describe(subset7$P6120)
mean(subset7$P6120, trim = 10)
median(subset7$P6120)
Moda(subset7$P6120)
sd(subset7$P6120)
var(subset7$P6120)
quantile(subset7$P6120)
range(subset7$P6120)

ggplot(subset7, aes(P6120)) + geom_boxplot(fill = "blue", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Monto consignado a SS", subtitle="Informacion Clientes Empresa En la Red", y="", x="Monto", caption = "Info Clientes - Fase1")

#################################################           P6125               ###
#¿EN LOS ÚLTIMOS DOCE MESES DEJÓ DE ASISTIR AL MÉDICO O NO SE HOSPITALIZÓ, POR NO TENER CON QUE PAGAR ESTOS SERVICIOS EN LA EPS O ARS?

describe(informacion_clientes$P6125)
table(informacion_clientes$P6125)
prop.table(table(informacion_clientes$P6125))
names(which(table(informacion_clientes$P6125) == max(table(informacion_clientes$P6125))))

ggplot(informacion_clientes, aes(P6125)) + geom_bar(fill= c("aquamarine2", "grey", "orange")) + labs(title= "En los ultimos 12 meses dejó de asistir a la EPS, por no tener con que pagar", subtitle="Informacion Clientes Empresa En la Red", y="Frecuencia", x="", caption = "Info Clientes - Fase1")


#################################################           P6160               ###
#                                                      ¿SABE LEER Y ESCRIBIR?

describe(informacion_clientes$P6160)
table(informacion_clientes$P6160)
prop.table(table(informacion_clientes$P6160))
names(which(table(informacion_clientes$P6160) == max(table(informacion_clientes$P6160))))

ggplot(informacion_clientes, aes(P6160)) + geom_bar(fill= c("magenta", "orange")) + labs(title= "¿Sabe leer y escribir?", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################           P6170               ###
#                      ¿ACTUALMENTE ... ASISTE A LA ESCUELA, COLEGIO O UNIVERSIDAD?


describe(informacion_clientes$P6170)
table(informacion_clientes$P6170)
prop.table(table(informacion_clientes$P6170))
names(which(table(informacion_clientes$P6170) == max(table(informacion_clientes$P6170))))

ggplot(informacion_clientes, aes(P6170)) + geom_bar(fill= c("orange", "yellow")) + labs(title= "¿Actualmente asiste a la escuela, colegio, universidad?", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")


#################################################           P6175               ###
#                                 EL ESTABLECIMIENTO AL QUE ASISTE ... ¿ES OFICIAL?

subset8 <- informacion_clientes[!is.na(informacion_clientes$P6175),]

describe(subset8$P6175)
table(subset8$P6175)
prop.table(table(subset8$P6175))
names(which(table(subset8$P6175) == max(table(subset8$P6175))))

ggplot(subset8, aes(P6175)) + geom_bar(fill= c("magenta", "cyan")) + labs(title= "Asiste a establecimiento de educacion OFICIAL", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")


#################################################           P6210               ###
#¿CUÁL ES EL NIVEL EDUCATIVO MÁS ALTO ALCANZADO POR ... Y EL ÚLTIMO AÑO O GRADO APROBADO EN ESTE NIVEL?

describe(informacion_clientes$P6210)
table(informacion_clientes$P6210)
prop.table(table(informacion_clientes$P6210))
names(which(table(informacion_clientes$P6210) == max(table(informacion_clientes$P6210))))

ggplot(informacion_clientes, aes(P6210)) + geom_bar(fill= c("aquamarine2", "orange", "grey", "pink", "steelblue", "yellow", "magenta")) + labs(title= "Nivel Educativo", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################           P6210S1                ###
#                                                         GRADO

summary(informacion_clientes$P6210S1)
describe(informacion_clientes$P6210S1)
mean(informacion_clientes$P6210S1, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P6210S1)
sd(informacion_clientes$P6210S1)
var(informacion_clientes$P6210S1)
quantile(informacion_clientes$P6210S1)
range(informacion_clientes$P6210S1)

table(informacion_clientes$P6210S1)

ggplot(informacion_clientes, aes(P6210S1)) + geom_boxplot(fill = "pink", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Grado Cursado / En Curso", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="Grado", caption = "Info Clientes - Fase1")


#################################################           P6220               ###
#        ¿CUÁL ES EL TÍTULO O DIPLOMA DE MAYOR NIVEL EDUCATIVO QUE USTED HA RECIBIDO?

subset9 <- informacion_clientes[!is.na(informacion_clientes$P6220),]

describe(subset9$P6220)
table(subset9$P6220)
prop.table(table(subset9$P6220))
names(which(table(subset9$P6220) == max(table(subset9$P6220))))

ggplot(subset9, aes(P6220)) + geom_bar(fill= c("aquamarine2", "orange", "grey", "pink", "steelblue", "magenta")) + labs(title= "Nivel Educativo - 2", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################           CLASE              ###

describe(informacion_clientes$CLASE)
table(informacion_clientes$CLASE)
prop.table(table(informacion_clientes$CLASE))
names(which(table(informacion_clientes$CLASE) == max(table(informacion_clientes$CLASE))))

ggplot(informacion_clientes, aes(CLASE)) + geom_bar() + labs(title= "CLASE", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################           ESC               ###
#                                                       ESCOLARIDAD

subset10 <- informacion_clientes[!is.na(informacion_clientes$ESC),]

describe(subset10$ESC)
summary(subset10$ESC)
mean(subset10$ESC, trim = 10)
median(subset10$ESC)
Moda(subset10$ESC)
sd(subset10$ESC)
var(subset10$ESC)
quantile(subset10$ESC)
range(subset10$ESC)

ggplot(subset10, aes(ESC)) + geom_boxplot(fill = "pink", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Escolaridad", subtitle="Informacion Clientes Empresa En la Red", y="", x="Años de Escolaridad", caption = "Info Clientes - Fase1")
ggplot(subset10, aes(ESC)) + geom_bar(aes(fill= P6020)) + labs(title= "Escolaridad", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="Grados Cursados", caption = "Info Clientes - Fase1")

#################################################           MES              ###

describe(informacion_clientes$MES)
table(informacion_clientes$MES)
prop.table(table(informacion_clientes$MES))
names(which(table(informacion_clientes$MES) == max(table(informacion_clientes$MES))))

ggplot(informacion_clientes, aes(MES)) + geom_bar() + labs(title= "MES", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################           DEPARTAMENTO             ###

describe(informacion_clientes$DPTO)
table(informacion_clientes$DPTO)
prop.table(table(informacion_clientes$DPTO))
names(which(table(informacion_clientes$DPTO) == max(table(informacion_clientes$DPTO))))

ggplot(informacion_clientes, aes(DPTO)) + geom_bar(aes(fill= P6020)) + labs(title= "Departamento", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################           P212                     ###
#                                             ¿TIENE TARJETA DE CRÉDITO?

describe(informacion_clientes$P212)
table(informacion_clientes$P212)
prop.table(table(informacion_clientes$P212))
names(which(table(informacion_clientes$P212) == max(table(informacion_clientes$P212))))

ggplot(informacion_clientes, aes(P212)) + geom_bar() + labs(title= "¿Tiene Tarjeta de Crédito?", subtitle="Informacion Clientes Empresa En la Red", y="Cant.", x="", caption = "Info Clientes - Fase1")

#################################################                 P213             ###
#                                                ¿CUÁL ES SU INGRESO MENSUAL ESTIMADO?

summary(informacion_clientes$P213)
describe(informacion_clientes$P213)
mean(informacion_clientes$P213, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P213)
sd(informacion_clientes$P213)
var(informacion_clientes$P213)
quantile(informacion_clientes$P213)
range(informacion_clientes$P213)

table(informacion_clientes$P213)

ggplot(informacion_clientes, aes(P213)) + geom_boxplot(fill = "steelblue", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Ingreso Mensual Estimado", subtitle="Informacion Clientes Empresa En la Red", y="", x="Monto de Ingresos Mensuales Estimados", caption = "Info Clientes - Fase1")

#################################################                 P214             ###
#                         ¿Cuál FUE EL MONTO DE LA COMPRA REALIZADA EN NUESTRA TIENDA?


summary(informacion_clientes$P214)
describe(informacion_clientes$P214)
mean(informacion_clientes$P214, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P214)
sd(informacion_clientes$P214)
var(informacion_clientes$P214)
quantile(informacion_clientes$P214)
range(informacion_clientes$P214)

table(informacion_clientes$P214)

ggplot(informacion_clientes, aes(P214)) + geom_boxplot(fill = "steelblue", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Monto de Compra en Tienda", subtitle="Informacion Clientes Empresa En la Red", y="", x="Monto en pesos (COP)", caption = "Info Clientes - Fase1")


#################################################                 P215             ###
#                              ¿Cuál FUE EL MONTO GASTADO EN TIENDAS SIMILARES?


summary(informacion_clientes$P215)
describe(informacion_clientes$P215)
mean(informacion_clientes$P215, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P215)
sd(informacion_clientes$P215)
var(informacion_clientes$P215)
quantile(informacion_clientes$P215)
range(informacion_clientes$P215)

table(informacion_clientes$P215)

ggplot(informacion_clientes, aes(P215)) + geom_boxplot(fill = "steelblue", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Monto Compras en Tiendas Similares", subtitle="Informacion Clientes Empresa En la Red", y="", x="Monto en pesos (COP)", caption = "Info Clientes - Fase1")

#################################################                 P216             ###
#                                               RENTA DISPONIBLE BRUTA DE LA REGION

summary(informacion_clientes$P216)
describe(informacion_clientes$P216)
mean(informacion_clientes$P216, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P216)
sd(informacion_clientes$P216)
var(informacion_clientes$P216)
quantile(informacion_clientes$P216)
range(informacion_clientes$P216)

table(informacion_clientes$P216)

ggplot(informacion_clientes, aes(P216)) + geom_boxplot(fill = "steelblue", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Renta Disponible Bruta de la Región", subtitle="Informacion Clientes Empresa En la Red", y="", x="Miles de millones de pesos (COP)", caption = "Info Clientes - Fase1")

#################################################                 P217              ###
#                                  GASTO TOTAL EN ALIMENTACION Y BEBIDAS NO ALCOHOLICAS

summary(informacion_clientes$P217)
describe(informacion_clientes$P217)
mean(informacion_clientes$P217, trim=0.10) #10% trimmed mean
Moda(informacion_clientes$P217)
sd(informacion_clientes$P217)
var(informacion_clientes$P217)
quantile(informacion_clientes$P217)
range(informacion_clientes$P217)

table(informacion_clientes$P217)

ggplot(informacion_clientes, aes(P217)) + geom_boxplot(fill = "steelblue", col="red", outlier.color = "red", outlier.fill = "red", outlier.shape = 19, outlier.size = 1.5, notch = TRUE) + labs(title= "Gasto en Alimentación y Bebidas no Alcoholicas", subtitle="Informacion Clientes Empresa En la Red", y="", x="Monto en pesos (COP)", caption = "Info Clientes - Fase1")

#########################################################################################









#MEDIDAS PARA VARIABLES CUANTITATIVAS
#length(var2)
#median(var1)
#mean(var1)
#mean(var1, trim=0.10) #10% trimmed mean
#min(var1)
#max(var1)
#desv_st=sd(var1)
#sd(var1)
#var(var1)
#quantile(var1)
#range(ejercicio)

#MEDIDAS PARA VARIABLES CUALITATIVAS
#moda de variables culitativas
#names(which(table(informacion_clientes$P6210) == max(table(informacion_clientes$P6210))))
#range(ejercicio)




