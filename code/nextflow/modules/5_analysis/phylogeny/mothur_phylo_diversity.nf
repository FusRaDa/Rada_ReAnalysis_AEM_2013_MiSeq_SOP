// This process processes files from MOTHUR_DIST_SEQS_CLEARCUT and MOTHUR_REMOVE_MOCK_SAMPLES
// Calculate alpha diversity

// Files processed:
// final.phylip.tre,
// final.count_table

// To produce files:
// final.phylip.1.phylodiv.summary
// final.phylip.1.phylodiv.rarefaction


process MOTHUR_PHYLO_DIVERSITY{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/5_analysis/phylogeny', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#phylo.diversity(tree=final.phylip.tre, count=final.count_table, rarefy=T)"
    """
}