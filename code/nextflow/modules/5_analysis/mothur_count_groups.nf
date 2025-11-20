// This process processes files from MOTHUR_MAKE_SHARED_OTU
// Determine how many sequences are in each sample 

// Files processed:
// final.opti_mcc.shared

// To produce files:
// final.opti_mcc.count.summary


process MOTHUR_COUNT_GROUPS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#count.groups(shared=final.opti_mcc.shared)"
    """
}