// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES
// Split sequences into bins and then cluster within each bin

// Files processed:
// final.fasta
// final.count_table
// final.taxonomy

// To produce files:
// final.opti_mcc.sensspec
// final.dist
// final.opti_mcc.list
// final.opti_mcc.sensspec
// final.0.dist <-> final.18.dist


process MOTHUR_CLUSTER_SPLIT{
    publishDir 'data/mothur/4_get_shared_otus', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#cluster.split(fasta=final.fasta, count=final.count_table, taxonomy=final.taxonomy, taxlevel=4, cutoff=0.03)"
    """
}