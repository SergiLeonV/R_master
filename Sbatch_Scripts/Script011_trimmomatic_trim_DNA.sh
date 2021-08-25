#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=trimmo_DNAsh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=trimmo_DNA.log
#SBATCH --mem=15G
#SBATCH -p short

### Vamos a trimar con trimmomatic. 
### Usamos los adaptadores que tenemos en la carpeta adaptors: TruSeq2-PE.fa

module load Trimmomatic/0.38-Java-1.8

cd /home/sleon.1/Proj01/TFM/Raw_data/DNA
# L3 Y RR:
FILES=$(ls *1.fastq)

#FILES=$(ls Lacun3_1*)
for file in $FILES
do
	input_2=$(echo $file | sed 's/_1/_2/g')
	output_1=trimm_paired_$file
	output_2=trimm_unpaired_$file
	output_3=trimm_paired_$input_2
	output_4=trimm_unpaired_$input_2

	java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.38.jar PE -phred33 /home/sleon.1/Proj01/TFM/Raw_data/DNA/$file /home/sleon.1/Proj01/TFM/Raw_data/DNA/$input_2 \
	/home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired/$output_1 /home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/unpaired/$output_2 \
	/home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/paired/$output_3 /home/sleon.1/Proj01/TFM/Raw_data/DNA/trimmedDNA_L3RR/unpaired/$output_4 \
	ILLUMINACLIP:/home/sleon.1/Proj01/TFM/Raw_data/adapters/TruSeq3-PE.fa:2:30:10:2:true MINLEN:50

done 

