// This process processes files from MOTHUR_DIST_SHARED
// Construct PCOA (Principal Coordinates) plots

// Files processed:
// final.opti_mcc.braycurtis.0.03.lt.ave.dist

// To produce files:
// final.opti_mcc.braycurtis.0.03.lt.ave.pcoa.axes
// final.opti_mcc.braycurtis.0.03.lt.ave.pcoa.loadings
// final.opti_mcc.braycurtis.0.03.lt.ave.nmds.iters
// final.opti_mcc.braycurtis.0.03.lt.ave.nmds.stress
// final.opti_mcc.braycurtis.0.03.lt.ave.nmds.axes


process MOTHUR_PCOA_NMDS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/otu', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#pcoa(phylip=final.opti_mcc.braycurtis.0.03.lt.ave.dist)"
    mothur "#nmds(phylip=final.opti_mcc.braycurtis.0.03.lt.ave.dist)"
    # Test nmds 3 dimensional
    # mothur "#nmds(phylip=final.opti_mcc.braycurtis.0.03.lt.ave.dist, mindim=3, maxdim=3)"
    """
}