// Generate Rmarkdown file for submission


process GENERATE_RMARKDOWN{
    publishDir 'submission', mode: 'symlink'

    input:
        path input_doc
        path input_rprofile
        path input_csl
        path input_bib

    output:
        path "practice*", emit: submission

    script:
    """
    #!/bin/bash
    R -e "render('${input_doc}')"
    """
}