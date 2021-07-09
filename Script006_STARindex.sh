#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=star_index.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=STAR_index.log
#SBATCH --mem=80G
#SBATCH -p short


### Cargamos el alineador STAR: 
module load STAR/2.7.0d-foss-2018b

### primer paso: generar indice para el alineamiento: 
### Para que funcione el progarama nos situamos en la carpeta donde tenemos las anotaciones y el genoma de referencia: 
cd /home/sleon.1/Proj01/TFM/data/STAR_index

STAR --runThreadN 1 \
--runMode genomeGenerate \
--genomeDir ./ \
--genomeFastaFiles ./GRCm39.genome.fa \
--sjdbGTFfile ./gencode.vM26.chr_patch_hapl_scaff.annotation.gtf \
--sjdbOverhang 149

# --runMode: generación del genoma de referencia.
# --genomeDir: Dirección donde vamos a generar la referencia. La misma donde tenemos el .fa y las anotaciones. 





