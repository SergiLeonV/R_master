#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=mpil_genc.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=mpileup_genc.log
#SBATCH --mem=100G
#SBATCH -p short


### PROCESAMOS LOS .BAM GENERADOS Y ESTUDIAMOS LA CARGA MUTACIONAL: 

#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8
# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b

samtools mpileup -B -q 1 -f /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.bam > /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.mpileup
