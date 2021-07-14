#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=mpil_dna.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=mpileup_trimdna.log
#SBATCH --mem=100G
#SBATCH -p short


### PROCESAMOS LOS .BAM GENERADOS Y ESTUDIAMOS LA CARGA MUTACIONAL: 

#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8
# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b

### Vamos a generar un mpileup que enfrente ya las dos condiciones: 

## TENEMOS QUE IR A LAS CARPETAS QUE SE VAN A GENERAR EN ALINGMENTS Y COGER LOS BAM DE LA CONDICION NORMAL CON LA TUMORAL
## TAMBIÉN PODEMOS ENFRENTAR TODAS CONTRA EL RATÓN ORIGINAL --> ¿LO MÁS INTERESANTE?

#### TODO ESTO ES PARA COMPARAR LAS 6 SECUENCIAS CON LAS LACUN3. 
#cd /home/sleon.1/Proj01/results/alignments/Lacun3
# reference=$(ls *.bam)
# normal_name=$(echo $reference | awk -F 'A' '{print $1}')
# cd ..
# FILES=$(ls -d *-*)
# echo $reference
# echo $normal_name ### SOLO LAS CARPETAS DIFERENTES A LA LACUN3. 

#### VAMOS A GENERAR AHORA UN SCRIPT PARA GENERAR TODOS LOS MPILEUP: 

cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas
FILES=$(ls -d *-bam)

for file in $FILES
do
	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$file
	reference=$(ls *.bam)
	generic=$(echo $file | awk -F '-' '{print $1}')

	#out_name=$(echo $reference | awk -F 'A' '{print $1}')
	#output=$out_name\.$file ### CAMBIAR AQUI LA REFERENCIA Y VER SI SE GENERAN BIEN LAS VARAIBLES. 

	#echo $reference
	#echo $output
#done

samtools mpileup -B -q 1 -f /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa \
		/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$file/$reference > /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$file/$generic.mpileup
done

### EJEMPLO CON SOLO UN ARCHIVO .BAM
# samtools mpileup -B -q 1 -f /home/sleon.1/Proj01/data/STAR_index/GRCm39.genome.fa \
# /home/sleon.1/Proj01/results/alignments/L3-RR-3Aligned.sortedByCoord.out.bam ## BAM.2 > normal.tumor.mpileup

