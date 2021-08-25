####### VAMOS A TRABAJAR CON LOS SNPS OBTENIDOS EN EL DNA #######

library(tidyverse)

setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/DATA/")


# snp <- read_delim("SNP_data_DNA/Lacun3.Lacun3RR.snp.Somatic.hc", 
#                   "\t", escape_double = FALSE, trim_ws = TRUE)
#saveRDS(snp,"../RESULTS/SNP_DNA/SNPstotales_DNA_L3vsRR.rds")



#### PONEMOS EL NOMBRE DEL ARCHIVO QUE QUEREMOS GENERAR LOS VCF. <-- VARSCAN 
snp <- readRDS("../RESULTS/SNP_DNA/SNPstotales_DNA_L3vsRR.rds")
# total_SNPs <- dim(SNPRR)[1]
# 
# SNPRR <- SNPRR[1:total_SNPs,]

bucle <- dim(snp)[1]
df_vacio_1 <- vector(length = bucle)
df_vacio_normal <- vector(length = bucle)
df_vacio_tumor <- vector(length = bucle)
dp_total <- vector(length = bucle)

for(i in seq_along(1:bucle)){
  kk <- "SOMATIC"
  df_vacio_1[i] <- kk
}

for (j in seq_along(1:bucle)){
  kk2 <- paste("0|1",sum(snp$normal_reads1[j]+snp$normal_reads2[j]),sep = ":")
  df_vacio_normal[j] <- kk2
}
for (k in seq_along(1:bucle)){
  kk3 <- paste("0|1",sum(snp$tumor_reads1[k]+snp$tumor_reads2[k]),sep = ":")
  df_vacio_tumor[k] <- kk3
}
for(tot in seq_along(1:bucle)){
  kk_total <- paste("DP",sum(snp$normal_reads1[tot]+snp$normal_reads2[tot]+snp$tumor_reads1[tot]+snp$tumor_reads2[tot]),sep = "=")
  dp_total[tot] <- kk_total
}


vcf_file <- snp %>% 
  select(c(1,2)) %>%
  mutate(ID=".") %>%
  mutate(REF=snp$ref, ALT=snp$var) %>% 
  mutate(QUAL=".", FILTER="PASS") %>% 
  mutate(INFO=paste(dp_total,df_vacio_1,sep=";")) %>% 
  mutate(FORMAT="GT:DP") %>% 
  mutate(LACUN3=df_vacio_normal) %>% 
  mutate(RR=df_vacio_tumor)
names(vcf_file)[1:2] <- c("#CHROM","POS")
### GUARDAMOS EL ARCHIVO GENERADO: 

### PONEMOS LA RUTA DONDE QUEREMOS GUARDAR LOS SNP Y EL NOMBRE DEL ARCHIVO. 
#write_tsv(vcf_file,"VCF_files/vcf_SNP_DNA_L3vsRR.tsv")


