// This process processes files from MOTHUR_MAKE_CONTIGS
// Filter contig sequences that are more 275 bp 

// Files processed:
// stability.trim.contigs.fasta
// stability.contigs.count_table

// To produce files:
// stability.trim.contigs.good.fasta
// stability.trim.contigs.bad.accnos
// stability.contigs.good.count_table
// stability.trim.contigs.summary


process MOTHUR_SUMMARY_SCREEN_SEQS{
    publishDir 'data/mothur/1_reducing_seq_pcr_errors', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#
        summary.seqs(fasta=stability.trim.contigs.fasta, count=stability.contigs.count_table);
        screen.seqs(fasta=current, count=current, maxambig=0, maxlength=275, maxhomop=8)
        "
    """
}