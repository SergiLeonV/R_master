#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=bwaalign
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=alignbwa.log
#SBATCH --mem=10G
#SBATCH -p short

module load BWA/0.7.17-foss-2018b

### ME CAMBIO A LA CARPETA QUE QUIERA OBTENER LOS FASTQ. 
##### TRIMMED #####
cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired

##### NO TRIMMED #####
#cd /home/sleon.1/Proj01/TFM/Raw_data/DNA

##### GENERAMOS LA VARIABLE CON LOS NOMBRES PARA EL BUCLE.
######## ACTIVAR EL BUCLE QUE GEENRA TODOS LOS .SAM ############
FILES=$(ls *1.fastq)

for file in $FILES
do
file_2=$(echo $file | sed 's/_1/_2/g')
final_name=$(echo $file | awk -F '_' '{print $3}')
echo $file
echo $file_2
echo $final_name
done


bwa mem /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome_BWA_idx \
/home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired/$file /home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired/$file_2 \
> /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$final_name.sam

done 

# bwa mem /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome_BWA_idx \
# /home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired/trimm_paired_Lacun3RR_1.fastq /home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired/trimm_paired_Lacun3RR_2.fastq \
# > /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR.sam
