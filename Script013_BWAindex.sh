#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=bwaindex
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=indexbwa.log
#SBATCH --mem=10G
#SBATCH -p short

module load BWA/0.7.17-foss-2018b
cd /home/sleon.1/Proj01/TFM/data/BWA_index

bwa index -p /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome_BWA_idx -a bwtsw /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa