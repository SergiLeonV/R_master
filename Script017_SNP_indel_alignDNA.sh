#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=DNAsnps.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=trimDNA_snps.log
#SBATCH --mem=100G
#SBATCH -p short


#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8

# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b


### ENFRENTAMOS UNICAMENTE EL GENOMA L3 VS. RR --> CALCULO DEL NUMERO DE SNP EN RR EN COMPARACION CON LAS L3. 

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3.mpileup /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR.mpileup \
--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.snp \
--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.inde \
-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1 


# ### CARGAR ESTE PROGARAMA SI QUEREMOS ENFRENTAR L3, RR Y BM CONTRA BALB/C --> MEDIR LA CARGA MUTACIONAL DE L3 Y RR CONTRA EL PROPIO RATÓN. 

# cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/
# ref_folder=$(ls -d BALB*-*)
# cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$ref_folder
# reference=$(ls *.mpileup)
# name_ref=$(echo $reference | awk -F '.' '{print $1}')
# cd ../
# FILES=$(ls -d Lacun3*-bam)

# for folder in $FILES 
# do
# 	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder
# 	file=$(ls *.mpileup)
# 	name_file=$(echo $file | awk -F '.' '{print $1}')
# 	java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$ref_folder/$reference /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$file \
# 	--output-snp /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.snp \
# 	--output-indel /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.indel \
# 	-min-coverage 3 -min-var-freq 0.1 -somatic-p-value 0.1 --output-vcf 1-min-coverage 10 -min-var-freq 0.1 -somatic-p-value 0.05 --output-vcf 1

# done


