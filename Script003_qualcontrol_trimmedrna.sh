#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=qctrimed.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=qual_trimmed.log
#SBATCH --mem=100G
#SBATCH -p short

#module load VarScan/2.4.2-Java-1.8
## Para cargar el alineador STAR (RNA): 
#module load STAR/2.7.0d-foss-2018b
## Para cargar fastqc: 
module load FastQC/0.11.8-Java-1.8

### Buscmaos todos los archivos que queremos realizar el quality control. 
### Direccion del directorio: Proj01: /home/sleon.1/Proj01/

#### PRIMERO BUSCAMOS EN LA CARPETA DE PAIRED Y LUEGO REPETIMOS PARA UNPAIRED --> INTENTAMOS DOS BUCLES FOR: 
cd /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired
FILES=$(ls *.fastq)

#FILES=$(ls *.fastq) #(PARA TODOS LOS .FASTQ)
## SOLO VAMOS A EJECUTAR PARA LAS LACUN3 QUE HE HECHO MÁS TARDE: 
#parejas=$(ls)
#FILES=$(ls *.fastq)
#cd /home/sleon.1/Proj01/results/FastQC_analysis/trimmom
# for par in $parejas
# do
# 	cd /home/sleon.1/Proj01/results/trimmomatic/$par
# 	FILES=$(ls *.fastq)

for file in $FILES
do	
	#cd /home/sleon.1/Proj01/results/FastQC_analysis/
	#quality=$(echo $file | sed 's/\./_/g')c.zip
	fastqc -o /home/sleon.1/Proj01/TFM/Raw_data/RNA/RNA_FASTQC_analysis/trimmed /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired/$file

	#unzip $quality
	#rm -r $quality
	#echo $par
	#echo $file
	#echo $quality
done