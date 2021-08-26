#### VAMOS A TRABAJAR CON LOS ARCHIVOS DE SNP TOTALES GENERADOS EN DNA
#### EN LAS DISTINTAS LINEAS CELULARES:


### Nos situamos en la carpeta de interés:
setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/")


### Cargamos lo necesario para correr el programa:

library(readr)
library(circlize)
library(tidyverse)
library(futile.logger)
library(VennDiagram)
library(xlsx)

### SNP de lacun3RR comparados con BALBc:
totalSNP_DNA_BALBC_Lacun3RR_annotated_mm39_multianno <- read_delim("DATA/SNP_data_DNA/totalSNP_DNA_BALBC_Lacun3RR.annotated.mm39_multianno.txt", 
                                                                   delim = "\t", escape_double = FALSE, 
                                                                   trim_ws = TRUE)

### SNP de lacun3 comparados con BALBc:
totalSNP_DNA_BALBC_Lacun3_annotated_mm39_multianno <- read_delim("DATA/SNP_data_DNA/totalSNP_DNA_BALBC_Lacun3.annotated.mm39_multianno.txt", 
                                                                 delim = "\t", escape_double = FALSE, 
                                                                 trim_ws = TRUE)


### Obtenemos el número de SNP que se diferencian funcionalmente:
Lacun3_funciones <- data.frame(n=table(totalSNP_DNA_BALBC_Lacun3_annotated_mm39_multianno$Func.wgEncodeGencodeBasicVM27)) %>%
  arrange(desc(n.Freq))

Lacun3RR_funciones <- data.frame(n=table(totalSNP_DNA_BALBC_Lacun3RR_annotated_mm39_multianno$Func.wgEncodeGencodeBasicVM27)) %>%
  arrange(desc(n.Freq))

ggplot(data=Lacun3_funciones, aes(x= reorder(Lacun3_funciones$n.Var1, -Lacun3_funciones$n.Freq),
                                  y = Lacun3_funciones$n.Freq, fill=Lacun3_funciones$n.Var1))+
  geom_bar(stat = "identity")+
  labs(title = "SNP type from Lacun3.",
       x="",
       y="frequency",
       fill="Leyenda")+
  theme(axis.text.x = element_blank())

ggplot(data=Lacun3RR_funciones, aes(x= reorder(Lacun3RR_funciones$n.Var1, -Lacun3RR_funciones$n.Freq),
                                  y = Lacun3RR_funciones$n.Freq, fill=Lacun3RR_funciones$n.Var1))+
  geom_bar(stat = "identity")+
  labs(title = "SNP type from Lacun3RR",
       x="",
       y="frequency",
       fill="Leyenda")+
  theme(axis.text.x = element_blank())


## OBTENEMOS EL NUMERO DE SNP QUE SON FUNCIONALMENTE INTERESANTSE (EXONICAS NONSYN.):
exonic_Lacun3 <- totalSNP_DNA_BALBC_Lacun3_annotated_mm39_multianno %>% 
  filter(Func.wgEncodeGencodeBasicVM27 == "exonic")

ns_Lacun3 <- exonic_Lacun3 %>% 
  filter(ExonicFunc.wgEncodeGencodeBasicVM27 == "nonsynonymous SNV")
ns_Lacun3 <- ns_Lacun3[!duplicated(ns_Lacun3$Start),]


exonic_Lacun3RR <- totalSNP_DNA_BALBC_Lacun3RR_annotated_mm39_multianno %>% 
  filter(Func.wgEncodeGencodeBasicVM27 == "exonic")

ns_Lacun3RR <- exonic_Lacun3RR %>% 
  filter(ExonicFunc.wgEncodeGencodeBasicVM27 == "nonsynonymous SNV")
ns_Lacun3RR <- ns_Lacun3RR[!duplicated(ns_Lacun3RR$Start),]



###################
### HACEMOS UN VENN.DIAGRAM PARA VER VISUALMENTE COMO SE DISTRIBUYEN LAS MUTACIONES NO SINONIMAS:
venn.diagram(
  x=list(
    ns_Lacun3$Start,
    ns_Lacun3RR$Start),
  filename = "RESULTS/DNA_nsL3andL3RR_SNPsVenn.png",
  output = TRUE,
  resolution=300,
  compression="lzw",
  lwd=7,
  main="non-synonimous mutations",
  main.cex=2,
  main.pos=c(0.5,1),
  main.fontface = "bold",
  main.fontfamily = "sans",
  category.names = c("L3_nonsynonimous\nmutations", "L3RR_nonsynonimous\nmutations"),
  cat.cex=1,
  cat.fontfamily="sans",
  cat.fontface="bold",
  cat.pos=c(320, 45),
  cat.dist=c(0.04,0.04),
  cat.col=c("#440154ff","#21908dff"),
  col=c("#440154ff","#21908dff"),
  fill=c(alpha("#440154ff",0.3),alpha("#21908dff",0.3)),
  cex=c(1,4,1),
  fontfamily="sans",
  fontface="bold"
)

####### OBTENEMOS EL NUMERO DE GENES Y SNP QUE PRESENTAN CADA UNO DE ELLOS. 
Lacun3RR_genes <- data.frame(n=table(ns_Lacun3RR$Gene.wgEncodeGencodeBasicVM27)) %>%
  arrange(desc(n.Freq))

Lacun3_genes <- data.frame(n=table(ns_Lacun3$Gene.wgEncodeGencodeBasicVM27)) %>%
  arrange(desc(n.Freq))


### FINALMENTE OBTENEMOS LOS GENES QUE TIENE EXCLUSIVAMENTES MUTACIONES EN LAS L3RR Y L3, ADEMAS DE TODOS LOS QUE COMPARTEN:
venn.diagram(
  x=list(
    Lacun3_genes$n.Var1,
    Lacun3RR_genes$n.Var1),
  filename = "RESULTS/differentially_genes_Lacun3RR.png",
  main="Differentially mutated genes.",
  main.pos=c(0.5,1.1),
  main.fontface="bold",
  main.fontfamily="sans",
  main.cex=1.8,
  output = TRUE,
  resolution=300,
  compression="lzw",
  lwd=7,
  category.names = c("Lacun3 mutated\ngenes", "Lacun3 RR mutated\ngenes"),
  cat.cex=1.3,
  cat.fontfamily="sans",
  cat.fontface="bold",
  cat.pos=c(320, 40),
  cat.dist=c(0.04,0.042),
  cat.col=c("#440154ff","#21908dff"),
  col=c("#440154ff","#21908dff"),
  fill=c(alpha("#440154ff",0.7),alpha("#21908dff",0.7)),
  cex=c(2,3,2),
  fontfamily="sans",
  fontface="bold"
)


##### EXTRAIGO LAS LISTAS DE LOS GENES QUE SON EXCLUSIVOS EN CADA CONDICIÓN:
Lacun3RR_nombres <- as.character(Lacun3RR_genes$n.Var1)
Lacun3_nombres <- as.character(Lacun3_genes$n.Var1)

only_Lacun3RR_genes <- as.data.frame(Lacun3RR_nombres[!Lacun3RR_nombres %in% Lacun3_nombres])
names(only_genes) <- "Mutated genes in Lacun3RR"
only_Lacun3_genes <- as.data.frame(Lacun3_nombres[!Lacun3_nombres %in% Lacun3RR_nombres])
names(only_Lacun3) <- "Mutated genes in Lacun3"







