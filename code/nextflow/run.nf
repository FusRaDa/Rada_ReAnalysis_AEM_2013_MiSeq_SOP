#!/usr/bin/env nextflow


// Module imports
include { MOTHUR_MAKE_FILE } from "./modules/0_getting_started/mothur_make_file.nf"

include { MOTHUR_MAKE_CONTIGS } from "./modules/1_reducing_seq_pcr_errors/mothur_make_contigs.nf"
include { MOTHUR_SUMMARY_SCREEN_SEQS } from "./modules/1_reducing_seq_pcr_errors/mothur_summary_screen_seqs.nf"

include { MOTHUR_UNIQUE_SEQS } from './modules/2_processing_improved_seq/mothur_unique_seqs.nf'
include { MOTHUR_PCR_SEQS } from './modules/2_processing_improved_seq/mothur_pcr_seqs.nf'
include { MOTHUR_ALIGN_SCREEN_SEQS } from './modules/2_processing_improved_seq/mothur_align_screen_seqs.nf'
include { MOTHUR_FILTER_UNIQUE_SEQS } from './modules/2_processing_improved_seq/mothur_filter_unique_seqs.nf'
include { MOTHER_PRE_CLUSTER } from './modules/2_processing_improved_seq/mothur_pre_cluster.nf'
include { MOTHUR_CHIMERA_VSEARCH } from './modules/2_processing_improved_seq/mothur_chimera_vsearch.nf'
include { MOTHUR_CLASSIFY } from './modules/2_processing_improved_seq/mothur_classify.nf'
include { MOTHUR_REMOVE_LINEAGE } from './modules/2_processing_improved_seq/mothur_remove_lineage.nf'

include { MOTHUR_GET_GROUPS } from './modules/3_assessing_err_rates/mothur_get_groups.nf'
include { MOTHUR_SEQ_ERROR } from './modules/3_assessing_err_rates/mothur_seq_error.nf'
include { MOTHUR_SEQ_OTU } from './modules/3_assessing_err_rates/mothur_seq_otu.nf'

include { MOTHUR_REMOVE_MOCK_SAMPLES } from './modules/4_preparing_for_analysis/mothur_remove_mock_samples.nf'
include { MOTHUR_CLUSTER_OTU } from './modules/4_preparing_for_analysis/otu/mothur_cluster_otu.nf'
include { MOTHUR_CLUSTER_SPLIT } from './modules/4_preparing_for_analysis/otu/mothur_cluster_split.nf'
include { MOTHUR_MAKE_SHARED_OTU } from './modules/4_preparing_for_analysis/otu/mothur_make_shared_otu.nf'
include { MOTHUR_CLASSIFY_OTU } from './modules/4_preparing_for_analysis/otu/mothur_classify_otu.nf'
include { MOTHUR_MAKE_SHARED_ASV } from './modules/4_preparing_for_analysis/asv/mothur_make_shared_asv.nf'
include { MOTHUR_CLASSIFY_ASV } from './modules/4_preparing_for_analysis/asv/mothur_classify_asv.nf'
include { MOTHUR_PHYLOTYPE } from './modules/4_preparing_for_analysis/phylotypes/mothur_phylotype.nf'
include { MOTHUR_MAKE_SHARED_PHYLOTYPES } from './modules/4_preparing_for_analysis/phylotypes/mothur_make_shared_phylotypes.nf'
include { MOTHUR_CLASSIFY_PHYLOTYPES } from './modules/4_preparing_for_analysis/phylotypes/mothur_classify_phylotypes.nf'
include { MOTHUR_DIST_SEQS_CLEARCUT } from './modules/4_preparing_for_analysis/phylogenetic/mothur_dist_seqs_clearcut.nf'

include { MOTHUR_COUNT_GROUPS } from './modules/5_analysis/mothur_count_groups.nf'
include { MOTHUR_SUB_SAMPLE } from './modules/5_analysis/mothur_sub_sample.nf'
include { MOTHUR_RAREFACTION_SINGLE } from './modules/5_analysis/otu/mothur_rarefaction_single.nf'
include { MOTHUR_SUMMARY_SINGLE } from './modules/5_analysis/otu/mothur_summary_single.nf'
include { MOTHUR_DIST_SHARED } from './modules/5_analysis/otu/mothur_dist_shared.nf'
include { MOTHUR_PCOA_NMDS } from './modules/5_analysis/otu/mothur_pcoa_nmds.nf'
include { MOTHUR_AMOVA } from './modules/5_analysis/otu/mothur_amova.nf'
include { MOTHUR_HOMOVA } from './modules/5_analysis/otu/mothur_homova.nf'
include { MOTHUR_CORR_AXES } from './modules/5_analysis/otu/mothur_corr_axes.nf'
include { MOTHUR_GET_COMMUNITY } from './modules/5_analysis/otu/mothur_get_community.nf'
include { MOTHUR_METASTATS } from './modules/5_analysis/population_level/mothur_metastats.nf'
include { MOTHUR_LEFSE } from './modules/5_analysis/population_level/mothur_lefse.nf'
include { MOTHUR_PHYLO_DIVERSITY } from './modules/5_analysis/phylogeny/mothur_phylo_diversity.nf'
include { MOTHUR_UNIFRAC } from './modules/5_analysis/phylogeny/mothur_unifrac.nf'


// Primary inputs
params.raw_data_dir = 'data/raw'
params.ref_file = 'data/references/silva.v4.align'
params.train_fasta = 'data/references/trainset14_032015.pds.fasta'
params.train_tax = 'data/references/trainset14_032015.pds.tax'
params.mock = 'data/references/HMP_MOCK.v4.fasta'


workflow {
    // Channel data/input directory
    data_ch = channel.fromPath(params.raw_data_dir)

    /*** GETTING STARTED ***/
    // Create stability.files from fastq files in directory MiSeq_SOP
    MOTHUR_MAKE_FILE(data_ch)
    /*** GETTING STARTED ***/


    /*** REDUCING SEQUENCING & PCR ERRORS ***/
    // Process stability files
    MOTHUR_MAKE_CONTIGS(MOTHUR_MAKE_FILE.out.stability, data_ch)

    // Summary and screen (cleaning) of contig sequences
    MOTHUR_SUMMARY_SCREEN_SEQS(MOTHUR_MAKE_CONTIGS.out.stability)
    /*** REDUCING SEQUENCING & PCR ERRORS ***/


    /*** PROCESSING IMPROVED SEQUENCES ***/
    // Remove duplicate sequences
    MOTHUR_UNIQUE_SEQS(MOTHUR_SUMMARY_SCREEN_SEQS.out.stability)

    // Channel from reference alignment file; Align unique sequences to ref alignments
    ref_ch = channel.fromPath(params.ref_file)
    //MOTHUR_PCR_SEQS(MOTHUR_UNIQUE_SEQS.out.stability, ref_ch)

    // Align sequences to customized reference that will also save storage space
    MOTHUR_ALIGN_SCREEN_SEQS(MOTHUR_UNIQUE_SEQS.out.stability, ref_ch)

    // Select the sequences overlapping the v4 region and remove character gaps
    MOTHUR_FILTER_UNIQUE_SEQS(MOTHUR_ALIGN_SCREEN_SEQS.out.stability)

    // Pre-cluster sequences - de-noise
    MOTHER_PRE_CLUSTER(MOTHUR_FILTER_UNIQUE_SEQS.out.stability)

    // Remove chimeras with vsearch algo (heuristic) - do results differ??
    MOTHUR_CHIMERA_VSEARCH(MOTHER_PRE_CLUSTER.out.stability)

    // Classify sequences with Bayesian classifier
    train_fasta_ch = channel.fromPath(params.train_fasta)
    train_tax_ch = channel.fromPath(params.train_tax)
    MOTHUR_CLASSIFY(MOTHUR_CHIMERA_VSEARCH.out.stability, train_fasta_ch, train_tax_ch)

    // Remove lineage/undesirables and summarize taxonomy
    MOTHUR_REMOVE_LINEAGE(MOTHUR_CLASSIFY.out.stability, MOTHUR_CHIMERA_VSEARCH.out.stability)
    /*** PROCESSING IMPROVED SEQUENCES  ***/


    /*** ASSESSING ERROR RATES ***/
    mock_ch = channel.fromPath(params.mock)
    // Measure error rates using mock data
    MOTHUR_GET_GROUPS(MOTHUR_REMOVE_LINEAGE.out.stability)

    // Get error rates
    MOTHUR_SEQ_ERROR(MOTHUR_GET_GROUPS.out.stability, mock_ch)
    /*** ASSESSING ERROR RATES ***/


    /*** GET SHARED OTU's ***/
    // Remove mock samples/groups
    MOTHUR_REMOVE_MOCK_SAMPLES(MOTHUR_REMOVE_LINEAGE.out.stability)

    // Split sequences into bins and then cluster within each bin
    MOTHUR_CLUSTER_SPLIT(MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    
    // Define how many sequences are in each OTU from each group cuttoff level at 0.03
    MOTHUR_MAKE_SHARED_OTU(MOTHUR_CLUSTER_SPLIT.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // Define concensus taxonomy for each OTU
    MOTHUR_CLASSIFY_OTU(MOTHUR_CLUSTER_SPLIT.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    /*** GET SHARED OTU's ***/


    /*** GET NMDS DATA ***/
    // Describe dissimilarity among multiple groups
    MOTHUR_DIST_SHARED(MOTHUR_MAKE_SHARED_OTU.out.fin)

    // Construct PCOA (Principal Coordinates) plots
    MOTHUR_PCOA_NMDS(MOTHUR_DIST_SHARED.out.fin)
    /*** GET NMDS DATA ***/
}