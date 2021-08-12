### INTRODUCIMOS EL VCF ANOTADO PARA VER LA TABLA Y REPRSENTAR: 


library(readr)
library(tidyverse)
library(circlize)
library(ComplexHeatmap)

setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/")
# snp_anotado <- read_delim("SNP_data_DNA/vcf_SNP_DNA_L3vsRR.anno.mm10_multianno.txt", 
#                           "\t", escape_double = FALSE, trim_ws = TRUE)
# saveRDS(snp_anotado, "/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/SNP_DNA/SNPanotados_DNA_L3vsRR.rds")

#### COMPLETAR EL ARCHIVO QUE QUEREMOS CARGAR:
snp_anotado <- readRDS("SNP_RNA/snp_anotados_RNA_L3vsRR.rds")
snp <- readRDS("SNP_RNA/SNP_RNA_RRvsLACUN3.rds")


## barras con las localizaciones de las mutaciones: 
kk <- data.frame(n=table(snp_anotado$Func.refGene)) %>%
  arrange(desc(n.Freq))

ggplot(data=kk, aes(x= reorder(kk$n.Var1, -kk$n.Freq), y = kk$n.Freq, fill=kk$n.Var1))+
  geom_bar(stat = "identity")+
  labs(title = "SNP types",
       x="",
       y="Frecuencia",
       fill="Leyenda")+
  theme(axis.text.x = element_blank())
  
## Seleccionamos únicamente las mutaciones que ocurren en los exones y aquellas que son no sinonimas

snp_anotado_exonico <- snp_anotado %>% 
  filter(Func.refGene == "exonic")
snp_nosinonimo <- snp_anotado_exonico %>% 
  filter(ExonicFunc.refGene == "nonsynonymous SNV")


#### CARGAMOS LAS MUTACIONES QUE DEJAMOS FILTRADAS PARA VER AQUELLAS QUE COINCIDEN CON LAS QUE NOS INTERESAN A NOSOTROS: 
snp_filtrado <- readRDS("SNP_RNA/snp_noanotados_filtrados_RNA_L3vsRR.rds")
#write.xlsx(snp_nosinonimo, "/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/snp_nosinonimos.xlsx")
prueba <- inner_join(x = snp_filtrado,y = snp_nosinonimo, by= c("position"="Start"))


### GENERAMOS UN CÍRCULO CON LAS MUTACIONES EXONICAS NO SINONIMAS MÁS IMPORTANTES. 
circos.par("start.degree" = 90)
circos.initializeWithIdeogram(species = "mm10")
circos.genomicDensity(snp_anotado_exonico, col = 3)
circos.genomicDensity(snp_nosinonimo, col = 2)
circos.genomicDensity(prueba, col = 4)

lgd_exon <-Legend(at = "Exonic",
                  title_position = "lefttop-rot",
                  type = "points",
                  legend_gp = gpar(col=3))
lgd_ns <-Legend(at = "Non-synonymous",
                  title_position = "lefttop-rot",
                  type = "points",
                  legend_gp = gpar(col=2))
lgd_bien <-Legend(at = "selected",
                title_position = "lefttop-rot",
                type = "points",
                legend_gp = gpar(col=4))

lgd_total <- packLegend(lgd_exon, lgd_ns, lgd_bien)
draw(lgd_total, x = unit(25, "mm"), y = unit(25, "mm"))
title(main = "SNPs for RNA")

### VAMOS A GENERAR TAMBIÉN CON EL TOTAL DE MUTACIONES: 

circos.par("start.degree" = 90)
circos.initializeWithIdeogram(species = "mm10")
circos.genomicDensity(snp_anotado, col = 1)
circos.genomicDensity(snp_filtrado, col = 5)
lgd_todos <-Legend(at = "Total_SNPs",
                  title_position = "lefttop-rot",
                  type = "points",
                  legend_gp = gpar(col=1))
lgd_filtered <-Legend(at = "Filtered",
                title_position = "lefttop-rot",
                type = "points",
                legend_gp = gpar(col=5))
lgd_1 <- packLegend(lgd_todos,lgd_filtered)
draw(lgd_1, x = unit(25, "mm"), y = unit(25, "mm"))




