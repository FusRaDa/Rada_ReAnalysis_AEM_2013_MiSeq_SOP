// This process processes files from MOTHUR_GET_GROUPS
// Cluster sequences into OTU's (Operational Taxonomic Units)

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.dist
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.list
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.steps
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.sensspec
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.shared
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.opti_mcc.groups.rarefaction


process MOTHUR_SEQ_OTU{
    publishDir 'data/mothur/3_assessing_err_rates', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#
        dist.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta, cutoff=0.03);
        cluster(column=current, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table);
        make.shared(list=current, count=current, label=0.03);
        rarefaction.single(shared=current)
        "
    """
}