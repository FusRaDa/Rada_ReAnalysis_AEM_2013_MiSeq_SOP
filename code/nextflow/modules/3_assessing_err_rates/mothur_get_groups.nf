// This process processes files from MOTHUR_REMOVE_LINEAGE
// Measure error rates using mock data

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta


process MOTHUR_GET_GROUPS{
    publishDir 'data/mothur/3_assessing_err_rates', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    # *.pick.* only because chimera removal already removes seqs
    mothur "#get.groups(count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy, groups=Mock-Mock2)"
    """
}