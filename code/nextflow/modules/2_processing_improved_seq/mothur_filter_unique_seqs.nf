// This process processes files from MOTHUR_ALIGN_SCREEN_SEQS
// Filter for only the overlapping regions (within v4 within the 16s region?) 

// Files processed:
// stability.trim.contigs.good.unique.good.align
// stability.trim.contigs.good.unique.good.filter.fasta
// stability.trim.contigs.good.good.count_table)

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.fasta
// stability.trim.contigs.good.unique.good.filter.count_table


process MOTHUR_FILTER_UNIQUE_SEQS{
    publishDir 'data/mothur/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#filter.seqs(fasta=stability.trim.contigs.good.unique.good.align, vertical=T, trump=.)"
    mothur "#unique.seqs(fasta=stability.trim.contigs.good.unique.good.filter.fasta, count=stability.trim.contigs.good.good.count_table)"
    """
}