getLoci <- function(summStats){

  fname <- './discovery_metav3.0.meta'
  df <- read.csv(file=fname, header=TRUE, sep=' ')
  
  # dump stuff with missing p's
  good_df <- df[!is.na(df$P),]
  snp_df <- good_df[good_df$P < 1e-5,]

  reg = 1
  small_snp_df$REGION = integer(nrow(small_snp_df))
  cut_df <- small_snp_df
  
  lead_snps <- c()
  while(nrow(cut_df) != 0)
  {
    lead_snp <- cut_df[which.min(cut_df$P),]
    range <- c(lead_snp$BP-1e3, lead_snp$BP+1e3)
    loci <- cut_df[cut_df$BP > range[1] & cut_df$BP < range[2] & cut_df$CHR == as.numeric(lead_snp['CHR']),]
    small_snp_df$REGION[(rownames(small_snp_df) %in% rownames(loci))] <- reg
    lead_snps <- c(lead_snps, lead_snp)
    cut_df <- cut_df[cut_df$BP <= range[1] | cut_df$BP >= range[2],]
    reg <- reg + 1
  }
  
  res <- list(lead_snps, small_snp_df)
  return(res)
}

