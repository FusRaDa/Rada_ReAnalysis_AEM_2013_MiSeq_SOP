// This process processes files from MOTHUR_DIST_SHARED
// Determine if clustering within the ordinations is statistically significant using AMOVA

// Files processed:
// final.opti_mcc.braycurtis.0.03.lt.ave.dist
// mouse.time.design

// To produce files:
// final.opti_mcc.braycurtis.0.03.lt.ave.amova


process MOTHUR_AMOVA{
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
    mothur "#amova(phylip=final.opti_mcc.braycurtis.0.03.lt.ave.dist, design=mouse.time.design)"
    """
}