### GENERAMOS LA TABLA DE GENES CON LOS L2FC. 

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
library("xlsx")
library("EnhancedVolcano")
library("pheatmap")


### VAMOS A EJECUTAR TODO EN GENE MODE: 
setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/")
sleuth_table <- readRDS("L3RRquantification_genemode.rds")
so <- readRDS("so_RRL3_genemode.rds")
gsea_L3RR_allGO <- readRDS(file = "gsea_L3RR_allGO.rds")
res_gse <- readRDS("resultados_categorias_L3RR.rds")
#sleuth_table <- separate(sleuth_table,target_id,into = c("kk","kk2","kk3","kk4","kk5","gene_name"),sep = "\\|")

# gencode_vM27_annotation_gtf <- read_delim("~/Desktop/TFM/R_MASTER/gencode.vM27.annotation.gtf", 
#                                       "\t", escape_double = FALSE, col_names = FALSE, 
#                                       trim_ws = TRUE, skip = 5)

#### MANIPULAMOS LA TABLA PARA GUARDAR LOS NOMBRES Y LOS ENTREZ DE MANERA CORRECTA: 
sleuth_table$entrez <- mapIds(x = org.Mm.eg.db, 
                              keys = sleuth_table$target_id,
                              column= "ENTREZID",
                              keytype = "ENSEMBL")

#sleuth_table$entrez[195] <- " 3014" ## INTRODUCIMOS ESTE ENTREZ PARA TENERLO EN CUENTA. 
borrar <- complete.cases(sleuth_table) ### BORRAMOS TODAS LAS FILAS EN LAS QUE APARECEN NA. 

sleuth_table <- sleuth_table[borrar,] ############ HASTA AQUI QUITAMOS TODOS LOS NA. TENEMOS QUE SEGUIR ELIMINANDO LOS REPETIDOS. 
sleuth_table <- sleuth_table[!duplicated(sleuth_table$entrez),]

#saveRDS(sleuth_table, "L3RRquantification_genemode_datoslimpios.rds")

#sleuth_table <- sleuth_table %>% 
 # select(-(kk:kk5))
#### GENERAMOS UN VOLCANO PLOT QUE NOS PERMITE VER FACILMETNE LOS GENES DIFERENCIALMEBTE EXPRESADOS: 

###################

# volcano_data <- sleuth_table %>% 
#   mutate(sig=ifelse(pval < 0.05,"sig", "no_sig")) %>% 
#   arrange(pval)
# ppef1 <- which(volcano_data$ext_gene == "Ppef1")
# klhl22 <- which(volcano_data$ext_gene == "Klhl22")
# mdm2 <- which(volcano_data$ext_gene == "Mdm2")
# volcano_data[ppef1,14] <- "Ppef1"
# volcano_data[klhl22,14] <- "klhl22"
# volcano_data[mdm2,14] <- "mdm2"
# 
# figura_volcano <- volcano_data %>% 
#   ggplot(aes(x=b, y=-log10(pval)))+
#   geom_point(aes(col=sig))+
#   scale_color_manual(values = c("yellow","blue","red","green", "black"))
# ### REPRESERNTO EL VOLCANO PLOT JUNTO CON CIERTOS GENES DE INTERÉS: 
# 
# figura_volcano +
#   geom_label_repel(data = volcano_data[c(ppef1,klhl22,mdm2),],
#                    aes(label=volcano_data$ext_gene[c(ppef1,klhl22,mdm2)]))
##########################
### USAMOS EL PAQUETE ENHANCEDVOLCANO. 
EnhancedVolcano(toptable = sleuth_table,
                lab = sleuth_table$ext_gene,
                selectLab = c("Ppef1","Mdm2", "Klhl22"),
                x = "b",
                y="qval",pointSize = 1.5,colAlpha = 0.2,
                labFace = "bold",
                col = c("aquamarine1","grey65","palegreen2","deeppink1"),
                drawConnectors = TRUE,
                widthConnectors = 1,
                labSize = 5)
# prueba_aumento <- sleuth_table %>% 
#   filter(b>2)
# 
# pruba_menos <- sleuth_table %>% 
#   filter(b < (-2))

#### UNA VEZ QUE GENERAMOS LA TABLA DE MANERA CORRECTA YA PASAMOS A HACER TODO EL ANALISIS GSEA: 

gene_list = sleuth_table$b
names(gene_list) = sleuth_table$entrez
gene_list = sort(gene_list, decreasing = TRUE)

organismo <- org.Mm.eg.db

#### COMPROBAMOS CON PPEF1. 
# chk1 <- "12649" # Se encuentra en la posición 46504. 
# pos_chek1 <- which(names(gene_list)=="12649")

### AHORA YA COMENZAMSO EL ANÁLISIS DE GSEA: 
#gse <- gseGO(geneList = gene_list,
#              ont = "ALL",
#              OrgDb = organismo,
#              pvalueCutoff = 0.01,
#              pAdjustMethod = "BH",
#              by = "fgsea")

#saveRDS(gse,"gsea_L3RR_allGO.rds")
gsea_L3RR_allGO <- readRDS(file = "gsea_L3RR_allGO.rds")
#res_gse <- gsea_L3RR_allGO@result
#saveRDS(res_gse, "/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/resultados_categorias_L3RR.rds")
#write.xlsx(x = res_gse,file = "GOcategories_L3RR.xlsx")
gse2 <- setReadable(gsea_L3RR_allGO,organismo,keyType = "ENTREZID")

### DIFERENTES REPRESENTACIONES. 
dotplot(gsea_L3RR_allGO,x='Count' ,color="p.adjust", showCategory=30)
# emapplot(gse2,layout = "nicely", showCategory = 30, color = "p.adjust")
# cnetplot(gse2,foldChange = gene_list, node_label = "category", showCategory = 10)
# ridgeplot(gsea_L3RR_allGO)

#### VAMOS A GENERAR EL GSEA PARA BP: 

# gse_cc <- gseGO(geneList = gene_list,
#              ont = "CC",
#              OrgDb = organismo,
#              pvalueCutoff = 0.01,
#              pAdjustMethod = "BH",
#              by = "fgsea")
# # saveRDS(gse_cc,"../RESULTS/gsea_cc.rds")
# 
# gse_bp <- readRDS("../RESULTS/gsea_bp.rds")
# gse_mf <- readRDS("../RESULTS/gsea_mf.rds")
# gse_cc <- readRDS("../RESULTS/gsea_cc.rds")

#res_bp <- gse_bp@result

dna_repair <- which(res_gse$Description == "DNA repair")
hom_repa <- which(res_gse$Description == "double-strand break repair via homologous recombination")
dsbreak <- which(res_gse$Description == "double-strand break repair")
gseaplot(gsea_L3RR_allGO,geneSetID = dna_repair, title=res_gse$Description[dna_repair]) 
gseaplot2(gsea_L3RR_allGO,geneSetID = c(dna_repair, hom_repa, dsbreak))

## SELECCIONAMOS LOS NES Y PVALORES: 
gsea_nes <- res_gse %>%
  filter(res_gse$Description == "DNA repair" | res_gse$Description == "double-strand break repair via homologous recombination"
         | res_gse$Description == "double-strand break repair") %>% 
  select(Description, NES, p.adjust)

#### BUSCAMOS LOS KEGG PATHWAYS. 

kegg_org <- "mmu"
kegg <- gseKEGG(geneList = gene_list,
                organism = kegg_org,
                pvalueCutoff = 0.05,
                pAdjustMethod = "BH",
                keyType = "ncbi-geneid")

kegg2 <- setReadable(x = kegg,OrgDb = organismo,keyType = "ENTREZID")

# cnetplot(kegg2,foldChange = gene_list,layout = "kk")
# gseaplot(kegg,geneSetID = 3,title = kegg@result$Description[which()])

# dme <- pathview(gene.data=gene_list,
#                 pathway.id="mmu03030",
#                 species = kegg_org)

hom_recomb <- pathview(gene.data=gene_list,
                 pathway.id=kegg@result$ID[which(kegg@result$Description == "Homologous recombination")],
                 species = kegg_org)

cell_cycle <- pathview(gene.data=gene_list,
                pathway.id=kegg@result$ID[which(kegg@result$Description == "Cell cycle")],
                species = kegg_org)
##################################################
#### COMPROBAMOS LA REPRESENTACIÓN DEL SO OBJECT. 
### comprobamos la máxima dimensión de la variación; 
plot_pca(obj = so, units = 'est_counts', color_by = 'cond')
### Comprobamos también que el aumento en los genes se corresponda con el fc obtenido: 
### PPEF1. 
plot_bootstrap(obj = so,
               target_id = 'ENSMUSG00000062168',
               color_by = 'cond')

##################################

#### BUSCAMOS TAMBIÉN LOS GENES DE DSBR-HRR Y HACEMOS EL HEATMAP DE LA CATEGORÍA. 
kkhrr <- res_gse %>% 
  filter(Description=="double-strand break repair")
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
pheatmap(so_matriz,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         cutree_rows = 2,
         cutree_cols = 2)

#### VAMOS A IMPLEMENTAR UN HEATMAP DE LA CATEGORIA QUE DESEEMOS DEL GSEA: (DNA REPAIR)

# Extraemos la columna de interés y la modificamos para que cada ENTREZID quede separado: 
#### OBRTENEMOS LOS GENES DE DNA_REPAIR: 
kkdnarepair <- res_gse %>% 
  filter(Description=="DNA repair")
genes_dnarepair <- kkdnarepair %>% dplyr::select(core_enrichment)
kkdnarepair <- genes_dnarepair[1,1]
total_genes_dnarepair <- str_count(kkdnarepair,"/")
num_dnarepair <- seq(1:(total_genes_dnarepair+1))
kkdnarepair <- separate(genes_dnarepair,col = core_enrichment, into = as.character(num_dnarepair), sep = "/")

### extraemos los ensmusg de los entrez correspondientes a los genes que forman parte del dna_repair sign. 

est_dnarepair <- as.data.frame(num_dnarepair)
guardar_nombres <- matrix(nrow = length(num_dnarepair), ncol = 2)

for (i in seq_along(num_dnarepair)){
  buscar <- kkdnarepair[1,i]
  est_introducir <- sleuth_table[which(sleuth_table$entrez==buscar),1]
  guardar_nombres[i,1] <- sleuth_table[which(sleuth_table$entrez==buscar),1]
  guardar_nombres[i,2] <- sleuth_table[which(sleuth_table$entrez==buscar),2]
  est_dnarepair[i,1] <- est_introducir
}

buscar_dnarepair <- dim(est_dnarepair)[1]
so_dna <- matrix(nrow = buscar_dnarepair*6, ncol = dim(so$obs_norm)[2])
indices <- seq(1,dim(so_dna)[1], by = 6)

for (i in (seq_along(1:buscar_dnarepair))){
  buscar <- est_dnarepair[i,1]
  ind_lista <- indices[i]
  num_buscar <- which(so$obs_norm$target_id==buscar)
  meter <- so$obs_norm[num_buscar,]
  so_dna[ind_lista:(6*i),] <- as.matrix(meter)
}

so_dna <- as.data.frame(so_dna)
colnames(so_dna) <- colnames(meter)
so_dna$tpm <- as.numeric(so_dna$tpm)

##########################
so_dna1 <- so_dna %>% 
  dplyr::select(-scaled_reads_per_base)
so_dna2 <- pivot_wider(data = so_dna1, names_from = sample, values_from = tpm)
so_dna3 <- so_dna2 %>% 
  dplyr::select(-target_id)

sodna_matriz <- as.matrix(so_dna3)
row.names(sodna_matriz) <- guardar_nombres[,2]
pheatmap(sodna_matriz)





