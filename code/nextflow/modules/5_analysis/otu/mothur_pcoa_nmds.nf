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
    publishDir 'data/mothur/5_get_nmds_data', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#nmds(phylip=final.opti_mcc.braycurtis.0.03.lt.ave.dist, maxdim=2)"
    """
}