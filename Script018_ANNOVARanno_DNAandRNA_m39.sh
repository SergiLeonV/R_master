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

### ANOAMOS SNP E INDEL PARA DNA: 
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.snp.Somatic.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Somatic_SNP_DNA_Lacun3.Lacun3RR.annotated -remove -protocol wgEncodeGencodeBasicVM26 \
-operation g -nastring . -vcfinput -polish

perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.indel.Somatic.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Somatic_INDEL_DNA_Lacun3.Lacun3RR.annotated -remove -protocol wgEncodeGencodeBasicVM26 \
-operation g -nastring . -vcfinput -polish

#####################################################################

### REPETIMOS EL PROCESO PARA EL RNA: 
perl table_annovar.pl /home/sleon.1/Proj01/results/alignments/L3-RR-1/RNA_Lacun3.Lacun3RR.snp.Somatic.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/results/alignments/L3-RR-1/Somatic_SNP_RNA_Lacun3.Lacun3RR.annotated -remove -protocol wgEncodeGencodeBasicVM26 \
-operation g -nastring . -vcfinput -polish

perl table_annovar.pl /home/sleon.1/Proj01/results/alignments/L3-RR-1/RNA_Lacun3.Lacun3RR.indel.Somatic.vcf mousedb/ -buildver mm39 \
-out /home/sleon.1/Proj01/results/alignments/L3-RR-1/Somatic_INDEL_RNA_Lacun3.Lacun3RR.annotated -remove -protocol wgEncodeGencodeBasicVM26 \
-operation g -nastring . -vcfinput -polish


