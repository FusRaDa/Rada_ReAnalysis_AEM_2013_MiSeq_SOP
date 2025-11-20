// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES and MOTHUR_MAKE_SHARED_ASV
// Generate concensus taxonomy for each ASV

// Files processed:
// final.asv.list
// final.count_table
// final.taxonomy

// To produce files:
// final.asv.ASV.cons.taxonomy
// final.asv.ASV.cons.tax.summary


process MOTHUR_CLASSIFY_ASV{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/asv', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "final*", emit: fin
    
    script:
    """
    #!/bin/bash
    mothur "#classify.otu(list=final.asv.list, count=final.count_table, taxonomy=final.taxonomy, label=ASV)"
    """
}