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
sleuth_table <- readRDS("RNA_quant/L3RRquantification_genemode.rds")
so <- readRDS("RNA_quant/so_RRL3_genemode.rds")
gsea_L3RR_allGO <- readRDS(file = "RNA_quant/gsea_L3RR_allGO.rds")
res_gse <- readRDS("RNA_quant/resultados_categorias_L3RR.rds")
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

#### UNA VEZ QUE GENERAMOS LA TABLA DE MANERA CORRECTA YA PASAMOS A HACER TODO EL ANALISIS GSEA: 

gene_list = sleuth_table$b
names(gene_list) = sleuth_table$entrez
gene_list = sort(gene_list, decreasing = TRUE)

organismo <- org.Mm.eg.db

### AHORA YA COMENZAMSO EL ANÁLISIS DE GSEA: 
#gse <- gseGO(geneList = gene_list,
#              ont = "ALL",
#              OrgDb = organismo,
#              pvalueCutoff = 0.01,
#              pAdjustMethod = "BH",
#              by = "fgsea")

#saveRDS(gse,"gsea_L3RR_allGO.rds")
gsea_L3RR_allGO <- readRDS(file = "RNA_quant/gsea_L3RR_allGO.rds")
#res_gse <- gsea_L3RR_allGO@result
#saveRDS(res_gse, "/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/resultados_categorias_L3RR.rds")
#write.xlsx(x = res_gse,file = "GOcategories_L3RR.xlsx")
gse2 <- setReadable(gsea_L3RR_allGO,organismo,keyType = "ENTREZID")

### DIFERENTES REPRESENTACIONES. 
dotplot(gsea_L3RR_allGO,x='Count' ,color="p.adjust", showCategory=30)
# emapplot(gse2,layout = "nicely", showCategory = 30, color = "p.adjust")
# cnetplot(gse2,foldChange = gene_list, node_label = "category", showCategory = 10)
# ridgeplot(gsea_L3RR_allGO)

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
