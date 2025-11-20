// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES
// Generate shared file for ASV

// Files processed:
// final.count_table

// To produce files:
// final.asv.list
// final.asv.shared


process MOTHUR_MAKE_SHARED_ASV{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/asv', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#make.shared(count=final.count_table)"
    """
}