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


### ENFRENTAMOS UNICAMENTE EL GENOMA L3 VS. RR. 
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar somatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/Lacun3.mpileup /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3RR.mpileup \
/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR -min-coverage 10 -min-var-freq 0.02 -somatic-p-value 0.05

java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.snp
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/Lacun3.Lacun3RR.indel






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
# 	/home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file -min-coverage 10 -min-var-freq 0.02 -somatic-p-value 0.05

# 	java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.snp
# 	java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$name_ref.$name_file.indel

# done


