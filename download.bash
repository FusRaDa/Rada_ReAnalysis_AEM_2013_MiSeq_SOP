#!/usr/bin/env bash

# BEFORE RUNNING THIS SCRIPT:
# ENSURE TO ADD:
# export PATH=$PATH:/home/mrada/mothur
# TO YOUR .BASHRC OR SIMILAR ENV FILE

# Download the raw data and put them into the data/raw directory
wget --no-check-certificate https://mothur.s3.us-east-2.amazonaws.com/data/MiSeqDevelopmentData/StabilityWMetaG.tar
tar xvf StabilityWMetaG.tar -C data/raw/
rm StabilityWMetaG.tar

# Download the SILVA reference file (v123). We will pull out the bacteria-specific sequences and
# clean up the directories to remove the extra files
wget https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v123.tgz
tar xvzf silva.seed_v123.tgz silva.seed_v123.align silva.seed_v123.tax
mothur "#get.lineage(fasta=silva.seed_v123.align, taxonomy=silva.seed_v123.tax, taxon=Bacteria);degap.seqs(fasta=silva.seed_v123.pick.align, processors=8)"
mv silva.seed_v123.pick.align data/references/silva.seed.align
rm silva.seed_v123.tgz silva.seed_v123.*
rm mothur.*.logfile

# Generate a customized version of the SILVA reference database that targets the V4 region
mothur "#pcr.seqs(fasta=data/references/silva.seed.align, start=11894, end=25319, keepdots=F, processors=8)"
mv data/references/silva.seed.pcr.align data/references/silva.v4.align

# Download the RDP taxonomy references (v14), put the necessary files in data/references, and
# clean up the directories to remove the extra files
wget -N https://mothur.s3.us-east-2.amazonaws.com/wiki/trainset14_032015.pds.tgz
tar xvzf trainset14_032015.pds.tgz
mv trainset14_032015.pds/train* data/references/
rm -rf trainset14_032015.pds
rm trainset14_032015.pds.tgz

# Generate HMP_MOCK.v4.fasta - an unaligned fasta sequence file that contains the V4 region of
# the sequences in the mock community
wget --no-check-certificate https://mothur.s3.us-east-2.amazonaws.com/data/MiSeqDevelopmentData/HMP_MOCK.fasta
mv HMP_MOCK.fasta data/references
mothur "#align.seqs(fasta=data/references/HMP_MOCK.fasta, reference=data/references/silva.v4.align);degap.seqs()"
mv data/references/HMP_MOCK.ng.fasta data/references/HMP_MOCK.v4.fasta