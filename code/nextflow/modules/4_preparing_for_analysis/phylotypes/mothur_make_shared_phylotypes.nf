// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES and MOTHUR_PHYLOTYPE
// Bin sequences into phylotypes according to taxonomic classification 

// Files processed:
// final.count_table
// final.tx.list

// To produce files:
// final.tx.shared


process MOTHUR_MAKE_SHARED_PHYLOTYPES{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/phylotypes', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#make.shared(list=final.tx.list, count=final.count_table, label=1)"
    """
}