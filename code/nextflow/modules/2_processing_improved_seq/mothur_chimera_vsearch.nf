// This process processes files from MOTHER_PRE_CLUSTER
// Remove chimeras using vsearch algo to further improve sequences

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.chimeras
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.accnos
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.summary


process MOTHUR_CHIMERA_VSEARCH{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#chimera.vsearch(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table, dereplicate=t)"
    mothur "#summary.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table)"
    """
}