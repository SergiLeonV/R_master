#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=Mutect2.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=Mutect2SNPs_DNA.log
#SBATCH --mem=100G
#SBATCH -p short

module load GATK/4.0.8.1-foss-2018b-Python-2.7.15

## ME LOCALIZO EN LA CARPETA DONE TENGO LOS ARCHIOVOS .BAM 

### Seleccionamos el .bam del normal condition. 
cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam
normal_ref=$(ls *.bam)

cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas
### SELECCIONO LAS CARPETAS DE TUMOR-CONDITION:
bam_folder=$(ls -d *3*-bam)
ref_folder=$(ls -d BAL*bam)

for folder in $bam_folder
do
	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder
	bam_file=$(ls *.bam)
	only_bam=$(echo $bam_file | awk -F '.' '{print $1}')
# 	echo $only_bam
# 	echo $only_bam.vcf
# 	echo $normal_ref
# 	echo $folder
# 	echo $bam_file
# 	echo $ref_folder
# done

	## REFERENCE:fasta file of the reference. 
	## INPUT: BAM files of the input. tumor-normal
	## OUTPUT: path directed/name_output. 
	## TUMOR: name of tumor sample. 
	
	gatk Mutect2\
	####GENERAR EL .DICT PARA LA REFERENCIA. 
	-R /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa\
	-I /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$bam_file\
	-I /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$ref_folder/$normal_ref\
	-tumor $bam_file\
	-O /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$only_bam.vcf 

done