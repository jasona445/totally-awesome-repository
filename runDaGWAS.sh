#! /usr/bin/bash

#make loop over all phenotypes, probably just need to make a list of all their names and loop over that
name="MFI_CD16_in_CD16hi_of_NKnew.panel4"
./plink --bfile ./Data/pasteur/homes/epatin/LabExMI_imputation_816x5699237 --linear sex --pheno ./Data/phenotypes_normalized.txt --pheno-name ${name} --out ./Data/GWAS_Results/${name}