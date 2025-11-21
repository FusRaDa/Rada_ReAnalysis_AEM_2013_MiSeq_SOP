// This process processes files from MOTHER_PRE_CLUSTER
// Classify sequences using Bayesian classifier and produce a taxonomy file

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table
// trainset9_032012.pds.fasta
// trainset9_032012.pds.tax

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.taxonomy
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.tax.summary


process MOTHUR_CLASSIFY{
    publishDir 'data/mothur/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done
        path input_train_fasta
        path input_train_tax

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#classify.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table, reference=${input_train_fasta}, taxonomy=${input_train_tax})"
    """
}