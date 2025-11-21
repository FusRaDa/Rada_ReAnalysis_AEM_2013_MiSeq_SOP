// This process processes files from MOTHUR_PCR_SEQS
// Aligns unique sequences to reference

// Files processed:
// stability.trim.contigs.good.unique.fasta
// silva.seed.align

// To produce files:
// stability.trim.contigs.good.unique.align 
// stability.trim.contigs.good.unique.align_report 
// stability.trim.contigs.good.unique.

// Screened files produced:
// stability.trim.contigs.good.unique.good.align
// stability.trim.contigs.good.good.count_table


process MOTHUR_ALIGN_SCREEN_SEQS{
    publishDir 'data/mothur/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done
        path input_ref

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#
        align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=${input_ref});
        summary.seqs(fasta=current, count=stability.trim.contigs.good.count_table);
        screen.seqs(fasta=current, count=current, start=1969, end=11551);
        summary.seqs(fasta=current, count=current)
        "
    """
}