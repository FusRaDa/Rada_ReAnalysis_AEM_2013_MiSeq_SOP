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

// params.ref_file = 'data/silva.bacteria/silva.bacteria/silva.bacteria.fasta'
// params.train_dir = 'data/trainset9_032012.pds'


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


    // /*** PROCESSING IMPROVED SEQUENCES ***/
    // // Remove duplicate sequences
    // MOTHUR_UNIQUE_SEQS(MOTHUR_SUMMARY_SCREEN_SEQS.out.stability)

    // // Channel from reference alignment file; Align unique sequences to ref alignments
    // ref_ch = channel.fromPath(params.ref_file)
    // MOTHUR_PCR_SEQS(MOTHUR_UNIQUE_SEQS.out.stability, ref_ch)

    // // Align sequences to customized reference that will also save storage space
    // MOTHUR_ALIGN_SCREEN_SEQS(MOTHUR_PCR_SEQS.out.silva, MOTHUR_UNIQUE_SEQS.out.stability)

    // // Select the sequences overlapping the v4 region and remove character gaps
    // MOTHUR_FILTER_UNIQUE_SEQS(MOTHUR_ALIGN_SCREEN_SEQS.out.stability)

    // // Pre-cluster sequences - de-noise
    // MOTHER_PRE_CLUSTER(MOTHUR_FILTER_UNIQUE_SEQS.out.stability)

    // // Remove chimeras with vsearch algo (heuristic) - do results differ??
    // MOTHUR_CHIMERA_VSEARCH(MOTHER_PRE_CLUSTER.out.stability)

    // // Classify sequences with Bayesian classifier
    // train_ch = channel.fromPath(params.train_dir)
    // MOTHUR_CLASSIFY(MOTHUR_CHIMERA_VSEARCH.out.stability, train_ch)

    // // Remove lineage/undesirables and summarize taxonomy
    // MOTHUR_REMOVE_LINEAGE(MOTHUR_CLASSIFY.out.stability, MOTHUR_CHIMERA_VSEARCH.out.stability)
    // /*** PROCESSING IMPROVED SEQUENCES  ***/


    // /*** ASSESSING ERROR RATES ***/
    // // Measure error rates using mock data
    // MOTHUR_GET_GROUPS(MOTHUR_REMOVE_LINEAGE.out.stability, data_ch)

    // // Get error rates
    // MOTHUR_SEQ_ERROR(MOTHUR_GET_GROUPS.out.stability, data_ch)

    // // Cluster sequences into OTU's
    // MOTHUR_SEQ_OTU(MOTHUR_GET_GROUPS.out.stability, data_ch)
    // /*** ASSESSING ERROR RATES ***/


    // /*** PREPARING FOR ANALYSIS ***/
    // // Remove mock samples/groups
    // MOTHUR_REMOVE_MOCK_SAMPLES(MOTHUR_REMOVE_LINEAGE.out.stability)

    // /* OTU */
    // // Cluster sequences into OTU's - do results differ?? 
    // MOTHUR_CLUSTER_OTU(MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // // Split sequences into bins and then cluster within each bin
    // MOTHUR_CLUSTER_SPLIT(MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // // Define how many sequences are in each OTU from each group cuttoff level at 0.03
    // MOTHUR_MAKE_SHARED_OTU(MOTHUR_CLUSTER_SPLIT.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // // Define concensus taxonomy for each OTU
    // MOTHUR_CLASSIFY_OTU(MOTHUR_CLUSTER_SPLIT.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    // /* OTU */

    // /* ASV */
    // // Generate shared file for ASV
    // MOTHUR_MAKE_SHARED_ASV(MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // // Generate concensus taxonomy for each ASV
    // MOTHUR_CLASSIFY_ASV(MOTHUR_MAKE_SHARED_ASV.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    // /* ASV */

    // /* Phylotypes */
    // // Bin sequences into phylotypes according to taxonomic classification 
    // MOTHUR_PHYLOTYPE(MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // // Generate shared files for phylotypes
    // MOTHUR_MAKE_SHARED_PHYLOTYPES(MOTHUR_PHYLOTYPE.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // // Identify OTUs based on phylotypes
    // MOTHUR_CLASSIFY_PHYLOTYPES(MOTHUR_PHYLOTYPE.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    // /* Phylotypes */

    // /* Phylogenetic */
    // // Calculate phylogenetic diversity, unifrac commands, tree generation
    // MOTHUR_DIST_SEQS_CLEARCUT(MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    // /* Phylogenetic */
    // /*** PREPARING FOR ANALYSIS ***/


    // /*** ANALYSIS ***/

    // // Determine how many sequences are in each sample 
    // MOTHUR_COUNT_GROUPS(MOTHUR_MAKE_SHARED_OTU.out.fin)

    // // Generate subsampled files for analysis
    // MOTHUR_SUB_SAMPLE(MOTHUR_MAKE_SHARED_OTU.out.fin)


    // /** OTU **/
    // /* ALPHA DIVERSITY */ 
    // // Analyze alpha diversity of samples - use favorite graphing software
    // MOTHUR_RAREFACTION_SINGLE(MOTHUR_MAKE_SHARED_OTU.out.fin)

    // //graph rarefaction output file here

    // // Generate table containing the number of sequences, the sample coverage, the number of observed OTUs, and the Inverse Simpson diversity estimate.
    // MOTHUR_SUMMARY_SINGLE(MOTHUR_MAKE_SHARED_OTU.out.fin)
    // /* ALPHA DIVERSITY */ 

    // /* BETA DIVERSITY MEASUREMENTS */ 
    // // Calculate similarity of the membership and structure in various samples
    // MOTHUR_DIST_SHARED(MOTHUR_MAKE_SHARED_OTU.out.fin)

    // // Construct PCOA (Principal Coordinates) plots
    // MOTHUR_PCOA_NMDS(MOTHUR_DIST_SHARED.out.fin)

    // // Determine if clustering within the ordinations is statistically significant using AMOVA
    // MOTHUR_AMOVA(MOTHUR_DIST_SHARED.out.fin, data_ch)

    // // Determine if variation in the early samples is significantly different from the variation in the late samples
    // MOTHUR_HOMOVA(MOTHUR_DIST_SHARED.out.fin, data_ch)

    // // Determine what OTUs are responsible for shifting the samples along the two axes
    // MOTHUR_CORR_AXES(MOTHUR_SUB_SAMPLE.out.fin, MOTHUR_PCOA_NMDS.out.fin)

    // // See if the data can be partitioned in to seperate community types
    // MOTHUR_GET_COMMUNITY(MOTHUR_SUB_SAMPLE.out.fin)
    // /* BETA DIVERSITY MEASUREMENTS */ 
    // /** OTU **/


    // /** POPULATION-LEVEL ANALYSIS **/ 
    // // Differentiate between different groupings of samples
    // MOTHUR_METASTATS(MOTHUR_SUB_SAMPLE.out.fin, data_ch)

    // // Similar method as metastats to identify outlying OTUs
    // MOTHUR_LEFSE(MOTHUR_SUB_SAMPLE.out.fin, data_ch)
    // /** POPULATION-LEVEL ANALYSIS **/ 


    // /** ASV-BASED ANALYSIS **/ 
    // /** ASV-BASED ANALYSIS **/ 


    // /** PHYLOTYPE-BASED ANALYSIS **/ 
    // /** PHYLOTYPE-BASED ANALYSIS **/ 


    // /** PHYLOGENY-BASED ANALYSIS **/ 
    // /* ALPHA DIVERSITY */
    // // Calculate alpha diversity
    // MOTHUR_PHYLO_DIVERSITY(MOTHUR_DIST_SEQS_CLEARCUT.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)

    // /* BETA DIVERSITY */
    // MOTHUR_UNIFRAC(MOTHUR_DIST_SEQS_CLEARCUT.out.fin, MOTHUR_REMOVE_MOCK_SAMPLES.out.fin)
    // /* BETA DIVERSITY */

    // // Refer back to analyzing beta diversity in OTU example...
    // /** PHYLOGENY-BASED ANALYSIS **/ 

    // /*** ANALYSIS ***/



}