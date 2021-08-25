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
module load picard/2.18.17-Java-1.8

## ME LOCALIZO EN LA CARPETA DONE TENGO LOS ARCHIOVOS .BAM 

### Seleccionamos el .bam del normal condition. 
# cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/BALBC-bam
# normal_ref=$(ls BA*.sam)

### PRIMERO AJUSTAMOS LOS .BAM PARA QUE TENGA HEADER Y EVITAR EL ERROR QUE NOS SALE. 

## LACUN3_RR
# java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
# I=/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR.bam \
# O=/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR_readgroup.bam \
# RGID=1.1 \
# RGLB=lib-RR \
# RGPL=Illumina \
# RGPU=lane1 \
# RGSM=RR

# ## LACUN3 
# java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
# I=/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3.bam \
# O=/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3_readgroup.bam \
# RGID=1.2 \
# RGLB=lib-L3 \
# RGPL=Illumina \
# RGPU=lane2 \
# RGSM=L3

### GENERAMOS UN SCRIPT VÁLIDO PARA ENFRENTAR L3 VS. RR: 
### SEGUIMOS GOODPRACTICES DE GATK PARA MUTECT2. 

gatk Mutect2 -R /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa \
-I /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR_readgroup.bam \
-tumor Lacun3RR_readgroup \
-I /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3_readgroup.bam \
-O /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR_unfiltered.vcf \

gatk FilterMutectCalls -R /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa \
-V /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR_unfiltered.vcf \
-O /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR_filtered.vcf

### BUCLE NECESARIO CUANDO TENGO QUE ENFRENTAR VARIOS GRUPOS TUMORALES A UNA CONDICIÓN NORMAL 

# cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas
# ### SELECCIONO LAS CARPETAS DE TUMOR-CONDITION:
# #bam_folder=$(ls -d *3*-bam)
# ref_folder=$(ls -d BAL*bam)
# normal_ref=$(ls BA*.sam)

# cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas
# SAM_files=$(ls *3*.sam)
# #echo $SAM_files

# for sam in $SAM_files
# do
# 	sam_name=$(echo $sam | awk -F '.' '{print $1}')
# 	bam_folder=$sam_name-bam
# 	#echo $sam_name
# 	#echo $bam_folder
# #done
# 	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$bam_folder
# 	bam_file=$(ls *.bam)
# 	only_bam=$(echo $bam_file | awk -F '.' '{print $1}')
# # 	echo $sam
# # 	echo $only_bam
# # 	echo $only_bam.vcf
# # 	echo $normal_ref
# # 	echo $bam_folder
# # 	echo $bam_file
# # 	echo $ref_folder
# # done

# 	## REFERENCE:fasta file of the reference. 
# 	## INPUT: BAM files of the input. tumor-normal
# 	## OUTPUT: path directed/name_output. 
# 	## TUMOR: name of tumor sample. 
	
# 	gatk Mutect2\
# 	-R /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa\
# 	-I /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$sam\
# 	-I /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$normal_ref\
# 	-tumor $sam\
# 	-O /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$bam_folder/$only_bam.vcf 

# donedone