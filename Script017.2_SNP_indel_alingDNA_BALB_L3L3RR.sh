#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=BALB_l3_rr.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=BALB_l3_rr.log
#SBATCH --mem=100G
#SBATCH -p short


#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8

# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b


cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/
ref_folder=$(ls -d BALB*-*)
cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$ref_folder
reference=$(ls *.mpileup)
name_ref=$(echo $reference | awk -F '.' '{print $1}')
cd ../
FILES=$(ls -d Lacun3*-bam)

for folder in $FILES 
do
	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder
	file=$(ls *.mpileup)
	name_file=$(echo $file | awk -F '.' '{print $1}')
	# echo $file
	# echo $name_file
	# echo $name_ref
	# echo $reference
	# echo $folder
	
	java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$ref_folder/$reference /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$file \
	--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.snp \
	--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.indel \
	-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1-min-coverage 10 -min-var-freq 0.1 -somatic-p-value 0.05 --output-vcf 1

	### GENERAMOS TODOS LOS ARCHIVOS PARA SELECCIONAR UNICAMENTE AQUELLOS SOMATICOS: 

	java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.snp.vcf
	java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.indel.vcf

donecf

done