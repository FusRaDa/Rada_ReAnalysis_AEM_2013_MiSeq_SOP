#!/usr/bin/env nextflow


include { GENERATE_RMARKDOWN } from './modules/6_submission/generate_rmarkdown.nf'


params.rprofile = '.Rprofile'
params.doc = 'submission/practice.Rmd'
params.csl = 'submission/mbio.csl'
params.bib = 'submission/references.bib'

workflow {

    /*** GENERATE SUBMISSION RMARKDOWN ***/
    rprofile_ch = channel.fromPath(params.rprofile)
    doc_ch = channel.fromPath(params.doc)
    csl_ch = channel.fromPath(params.csl)
    bib_ch = channel.fromPath(params.bib)

    GENERATE_RMARKDOWN(doc_ch, rprofile_ch, csl_ch, bib_ch)
    /*** GENERATE SUBMISSION RMARKDOWN ***/

}
