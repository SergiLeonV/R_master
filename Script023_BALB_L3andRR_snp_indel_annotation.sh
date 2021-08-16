#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=BALB_l3_rr.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=BALB_l3_rr.log
#SBATCH --mem=100G
#SBATCH -p short


#Cargamos el modulo de VarScan para estudiar mutaciones: 
module load VarScan/2.4.2-Java-1.8

# Cargamos también samtools, una herramienta que usamos en el procedimiento: 
module load SAMtools/1.9-foss-2018b

#### PRIMREO LO HACEMOS PARA BALB_L3RR:
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/BALBC.Lacun3RR.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/BALBC.Lacun3RR.indel.vcf

#### A CONTINUACION LO EJECUTAMOS PARA BALB-L3:
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/BALBC.Lacun3.snp.vcf
java -jar /home/sleon.1/Software/varscan/VarScan.v2.3.9.jar processSomatic /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3-bam/BALBC.Lacun3.indel.vcf