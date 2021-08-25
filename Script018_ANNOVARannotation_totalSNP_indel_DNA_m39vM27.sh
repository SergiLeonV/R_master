#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=DNA_RNA_TOTAL_anno.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=DNA_RNA_TOTAL_anno.log
#SBATCH --mem=100G
#SBATCH -p short

##### ANOTAMOS LAS SNP E INDEL TANTO EN DNA COMO EN RNA: 

## PRIMERO LO HACEMOS PARA DNA: 

cd /home/sleon.1/Software/annovar/annovar

### ANOTAMOS SNP E INDEL PARA BALB-L3RR:
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/BALBC.Lacun3RR.snp.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Somatic_SNP_DNA_BALBC.Lacun3RR.annotated -remove -protocol wgEncodeGencodeBasicVM27 \
-operation g -nastring . -vcfinput -polish

perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/BALBC.Lacun3RR.indel.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Somatic_INDEL_DNA_BALBC.Lacun3RR.annotated -remove -protocol wgEncodeGencodeBasicVM27 \
-operation g -nastring . -vcfinput -polish

#####################################################################

### REPETIMOS EL PROCESO PARA BALB-L3:
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/BALBC.Lacun3.snp.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Somatic_SNP_DNA_BALBC.Lacun3.annotated -remove -protocol wgEncodeGencodeBasicVM27 \
-operation g -nastring . -vcfinput -polish

perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/BALBC.Lacun3.indel.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Somatic_INDEL_DNA_BALBC.Lacun3.annotated -remove -protocol wgEncodeGencodeBasicVM27 \
-operation g -nastring . -vcfinput -polish

