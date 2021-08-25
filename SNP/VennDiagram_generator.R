library("VennDiagram")
library("futile.logger")
library("tidyverse")

setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/")

dna_snp <- readRDS("SNP_DNA/SNPanotados_DNA_L3vsRR.rds")
rna_snp <- readRDS("SNP_RNA/snp_anotados_RNA_L3vsRR.rds")

venn.diagram(
  x=list(
    dna_snp$Start,
    rna_snp$Start),
  category.names = c("SNPs_DNA", "SNPs_RNA"),
  filename = "../RESULTS/DNA_RNA_snpvenn.png",
  output = TRUE,
  resolution=300,
  compression="lzw",
  lwd=5,
  col=c("#440154ff","#21908dff"),
  fill=c(alpha("#440154ff",0.3),alpha("#21908dff",0.3)),
  cex=2.5,
  cat.cex=2,
  cat.pos=c(0,0),
  cat.col=c("#440154ff","#21908dff"),
  fontfamily="sans",
  cat.fontfamily="sans"
)
