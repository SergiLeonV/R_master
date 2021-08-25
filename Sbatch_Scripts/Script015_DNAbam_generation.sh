#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=bam.gen
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=bamDNA.log
#SBATCH --mem=10G
#SBATCH -p medium


module load SAMtools/1.12-GCC-10.2.0


cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas

FILES=$(ls *.sam)


for file in $FILES
do
	generic_name=$(echo $file | awk -F '.' '{print $1}')
	folder_name=$generic_name-bam
		
	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas
	mkdir /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name

	### Generamos un sort --> .bam 
	samtools sort /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$file > /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name/$generic_name.bam 
	### Indexamos el .bam
	samtools index /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name/$generic_name.bam
	### Extraemos estadísticas de las reads y flags. 
	samtools stats /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name/$generic_name.bam > /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name/$generic_name-stats.txt
	samtools flagstat /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name/$generic_name.bam > /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder_name/$generic_name-flagstat.txt
done
