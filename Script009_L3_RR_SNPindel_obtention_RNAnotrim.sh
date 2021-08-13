#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=rnasomatic.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=rnasomatic.log
#SBATCH --mem=100G
#SBATCH -p short


#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8

# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b

### INTRODUCIR TODA LA RUTA NUEVA 
### TENGO QUE CAMBIAR Y HACERLO PARA LA RUTA DONDE TENGO LOS RSULTADOS ACTUALES. INTENTAR MODIFICAR PARA QUE SEA CON LOS .BAM DE LOS ARCHIVOS TRIMADOS. 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/results/alignments/L3-1/L3-1.mpileup /home/sleon.1/Proj01/results/alignments/L3-RR-1/L3-RR-1.mpileup \
--output-snp /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR.snp \
--output-indel /home/sleon.1/Proj01/results/alignments/L3-RR-1/Lacun3.Lacun3RR.indel \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1
