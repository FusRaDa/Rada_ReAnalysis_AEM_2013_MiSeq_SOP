// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES
// Bin sequences into phylotypes according to taxonomic classification 

// Files processed:
// final.taxonomy

// To produce files:
// final.tx.sabund
// final.tx.rabund
// final.tx.list


process MOTHUR_PHYLOTYPE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/phylotypes', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#phylotype(taxonomy=final.taxonomy)"
    """
}