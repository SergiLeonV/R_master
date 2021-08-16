#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=GENC_mut.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=SNP_indel_gencode.log
#SBATCH --mem=100G
#SBATCH -p short


#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8

# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b


### USAMOS COMO REFERNCIA EL GENCODE Y LO VAMOS A ENFRENTAR A LACUN3 RR (DNA Y RNA): 
### PARA DNA: 
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.mpileup /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR.mpileup \
--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Gencode39.Lacun3RR.snp \
--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Gencode39.Lacun3RR.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Gencode39.Lacun3RR.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Gencode39.Lacun3RR.indel.vcf

### PARA RNA: 
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.mpileup /home/sleon.1/Proj01/results/alignments/L3-RR-1/L3-RR-1.mpileup \
--output-snp /home/sleon.1/Proj01/results/alignments/L3-RR-1/Gencode39.L3RR.snp \
--output-indel /home/sleon.1/Proj01/results/alignments/L3-RR-1/Gencode39.L3RR.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/results/alignments/L3-RR-1/Gencode39.L3RR.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/results/alignments/L3-RR-1/Gencode39.L3RR.indel.vcf


### USAMOS COMO REFERNCIA EL GENCODE Y LO VAMOS A ENFRENTAR A LACUN3 (DNA Y RNA): 
### PARA DNA: 
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.mpileup /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3.mpileup \
--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Gencode39.Lacun3.snp \
--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Gencode39.Lacun3.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Gencode39.Lacun3.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Gencode39.Lacun3.indel.vcf

### PARA RNA: 
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.mpileup /home/sleon.1/Proj01/results/alignments/L3-1/L3-1.mpileup \
--output-snp /home/sleon.1/Proj01/results/alignments/L3-1/Gencode39.L3.snp \
--output-indel /home/sleon.1/Proj01/results/alignments/L3-1/Gencode39.L3.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/results/alignments/L3-1/Gencode39.L3.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/results/alignments/L3-1/Gencode39.L3.indel.vcf


### USAMOS COMO REFERNCIA EL GENCODE Y LO VAMOS A ENFRENTAR A BALB/C (DNA Y RNA): 
### PARA DNA: 
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.mpileup /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam/BALBC.mpileup \
--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam/Gencode39.BALBC.snp \
--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam/Gencode39.BALBC.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam/Gencode39.BALBC.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam/Gencode39.BALBC.indel.vcf






