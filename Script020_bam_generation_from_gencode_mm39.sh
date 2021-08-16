#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=gencode_bam.gen
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=genc_bam.log
#SBATCH --mem=200G
#SBATCH -p medium


module load SAMtools/1.12-GCC-10.2.0
module load BWA/0.7.17-foss-2018b


bwa mem /home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome_BWA_idx \
/home/sleon.1/Proj01/TFM/data/BWA_index/GRCm39.genome.fa > /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.sam


### Generamos un sort --> .bam 
samtools sort /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.sam > /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.bam
### Indexamos el .bam
samtools index /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.bam
### Extraemos estadísticas de las reads y flags. 
samtools stats /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.bam > /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39-stats.txt
samtools flagstat /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.bam > /home/sleon.1/Proj01/TFM/data/BWA_index/Gencode_mm39.bam-flagstat.txt
