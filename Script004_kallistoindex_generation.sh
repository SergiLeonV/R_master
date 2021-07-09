#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=kalindex
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=index_fasta.log
#SBATCH --mem=10G
#SBATCH -p short

module load kallisto
cd /home/sleon.1/Proj01/TFM/data/kallisto_index

kallisto index -i kallisto_index gencode.vM26.transcripts.fa