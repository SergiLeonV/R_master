library("sleuth")
library("tidyverse")
library("biomaRt")
library("ggrepel")
library("org.Mm.eg.db")
library("clusterProfiler")
library("enrichplot")
library("ggnewscale")
library("pathview")
library("DOSE")


### Nos colocamos en la carpeta de interés para cargar las cuantificaciones: 
setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/CODE/")

### Generamos los argumentos necesarios para la tabla:
sample_id <- dir(file.path("..","quantif"))
kal_dirs <- file.path("..", "quantif", sample_id)
condicion <- c(rep("Control",3),rep("RR",3))

#### SLEUTH A NIVEL DE GEN. 
mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                         dataset = "mmusculus_gene_ensembl",
                         host = "http://may2021.archive.ensembl.org")
ttg <- getBM(
  attributes = c("ensembl_transcript_id",
                 "ensembl_gene_id","external_gene_name"),
  mart = mart)
ttg <- rename(ttg, target_id = ensembl_transcript_id,
                     ens_gene = ensembl_gene_id, ext_gene = external_gene_name)
head(ttg)

######

### Generamos la tabla con los argumentos y nombres de interés:
tabla <- data.frame(sample_id,condicion,kal_dirs)
names(tabla) <- c("sample","cond","path")


### APLICAMOS SLEUTH PARA OBTENER LA CUANTIFICACIÓN:
so <- sleuth_prep(tabla,target_mapping = ttg,
                  aggregation_column = 'ens_gene',
                  extra_bootstrap_summary = TRUE,
                  gene_mode=TRUE)

### AJUSTAMOS LOS MODELOS Y OBTENEMOS LOS OBJETOS DE INTERÉS:
so <- sleuth_fit(so, ~cond, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_wt(so, which_beta = 'condRR', which_model = 'full')
sleuth_table <- sleuth_results(so, 'condRR', 'wt')

# saveRDS(object = so, file="/Users/sergioleon/Desktop/TFM/R_MASTER/quantif/so_RRL3_genemode.rds")
# saveRDS(object = sleuth_table, file = "/Users/sergioleon/Desktop/TFM/R_MASTER/quantif/L3RRquantification_genemode.rds")
