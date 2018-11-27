library(ggplot2)
library(cluster)

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

#clusters = pam(dismiss.matrix,4,diss=TRUE)
clusters = pam(hepatitis.without.na,4,diss=FALSE, metric="euclidean")


summary(clusters)
plot(clusters)

