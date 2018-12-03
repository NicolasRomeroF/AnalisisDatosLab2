library(ggplot2)
library(cluster)
library(factoextra)
library(fpc)
library(dplyr)
library(rgl)

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


data.discretas = select(hepatitis.without.na, -AGE, -BILIRUBIN, -ALK_PHOSPHATE, -SGOT, -ALBUMIN, -PROTIME)

data.continuas = select(hepatitis.without.na, AGE, BILIRUBIN, ALK_PHOSPHATE, SGOT, ALBUMIN, PROTIME)

data.1 = select(hepatitis.without.na, AGE,BILIRUBIN, SGOT,PROTIME)

kmeans.cont = kmeans(data.continuas[,1:3], 3)

plot3d(data.continuas[,1:3], kmeans.cont$cluster)

pc = princomp(data, cor=FALSE, scores= TRUE)

plot(pc,type="lines")

summary(pc)

# fviz_nbclust(data.discretas, pam, method = "wss") +
#   geom_vline(xintercept = 3, linetype = 2)
# 
# clusters = pam(data.discretas,3,diss=FALSE, metric="manhattan")
# 
# summary(clusters)
# 
# fviz_cluster(clusters, data = NULL, stand = TRUE,
#              geom = "point", 
#              ellipse = TRUE, ellypse.type = "convex")

# diss.matrix = daisy(data, metric = "euclidean",
#                stand = FALSE)

fviz_nbclust(data, pam, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)

clusters = pam(data,3,diss=FALSE, metric="euclidean")

summary(clusters)

clusplot(clusters)

#fviz_cluster(clusters, data = NULL, stand = TRUE,
#             geom = "point", 
#             ellipse = TRUE, ellypse.type = "convex")
