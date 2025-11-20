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
    publishDir 'data/mothur/1_reducing_seq_pcr_errors', mode: 'symlink'

    input:
        path input_done
        path input_dir
        
    output:
        path "stability*", emit: stability
   
    script:
    """
    #!/bin/bash
    mothur "#make.contigs(file=${input_done}, inputdir=${input_dir})"
    """
}