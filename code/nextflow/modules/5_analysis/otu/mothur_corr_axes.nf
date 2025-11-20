// This process processes files from MOTHUR_SUB_SAMPLE and MOTHUR_PCOA_NMDS
// Determine what OTUs are responsible for shifting the samples along the two axes

// Files processed:
// final.opti_mcc.braycurtis.0.03.lt.ave.pcoa.axes
// final.opti_mcc.0.03.subsample.shared

// To produce files:
// final.opti_mcc.0.03.subsample.spearman.corr.axes


process MOTHUR_CORR_AXES{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/otu', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#corr.axes(axes=final.opti_mcc.braycurtis.0.03.lt.ave.pcoa.axes, shared=final.opti_mcc.0.03.subsample.shared, method=spearman, numaxes=3)"
    """
}