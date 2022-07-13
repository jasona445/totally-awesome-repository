source("./getLoci.R")

pheno_eQTL_comparison <- function(eQTLs, phenotypes)
{
  #get the phenotype data 
  #for each phenotype, get the associated loci for the phenotype
  for(i in 1:nrows(phenotypes))
  {
    #here we are getting the associated loci for a given phenotype
    #using the function we created for the first part
    phenotype_loci <- getLoci(phenotypes[i,])
    #one of the objects that the function returns is the list of lead SNPs
    #we want to run JLIM on pairs of phenotypes and eQTLs that are associated with the same locus 
    #so for each eQTL, if the SNP is within a 1mBP window of a significant SNP for the phenotype
    #we will add it to the file of eQTLs to compare with the phenotype/trait.
    eQTLs_to_test <- c()
    for(j in 1:nrows(eQTLs))
    {
      #this should return a vector or list of the absolute differences between the eQTL's SNP BP and the BPs of phenotypes significant SNPs
      diffs <- abs(eQTLs$BP[j,] - phenotype_loci[1])
      #if any of them are within the window then add the eQTL to the list 
      if(min(diffs) < 1e6)
      {
        eQTLs_to_test = c(eQTLs_to_test, eQTLs[j,])
      }
      #run JLIM on the eQTLs and the phenotype 
      #probably to some output file
      JLIM(eQTLs_to_test, phenotype[i,])
    }
  }
}

args <- commandArgs(trailingOnly = TRUE)
 
raw_p_df <- read.csv(file=args[1], header=TRUE, sep=' ')
p_df <- dirty_df[!is.na(raw_df$P),]
phenotype_loci <- getLoci(p_df)
lead_snps <- phenotype_loci[1]
write.csv(lead_snps, file=args[2], row.names = TRUE)

#using jason's eQTL analysis 
#eQTL_df <- read.csv(file=args[2], header=TRUE, sep=' ')
#cut_df$CHR == as.numeric(lead_snp['CHR'])


