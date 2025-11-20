// This process processes files from MOTHUR_UNIQUE_SEQS
// Align unique sequences to reference alignments silva.bacteria.fasta file - in the future run pipeline with multiple ref alignments!
// Rename silva.bacteria.pcr.fasta to silva.v4.fasta
// Summarize the alignments

// Files processed:
// silva.bacteria.fasta

// To produce files:
// silva.v4.fasta
// silva.v4.fasta.summary


process MOTHUR_PCR_SEQS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done
        path ref_file

    output:
        path "silva*", emit: silva

    script:
    """
    #!/bin/bash
    mothur "#pcr.seqs(fasta=${ref_file}, start=11895, end=25318, keepdots=F)"
    mothur "#rename.file(input=silva.bacteria.pcr.fasta, new=silva.v4.fasta)"
    mothur "#summary.seqs(fasta=silva.v4.fasta)"
    """
}