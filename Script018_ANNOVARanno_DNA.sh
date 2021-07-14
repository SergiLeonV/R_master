#!/bin/bash
## Initial SBATCH commands
#SBATCH --job-name=ANNO_DNA.sh
#SBATCH --mail-type=END
#SBATCH --mail-user=sleon.1@alumni.unav.es
#SBATCH --time=23:59:00
#SBATCH --output=anno_DNA_ANNOVAR.log
#SBATCH --mem=100G
#SBATCH -p short



#### DESCOMENTAR PARA GENERAR LAS ANOTACIONES DE VARIOS VCF. 

# cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas

# folders=$(ls -d *3*bam)

# for folder in $folders
# do 
# 	cd /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder
# 	to_convert=$(ls *.tsv)
# 	pre_av=$(echo $to_convert | awk -F '.' '{print $1}')
# 	final_av_output=$pre_av.avinput
# 	final_txt_annot=$pre_av.anno
# # 	echo $folder
# # 	echo $to_convert
# # 	echo $pre_av
# # 	echo $final_av_output
# # 	echo $final_txt_annot
# # done

# 	cd /home/sleon.1/Software/annovar/annovar
# 	### PRIMERO GENERAMOS EL AVINPUT PARTIENDO DE NUESTRO VCF FILE. 
# 	perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$to_convert\
# 	-outfile /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$final_av_output -withfreq -includeinfo

# 	### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
# 	cd /home/sleon.1/Software/annovar/annovar
# 	perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$final_av_output mousedb/ -buildver mm10\
# 	-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/$folder/$final_txt_annot -remove -protocol refGene\
# 	-operation g -nastring . -polish

# done

### PARA HACERLO PARA UN ÚNICO ARCHIVO: 

cd /home/sleon.1/Software/annovar/annovar
### PRIMERO GENERAMOS EL AVINPUT PARTIENDO DE NUESTRO VCF FILE. 
perl convert2annovar.pl -format vcf4 /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/vcf_SNP_DNA_L3vsRR.tsv \
-outfile /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/vcf_SNP_DNA_L3vsRR.avinput -withfreq -includeinfo

### A CONTINUACIÓN GENERAMOS EL ARCHIVO ANOTADO Y LO GUARDAMOS EN LA CARPETA DE INTERES.
perl table_annovar.pl /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/vcf_SNP_DNA_L3vsRR.avinput mousedb/ -buildver mm10 \
-out /home/sleon.1/Proj01/TFM/Raw_data/DNA/DNA_PE_alineadas/Lacun3RR-bam/vcf_SNP_DNA_L3vsRR.anno -remove -protocol refGene\
-operation g -nastring . -polish


