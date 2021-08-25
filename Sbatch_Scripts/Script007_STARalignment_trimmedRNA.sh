#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=star_alin.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=alin_trimmed.log
#SBATCH --mem=100G
#SBATCH -p short

### Cargamos el alineador STAR: 
module load STAR/2.7.0d-foss-2018b

### primer paso: generar indice para el alineamiento:
### YA GENERADO EN UN PASO ANTERIOR: /home/sleon.1/Proj01/data/STAR_index --> RUTA PARA LLEGAR A LA REFERENCIA. 


########## SELECCIONAR BIEN EL DIRECTORIO DONDE ESTAN LOS ARCHIVOS TRIMADOS. ##########
cd /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired
# SOLAMENTE VÁLIDO PARA LACUN3. 
#file=$(ls *Lacun3_1*)
## VALIDO PARA TODOS LOS TRIMADOS QUE SON _1: 
FILES=$(ls *1.fastq) #### ACTIVAR BUCLE CUANDO QUERAMOS HACER TODO. 
################################################################

for file in $FILES
do


input_2=$(echo $file | sed 's/_1/_2/g')
out_1=$(echo $file | awk -F '\\_' '{print $1}')
out_2=$(echo $file | awk -F '\\_' '{print $2}')
out_3=$(echo $file | awk -F '\\_' '{print $3}')
name=$out_1$out_2\_$out_3
out_final=$out_1\_$out_2\_$out_3
# echo $file 
# echo $input_2
# echo $out_final
# echo $name
# done

cd /home/sleon.1/Proj01/TFM/Raw_data/RNA/RNA_PE_alineadas
mkdir $name

STAR --genomeDir /home/sleon.1/Proj01/TFM/data/STAR_index \
--readFilesIn  /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired/$file /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired/$input2 \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix /home/sleon.1/Proj01/TFM/Raw_data/RNA/RNA_PE_alineadas/$name/$out_final

done