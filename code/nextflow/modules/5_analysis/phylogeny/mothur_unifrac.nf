// This process processes files from MOTHUR_DIST_SEQS_CLEARCUT and MOTHUR_REMOVE_MOCK_SAMPLES
// Assess similarity between two communities membership (weighted/unweighted) for PCoA

// Files processed:
// final.phylip.tre
// final.count_table

// To produce files:
// final.phylip.uwsummary
// final.phylip.1.unweighted.ave.dist
// final.phylip.1.unweighted.std.dist
// final.phylip.tre1.unweighted.phylip.dist
// final.phylip.tre1.weighted.phylip.dist
// final.phylip.tre1.wsummary
// final.phylip.tre1.weighted.ave.dist
// final.phylip.tre1.weighted.std.dist


process MOTHUR_UNIFRAC{
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
    mothur "#unifrac.unweighted(tree=final.phylip.tre, count=final.count_table, distance=lt,random=F, subsample=t)"
    mothur "#unifrac.weighted(tree=final.phylip.tre, count=final.count_table, distance=lt, random=F, subsample=t)"
    """
}