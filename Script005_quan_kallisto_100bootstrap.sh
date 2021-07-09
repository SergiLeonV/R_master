#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=kallisto.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=quan_kallisto_100.log
#SBATCH --mem=10G
#SBATCH -p short


### ruta para llegar a la carpeta Proj01: /home/sleon.1/Proj01/

cd /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired
module load kallisto

FILES=$(ls *1.fastq)

for file in $FILES
do
  input_2=$(echo $file | sed 's/_1/_2/g')
  output1=$(echo $file | awk -F '_' '{print $1}')
  output2=$(echo $file | awk -F '_' '{print $2}')
  output3=$(echo $file | awk -F '_' '{print $3}')
  final_output=$output1\_$output2\_$output3

#   echo $input_2
#   echo $final_output
# done

  kallisto quant -i //home/sleon.1/Proj01/TFM/data/kallisto_index/mus_musculus/transcriptome.idx -o /home/sleon.1/Proj01/TFM/Raw_data/RNA/RNAseq_kallisto_quantification/$final_output \
   -b 100 /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired/$file /home/sleon.1/Proj01/TFM/Raw_data/RNA/trimmedRNA_L3RR/paired/$input_2

done
