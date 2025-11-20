// This process processes files from MOTHUR_PCR_SEQS
// Aligns unique sequences to reference

// Files processed:
// stability.trim.contigs.good.unique.fasta
// silva.v4.fasta

// To produce files:
// stability.trim.contigs.good.unique.align 
// stability.trim.contigs.good.unique.align_report 
// stability.trim.contigs.good.unique.

// Screened files produced:
// stability.trim.contigs.good.unique.good.align
// stability.trim.contigs.good.good.count_table


process MOTHUR_ALIGN_SCREEN_SEQS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.v4.fasta)"
    mothur "#summary.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table)"
    mothur "#screen.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table, start=1968, end=11550)"
    mothur "#summary.seqs(fasta=stability.trim.contigs.good.unique.good.align, count=stability.trim.contigs.good.good.count_table)"
    """
}