// This process processes files from MOTHUR_REMOVE_MOCK_SAMPLES
// Calculate phylogenetic diversity, unifrac commands, tree generation

// Files processed:
// final.fasta

// To produce files:
// final.phylip.dist
// final.phylip.tre


process MOTHUR_DIST_SEQS_CLEARCUT{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis/phylogenetic', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#dist.seqs(fasta=final.fasta, output=lt)"
    mothur "#clearcut(phylip=final.phylip.dist)"
    """
}