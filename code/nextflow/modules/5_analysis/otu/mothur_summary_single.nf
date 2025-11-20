// This process processes files from MOTHUR_MAKE_SHARED_OTU
// Generate table containing the number of sequences, the sample coverage, the number of observed OTUs, and the Inverse Simpson diversity estimate.

// Files processed:
// final.opti_mcc.shared

// To produce files:
// final.opti_mcc.groups.ave-std.summary


process MOTHUR_SUMMARY_SINGLE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/otu', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#summary.single(shared=final.opti_mcc.shared, calc=nseqs-coverage-sobs-invsimpson, subsample=T)"
    """
}