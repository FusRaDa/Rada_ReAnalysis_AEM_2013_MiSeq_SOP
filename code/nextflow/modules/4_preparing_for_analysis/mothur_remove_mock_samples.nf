// This process processes files from MOTHUR_REMOVE_LINEAGE 
// Remove mock data groups

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta
// tability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.pick.taxonomy

// Output files renamed to:
// final.fasta
// final.taxonomy
// final.count_table


process MOTHUR_REMOVE_MOCK_SAMPLES{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/4_preparing_for_analysis', mode: 'symlink'

    input:
        path input_done

    output:
        path "final*", emit: fin

    script:
    """
    #!/bin/bash
    mothur "#remove.groups(count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy, groups=Mock)"
    mothur "#rename.file(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.pick.taxonomy, prefix=final)"
    """
}