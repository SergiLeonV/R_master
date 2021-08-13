#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=ANNO_DNA.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=anno_DNA_ANNOVAR.log
#SBATCH --mem=100G
#SBATCH -p short

cd /home/sleon.1/Software/annovar/annovar

### PRIMERO GENERAMOS EL AVINPUT PARTIENDO DE NUESTRO VCF FILE. PRIMERO HACEMOS PARA EL ARCHIVO DE SNP L3-L3RR: 
perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.snp.vcf \
-outfile /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_snp_fromvcf.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_snp_fromvcf.avinput mousedb/ -protocol wgEncodeGencodeBasicVM27 -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/prueba_snp_fromvcf.annotated -operation g -nastring . -polish



### REPETIMOS EL PROCESO PARA EL ARCHIVO QUE SE HA GENERADO DE INDEL: 
cd /home/sleon.1/Software/annovar/annovar

perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.indel.vcf \
-outfile /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_indel_fromvcf.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_indel_fromvcf.avinput mousedb/ -protocol wgEncodeGencodeBasicVM27 -buildver mm39 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR_indel_fromvcf.annotated -operation g -nastring . -polish


