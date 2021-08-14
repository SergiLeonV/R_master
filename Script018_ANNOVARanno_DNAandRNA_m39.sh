#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=DNA_RNA_anno.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=DNA_RNA_anno.log
#SBATCH --mem=100G
#SBATCH -p short

##### ANOTAMOS LAS SNP E INDEL TANTO EN DNA COMO EN RNA: 

## PRIMERO LO HACEMOS PARA DNA: 

cd /home/sleon.1/Software/annovar/annovar

### PRIMERO GENERAMOS EL AVINPUT PARTIENDO DE NUESTRO VCF FILE. PRIMERO HACEMOS PARA EL ARCHIVO DE SNP L3-L3RR: 
perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.snp.vcf \
-outfile /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_snp_fromvcf.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_snp_fromvcf.avinput mousedb/ -protocol wgEncodeGencodeBasicVM27 -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_snp_fromvcf.annotated -operation g -nastring . -polish



### REPETIMOS EL PROCESO PARA EL ARCHIVO QUE SE HA GENERADO DE INDEL L3-L3RR:
cd /home/sleon.1/Software/annovar/annovar

perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.indel.vcf \
-outfile /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_indel_fromvcf.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_indel_fromvcf.avinput mousedb/ -protocol wgEncodeGencodeBasicVM27 -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_indel_fromvcf.annotated -operation g -nastring . -polish

#####################################################################

## A CONTINUACIÓN LO REPETIMOS PARA RNA: 
cd /home/sleon.1/Software/annovar/annovar

### PRIMERO GENERAMOS EL AVINPUT PARTIENDO DE NUESTRO VCF FILE. PRIMERO HACEMOS PARA EL ARCHIVO DE SNP L3-L3RR (RNA):
perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR.snp.vcf \
-outfile /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR_snp_fromvcf.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR_snp_fromvcf.avinput mousedb/ -protocol wgEncodeGencodeBasicVM27 -buildver mm39 \
-out /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.LacunRR_RNA_snp_fromvcf.annotated -operation g -nastring . -polish



### REPETIMOS EL PROCESO PARA EL ARCHIVO QUE SE HA GENERADO DE INDEL: 
cd /home/sleon.1/Software/annovar/annovar

perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR.indel.vcf \
-outfile /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR_indel_fromvcf.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR_indel_fromvcf.avinput mousedb/ -protocol wgEncodeGencodeBasicVM27 -buildver mm39 \
-out /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR_RNA_indel_fromvcf.annotated -operation g -nastring . -polish









