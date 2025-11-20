// This process processes files from MOTHUR_MAKE_SHARED_OTU
// Generate subsampled files for analysis

// Files processed:
// final.opti_mcc.shared

// To produce files:
// final.opti_mcc.0.03.subsample.shared


process MOTHUR_SUB_SAMPLE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#sub.sample(shared=final.opti_mcc.shared, size=2404)"
    # size parameter may not be necessary as the smallest size in shared file is set to default
    """
}