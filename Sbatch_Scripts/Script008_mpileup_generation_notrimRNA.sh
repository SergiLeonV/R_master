#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=mpile_notrim.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=mpileup_RNA_notrim.log
#SBATCH --mem=100G
#SBATCH -p short


### PROCESAMOS LOS .BAM GENERADOS Y ESTUDIAMOS LA CARGA MUTACIONAL: 

#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8
# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b

### Vamos a generar un mpileup que enfrente ya las dos condiciones: 

#### VAMOS A GENERAR AHORA UN SCRIPT PARA GENERAR TODOS LOS MPILEUP: 

cd /home/sleon.1/Proj01/results/alignments/
FILES=$(ls -d L3*)

for file in $FILES
do
	cd /home/sleon.1/Proj01/results/alignments/$file
	reference=$(ls *.bam)
	#out_name=$(echo $reference | awk -F 'A' '{print $1}')
	#output=$out_name\.$file ### CAMBIAR AQUI LA REFERENCIA Y VER SI SE GENERAN BIEN LAS VARAIBLES. 

	#echo $reference
	#echo $output
#done

samtools mpileup -B -q 1 -f /home/sleon.1/Proj01/TFM/data/STAR_index/GRCm39.genome.fa \
		/home/sleon.1/Proj01/results/alignments/$file > $file.mpileup
done

### EJEMPLO CON SOLO UN ARCHIVO .BAM
# samtools mpileup -B -q 1 -f /home/sleon.1/Proj01/data/STAR_index/GRCm39.genome.fa \
# /home/sleon.1/Proj01/results/alignments/L3-RR-3Aligned.sortedByCoord.out.bam ## BAM.2 > normal.tumor.mpileup
