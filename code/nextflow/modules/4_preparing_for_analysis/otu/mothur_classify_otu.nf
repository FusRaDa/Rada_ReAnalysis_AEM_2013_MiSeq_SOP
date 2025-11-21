// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES and MOTHUR_CLUSTER_SPLIT
// Define how many sequences are in each OTU from each group cuttoff level at 0.03

// Files processed:
// final.opti_mcc.list
// final.count_table
// final.taxonomy

// To produce files:
// final.opti_mcc.0.03.cons.taxonomy
// final.opti_mcc.0.03.cons.tax.summary


process MOTHUR_CLASSIFY_OTU{
    publishDir 'data/mothur/4_get_shared_otus', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#classify.otu(list=final.opti_mcc.list, count=final.count_table, taxonomy=final.taxonomy, label=0.03)"
    """
}