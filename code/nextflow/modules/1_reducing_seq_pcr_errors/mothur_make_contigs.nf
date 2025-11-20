// This process processes the stability.files from MOTHUR_MAKE_FILE
// Primarily to produce trimmed contigs and their count

// Files processed:
// stability.files

// Creates 4 new files: 
// stability.trim.contigs.fasta
// stability.scrap.contigs.fasta
// stability.contigs_report
// stability.contigs.count_table


process MOTHUR_MAKE_CONTIGS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/1_reducing_seq_pcr_errors', mode: 'symlink'

    input:
        path input_done
        path input_dir
        
    output:
        path "stability*", emit: stability
   
    script:
    """
    #!/bin/bash
    cp -a ${input_dir}/. .
    mothur "#make.contigs(file=stability.files)"
    """
}