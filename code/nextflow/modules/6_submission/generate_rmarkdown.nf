// Generate Rmarkdown file for submission


process GENERATE_RMARKDOWN{
    publishDir 'submission', mode: 'symlink'

    input:
        path input_doc
        path input_rprofile

    output:
        path "practice*", emit: submission

    script:
    """
    #!/bin/bash
    R -e "render('${input_doc}')"
    """
}