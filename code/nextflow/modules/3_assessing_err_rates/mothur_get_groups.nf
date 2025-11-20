// This process processes files from MOTHUR_REMOVE_LINEAGE
// Measure error rates using mock data

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta


process MOTHUR_GET_GROUPS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/3_assessing_err_rates', mode: 'symlink'

    input:
        path input_done
        path input_dir

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    cp -a ${input_dir}/. .
    mothur "#get.groups(count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta, groups=Mock)"
    """
}