#!/usr/bin/env nextflow


include { GENERATE_RMARKDOWN } from './modules/6_submission/generate_rmarkdown.nf'


params.rprofile = '.Rprofile'
params.doc = 'submission/practice.Rmd'


workflow {

    /*** GENERATE SUBMISSION RMARKDOWN ***/
    rprofile_ch = channel.fromPath(params.rprofile)
    doc_ch = channel.fromPath(params.doc)

    GENERATE_RMARKDOWN(doc_ch, rprofile_ch)
    /*** GENERATE SUBMISSION RMARKDOWN ***/

}
