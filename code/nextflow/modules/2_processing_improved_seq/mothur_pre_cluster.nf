// This process processes files from MOTHUR_FILTER_UNIQUE_SEQS
// Pre-cluster sequences to reduce seqencing errors

// Files processed:
// stability.trim.contigs.good.unique.good.filter.count_table
// stability.trim.contigs.good.unique.good.filter.unique.fasta

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D0.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D1.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D141.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D142.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D143.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D144.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D145.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D146.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D147.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D148.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D149.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D150.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D2.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D3.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D5.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D6.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D7.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D8.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.F3D9.map
// stability.trim.contigs.good.unique.good.filter.unique.precluster.Mock.map


process MOTHER_PRE_CLUSTER{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)"
    """
}