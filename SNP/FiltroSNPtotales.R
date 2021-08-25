#### SCRIPT PARA FILTRAR LAS SNP TOTALES DEL ARCHIVO QUE CARGUEMOS.

setwd("/Users/sergioleon/Desktop/TFM/R_MASTER/")

library(readr)
library(circlize)
library(tidyverse)

# snp <- read_delim("DATA/L3.L3-RR-1.snp.Somatic.hc", 
#                                      "\t", escape_double = FALSE, trim_ws = TRUE)
# saveRDS(snp,"/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/snp.rds")
# indel <- read_delim("~/Desktop/L3.L3-RR-1.indel.Somatic.hc", 
#                     "\t", escape_double = FALSE, trim_ws = TRUE)
# saveRDS(indel,"/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/indel.rds")

#indel <- readRDS("/Users/sergioleon/Desktop/TFM/R_MASTER/RESULTS/indel.rds")



##### SELECCIONAMOS LA LISTA DE SNPS QUE VAMOS A QUERER FILTRAR:
snp <- readRDS("RESULTS/SNP_RNA/SNP_RNA_RRvsLACUN3.rds")
#snp <- snp[1:1031,]

#### FILTRO 1: 
snp_filter_1 <- snp %>% 
  filter(snp$somatic_p_value < 0.01)
### FILTRO 2: 
snp_filter_2 <- snp_filter_1 %>% 
  filter(snp_filter_1$tumor_reads2>5)
### FILTRO 3: 
snp_filter_3 <- snp_filter_2 %>% 
  filter(snp_filter_2$normal_reads1 > 5)
###FILTRO 4: 
snp_filter_4 <- snp_filter_3 %>% 
  filter(snp_filter_3$normal_reads2 < 2)
### FILTRO 5: 
snp_filter_5 <- snp_filter_4 %>% 
  filter(snp_filter_4$tumor_reads1 > 5)

snp_filter_5$tumor_var_freq2 <- gsub("%","",snp_filter_5$tumor_var_freq)
snp_filter_5$tumor_var_freq2 <- as.numeric(gsub(",",".",snp_filter_5$tumor_var_freq2))

#### GENERO EL OBJETO QUE TENGO QUE METER PARA EL TRACK: 
snp_filtrado <- snp_filter_5 %>% 
  select(c(1,2)) %>% 
  mutate(end=snp_filter_5$position, value=snp_filter_5$somatic_p_value)
#### GUARDO EL OBJETO FILTRADO: 
#saveRDS(snp_filtrado,"SNP_DNA/SNP_DNA_L3vsRR_noanotados_filtrados.rds")
