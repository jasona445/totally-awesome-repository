source("./getLoci.R")

pheno_eQTL_comparison <- function(eQTLs, phenotypes)
{
  #get the phenotype data 
  #for each phenotype, get the associated loci for the phenotype
  getLoci(summary_phenotype)
  #run jlim on the eqtls and phenotypes that share loci 
  
  
}