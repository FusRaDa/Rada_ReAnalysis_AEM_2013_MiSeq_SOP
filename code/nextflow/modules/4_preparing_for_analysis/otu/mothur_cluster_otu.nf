// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES
// Cluster sequences into OTU's

// Files processed:
// final.fasta
// final.count_table

// To produce files:
// final.dist
// final.opti_mcc.list
// final.opti_mcc.steps
// final.opti_mcc.sensspec


process MOTHUR_CLUSTER_OTU{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/otu', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#dist.seqs(fasta=final.fasta, cutoff=0.03)"
    mothur "#cluster(column=final.dist, count=final.count_table)"
    """
}