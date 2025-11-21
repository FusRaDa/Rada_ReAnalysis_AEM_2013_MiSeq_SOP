// This process processes files from MOTHUR_FILTER_UNIQUE_SEQS
// Pre-cluster sequences to reduce seqencing errors

// Files processed:
// stability.trim.contigs.good.unique.good.filter.count_table
// stability.trim.contigs.good.unique.good.filter.unique.fasta

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.[ID].map


process MOTHER_PRE_CLUSTER{
    publishDir 'data/mothur/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)"
    """
}