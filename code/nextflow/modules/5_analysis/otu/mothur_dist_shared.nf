// This process processes files from MOTHUR_MAKE_SHARED_OTU
// Calculate similarity of the membership and structure in various samples

// Files processed:
// final.opti_mcc.shared,

// To produce files:
// final.opti_mcc.braycurtis.0.03.lt.ave.dist
// final.opti_mcc.braycurtis.0.03.lt.std.dist
// final.opti_mcc.jclass.0.03.lt.ave.dist
// final.opti_mcc.jclass.0.03.lt.std.dist


process MOTHUR_DIST_SHARED{
    publishDir 'data/mothur/5_get_nmds_data', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#dist.shared(shared=final.opti_mcc.shared, calc=braycurtis-jclass, subsample=t)"
    """
}