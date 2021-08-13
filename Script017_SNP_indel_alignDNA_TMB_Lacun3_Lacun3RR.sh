#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=L3_RR_DNA.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=L3_RR_DNA.log
#SBATCH --mem=100G
#SBATCH -p short


#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8

# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b


### ENFRENTAMOS UNICAMENTE EL GENOMA L3 VS. RR --> CALCULO DEL NUMERO DE SNP EN RR EN COMPARACION CON LAS L3. 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3.mpileup /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR.mpileup \
--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.snp \
--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 






