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
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/otu', mode: 'symlink'

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