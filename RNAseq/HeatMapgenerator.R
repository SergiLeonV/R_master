##### PROGRAMA PARA GENERAR HEATMAPS DE LAS CATEGORIAS DEL GSEA. 
##### INTRODUCIR EL NOMBRE DE LA CATEGORÍA DE INTERÉS. 

library("pheatmap")
library("tidyverse")


#### CARGAMOS LOS DATOS NECESARIOS. 
setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/")
sleuth_table <- readRDS("RNA_quant/L3RRquantification_genemode_datoslimpios.rds")
so <- readRDS("RNA_quant/so_RRL3_genemode.rds")
res_gse <- readRDS("RNA_quant/resultados_categorias_L3RR.rds")
gse <- readRDS("RNA_quant/gsea_L3RR_allGO.rds")

################# INTRODUCIR EL NOMBRE DE LA VIA (categoría GO) ################
num_nombre <- which(res_gse$Description=="negative regulation of chromosome separation")
################################################################################


### GENERAMOS EL PROGRAMA NECESARIO PARA HACER EL HEATMAP CON LOS GENES Y TITULO NECESARIO:

kkhrr <- res_gse[num_nombre,]
genes_hrr <- kkhrr %>% dplyr::select(core_enrichment)
kkhrr <- genes_hrr[1,1]
total_genes_hrr <- str_count(kkhrr,"/")
num_hrr <- seq(1:(total_genes_hrr+1))
kkhrr <- separate(genes_hrr,col = core_enrichment, into = as.character(num_hrr), sep = "/")

### extraemos los ensmusg de los entrez correspondientes a los genes que forman parte del hrr sign. 
est_hrr <- as.data.frame(num_hrr)
guardar_nombres <- matrix(nrow = length(num_hrr), ncol = 2)
for (i in seq_along(num_hrr)){
  buscar <- kkhrr[1,i]
  est_introducir <- sleuth_table[which(sleuth_table$entrez==buscar),1]
  guardar_nombres[i,1] <- sleuth_table[which(sleuth_table$entrez==buscar),1]
  guardar_nombres[i,2] <- sleuth_table[which(sleuth_table$entrez==buscar),2]
  est_hrr[i,1] <- est_introducir
}
########################################3
buscar_hrr <- dim(est_hrr)[1]
so_hrr <- matrix(nrow = buscar_hrr*6, ncol = dim(so$obs_norm)[2])
indices <- seq(1,dim(so_hrr)[1], by = 6)

for (i in (seq_along(1:buscar_hrr))){
  buscar <- est_hrr[i,1]
  ind_lista <- indices[i]
  num_buscar <- which(so$obs_norm$target_id==buscar)
  meter <- so$obs_norm[num_buscar,]
  so_hrr[ind_lista:(6*i),] <- as.matrix(meter)
}

so_hrr <- as.data.frame(so_hrr)
colnames(so_hrr) <- colnames(meter)
so_hrr$tpm <- as.numeric(so_hrr$tpm)

##########################
so_hrr1 <- so_hrr %>% 
  dplyr::select(-scaled_reads_per_base)
so_hrr2 <- pivot_wider(data = so_hrr1, names_from = sample, values_from = tpm)
so_hrr3 <- so_hrr2 %>% 
  dplyr::select(-target_id)

so_matriz <- as.matrix(so_hrr3)
row.names(so_matriz) <- guardar_nombres[,2]
dibujar <- 40
if (dim(so_matriz)[1] > dibujar) {
  pheatmap(so_matriz[1:dibujar,], main = res_gse$Description[num_nombre])
} else {
  pheatmap(so_matriz, main = res_gse$Description[num_nombre]) 
}

