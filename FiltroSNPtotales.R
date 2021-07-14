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
snp <- readRDS("RESULTS/SNP_DNA/SNPstotales_DNA_L3vsRR.rds")
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

snp_completo <- snp %>% 
  select(c(1,2)) %>% 
  mutate(end=snp$position, value=snp$somatic_p_value)



### GENERO EL TRACK CON LAS MUTACIONES MÁS IMPORTANTES: 
circos.initializeWithIdeogram(species = "mm10",sort.chr=FALSE)
circos.genomicDensity(data = snp_completo, col = "red")
circos.genomicDensity(data = snp_filtrado,col = "green")

######### INTENTO AMPLIFICAR AHORA LA REGIÓN DE INTERÉS : P53 POR EJEMPLO #########
zoom_11 = snp_filter_6[snp_filter_6$chrom == "chr11", ]
zoom_13 = snp_filter_6[snp_filter_6$chrom == "chr13", ]
zoom_df_b = zoom_df_b[order(zoom_df_b[, 2])[1:10], ]
zoom_df = rbind(zoom_df_a, zoom_df_b)

############
                    




############## ZOOM DE UNA ZONA DETERMINADA ############
zoom_13 <- snp2[snp2$chrom == "chr13",]
zoom_10 <- snp2[snp2$chrom == "chr10",]
zoom_13$chrom <- paste0("zoom_",zoom_13$chrom)
zoom_10$chrom <- paste0("zoom_",zoom_10$chrom)
zoomed1013 <- rbind(zoom_10,zoom_13)
datazoomed <- rbind(snp2,zoomed1013)
#
xrange = tapply(datazoomed$start, datazoomed$chrom, function(x) max(x) - min(x))
normal_sector_index = unique(snp2$chrom)
zoomed_sector_index = unique(zoomed1013$chrom)
sector.width = c(xrange[normal_sector_index] / sum(xrange[normal_sector_index]), 
                 xrange[zoomed_sector_index] / sum(xrange[zoomed_sector_index]))
##
circos.par(start.degree = 90, points.overflow.warning = FALSE)
circos.initialize(datazoomed$chrom, x = datazoomed$value, sector.width = sector.width)
circos.track(datazoomed$chrom, x = datazoomed$start, y = datazoomed$end, 
             panel.fun = function(x, y) {
               circos.points(x, y, col = "red", pch = 16, cex = 0.5)
               circos.text(CELL_META$xcenter, CELL_META$cell.ylim[2] + mm_y(2), 
                           CELL_META$sector.index, niceFacing = TRUE)
             })
circos.link("chr13", get.cell.meta.data("cell.xlim", sector.index = "a"),
            "zoom_a", get.cell.meta.data("cell.xlim", sector.index = "zoom_a"),
            border = NA, col = "#00000020")


