// This process processes files from MOTHUR_SUB_SAMPLE
// See if the data can be partitioned in to seperate community types

// Files processed:
// final.opti_mcc.0.03.subsample.shared

// To produce files:
// final.opti_mcc.0.03.subsample.0.03.dmm.mix.fit
// final.opti_mcc.0.03.subsample.0.03.dmm.1.mix.posterior
// final.opti_mcc.0.03.subsample.0.03.dmm.1.mix.relabund
// final.opti_mcc.0.03.subsample.0.03.dmm.2.mix.posterior
// final.opti_mcc.0.03.subsample.0.03.dmm.2.mix.relabund
// final.opti_mcc.0.03.subsample.0.03.dmm.3.mix.posterior
// final.opti_mcc.0.03.subsample.0.03.dmm.3.mix.relabund
// final.opti_mcc.0.03.subsample.0.03.dmm.4.mix.posterior
// final.opti_mcc.0.03.subsample.0.03.dmm.4.mix.relabund
// final.opti_mcc.0.03.subsample.0.03.dmm.5.mix.posterior
// final.opti_mcc.0.03.subsample.0.03.dmm.5.mix.relabund
// final.opti_mcc.0.03.subsample.0.03.dmm.mix.design
// final.opti_mcc.0.03.subsample.0.03.dmm.mix.parameters
// final.opti_mcc.0.03.subsample.0.03.dmm.mix.summary


process MOTHUR_GET_COMMUNITY{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/otu', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#get.communitytype(shared=final.opti_mcc.0.03.subsample.shared)"
    """
}