// This process processes files from MOTHUR_MAKE_SHARED_OTU
// Analyze alpha diversity of samples - use favorite graphing software

// Files processed:
// final.opti_mcc.shared

// To produce files:
// final.opti_mcc.groups.rarefaction


process MOTHUR_RAREFACTION_SINGLE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/otu', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#rarefaction.single(shared=final.opti_mcc.shared, calc=sobs, freq=100)"
    """
}