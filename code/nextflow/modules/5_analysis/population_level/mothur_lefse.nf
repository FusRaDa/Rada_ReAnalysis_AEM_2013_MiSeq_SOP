// This process processes files from MOTHUR_SUB_SAMPLE
// Similar method as metastats to identify outlying OTUs

// Files processed:
// final.opti_mcc.0.03.subsample.shared,
// mouse.time.design

// To produce files:
// final.opti_mcc.0.03.subsample.0.03.lefse_summary


process MOTHUR_LEFSE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/population_level', mode: 'symlink'

    input:
        path input_done
        path input_dir

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    cp -a ${input_dir}/. .
    mothur "#lefse(shared=final.opti_mcc.0.03.subsample.shared, design=mouse.time.design)"
    """
}