// This process processes files from MOTHUR_CLASSIFY and MOTHUR_CHIMERA_VSEARCH
// Remove undesirables and generate tax summary file

// Files processed:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.taxonomy
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.tax.summary

// To produce files:
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.accnos
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.fasta
// stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.tax.summary


process MOTHUR_REMOVE_LINEAGE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'results/2_processing_improved_seq', mode: 'symlink'

    input:
        path input_done_1
        path input_done_2

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#remove.lineage(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.taxonomy, taxon=Chloroplast-Mitochondria-unknown-Archaea-Eukaryota)"
    mothur "#summary.tax(taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pds.wang.pick.taxonomy, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table)"
    """
}