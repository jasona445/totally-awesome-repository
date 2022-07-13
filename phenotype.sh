mkdir lead_phenotype_snps

for FILE in ./Data/*; do 
  name="${FILE%.*}"
  file_output="${name}.txt"
  Rscript phenotype-eQTL.R $FILE ./lead_phenotype_snps/${file_output};
done

mkdir JLIM_output_files

for FILE in ./lead_phenotype_snps/*; do
  name="${FILE%.*}"
  awk '{run_jlim.sh --maintr-file ./Data/${name}.gz\
--sectr-file your_download_path/GTEx_Analysis_v8_QTLs_GTEx_Analysis_v8_EUR_eQTL_all_associations_Cells_EBV-transformed_lymphocytes.v8.EUR.allpairs.chr1.parquet \
--ref-ld refld.1kg.nfe.b38/ \
--index-snp $2:$3 \
--output-file JLIM_output_files/${name}.out \
--sectr-ref-db GTEx.v8.EUR}' $FILE;
done 

