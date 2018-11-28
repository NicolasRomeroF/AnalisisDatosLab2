library(ggplot2)
library(cluster)
library(factoextra)
library(fpc)
library(dplyr)
#path = "F:/Google Drive/USACH/Nivel 8/Analisis de datos/lab2/hepatitis.data"
path = "~/Documentos/AnalisisDatosLab2/hepatitis.data"
hepatitis <- read.table(path,sep=",", na.strings = c("?"))

names <- c("CLASS","AGE","SEX","STEROID","ANTIVIRALS","FATIGUE","MALAISE",
           "ANOREXIA","LIVER_BIG","LIVER_FIRM","SPLEEN_PALPABLE","SPIDERS",
           "ASCITES","VARICES","BILIRUBIN","ALK_PHOSPHATE","SGOT","ALBUMIN",
           "PROTIME","HISTOLOGY")

colnames(hepatitis) <- names

hepatitis.without.na <- na.omit(hepatitis)

# clusters <- kmeans(hepatitis.without.na, centers = 5, trace = TRUE)
# 
# hepatitis.without.na$CLUSTERS <- as.factor(clusters$cluster)
# 
# str(clusters)

#dismiss.matrix = daisy(hepatitis.without.na)

data = select(hepatitis.without.na,-CLASS)

#clusters = pam(dismiss.matrix,4,diss=TRUE)
clusters = pam(data,20,diss=FALSE, metric="euclidean")
#clusters = pamk(hepatitis.without.na,krange=2:10,criterion="asw",usepam=TRUE,
#                scaling=FALSE,alpha=0.05,diss=FALSE,critout=FALSE, ns=10, seed=NULL)
summary(clusters)

#clusplot(clusters, clus, main = NULL, stand = FALSE, color = FALSE,
#         labels = 0)
fviz_cluster(clusters, data = NULL, stand = TRUE,
             geom = "point", 
             ellipse = TRUE, ellypse.type = "convex")
