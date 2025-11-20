# This protocal is taken from https://github.com/riffomonas/minimalR/blob/gh-pages/07_line_plots.md
library(tidyverse)


# file path of rarefaction file for OTU analysis
rarefaction_path <- "results/5_analysis/otu/final.opti_mcc.groups.rarefaction"
metadata_path <- "data/MiSeq_SOP/mouse.time.design"


# store dataset into variable
rarefy <- read_tsv(file=rarefaction_path) %>%
  select(-contains("lci-"), -contains("hci-")) %>%
  pivot_longer(cols=c(-numsampled), names_to='sample', values_to='sobs') %>%
  mutate(sample=str_replace_all(sample, pattern="0.03-", replacement="")) %>%
  drop_na()


# get metadata
metadata <- read_tsv(file=metadata_path)


# join both rarefaction and metadata
metadata_rarefy <- inner_join(metadata, rarefy, by=c("group"="sample"))


# plot rarecurve
ggplot(metadata_rarefy, aes(x=numsampled, y=sobs, group=group, color=time)) +
  geom_line() + 
  labs(title="Mice Microbiome: Early vs. Late Post-weaning",
    x="Number of Sequences Sampled per Subject",
    y="Number of OTUs per Subject") 
