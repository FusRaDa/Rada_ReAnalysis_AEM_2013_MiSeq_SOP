// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES and MOTHUR_CLUSTER_SPLIT
// Define how many sequences are in each OTU from each group cuttoff level at 0.03

// Files processed:
// final.opti_mcc.list
// final.count_table

// To produce files:
// final.opti_mcc.shared


process MOTHUR_MAKE_SHARED_OTU{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/otu', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#make.shared(list=final.opti_mcc.list, count=final.count_table, label=0.03)"
    """
}