// This process first performs make.file to produce stability.files
// Define what fastq files go together

// Directory processed:
// data/raw

// Creates 1 new files: 
// data/mothur/0_getting_started/stability.files


process MOTHUR_MAKE_FILE{
    publishDir 'data/mothur/0_getting_started', mode: 'symlink'

    input:
        path input_dir

    output:
        path "stability*", emit: stability

    script:
    """
    #!/bin/bash
    mothur "#make.file(inputdir=${input_dir}, type=gz, prefix=stability)"
    """
}