// This process processes files from MOTHUR_GET_GROUPS
// Get error rates

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.summary
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.seq
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.chimera
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.seq.forward
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.seq.reverse
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.count
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.matrix
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.error.ref


process MOTHUR_SEQ_ERROR{
    publishDir 'data/mothur/3_assessing_err_rates', mode: 'symlink'

    input:
        path input_done
        path input_ref

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#seq.error(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table, reference=${input_ref}, aligned=F)"
    """
}