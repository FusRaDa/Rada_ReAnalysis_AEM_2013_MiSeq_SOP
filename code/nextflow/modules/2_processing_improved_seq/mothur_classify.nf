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
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done
        path train_ref

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    cp -a ${train_ref}/. .
    mothur "#classify.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table, reference=trainset9_032012.pds.fasta, taxonomy=trainset9_032012.pds.tax)"
    """
}