// This process processes files from MOTHUR_DIST_SHARED
// Determine if variation in the early samples is significantly different from the variation in the late samples

// Files processed:
// final.opti_mcc.braycurtis.0.03.lt.ave.dist

// To produce files:
// final.opti_mcc.braycurtis.0.03.lt.ave.homova


process MOTHUR_HOMOVA{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/otu', mode: 'symlink'

    input:
        path input_done
        path input_dir

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    cp -a ${input_dir}/. .
    mothur "#homova(phylip=final.opti_mcc.braycurtis.0.03.lt.ave.dist, design=mouse.time.design)"
    """
}