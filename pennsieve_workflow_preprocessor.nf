#!/usr/bin/env nextflow

process setup_persistent_volume {
    container 'alpine'
    memory '1GB'
    output: stdout

    containerOptions "-v pennsieve_workflow_${params.workflowJobId}:/path/in/container"

    script:
    """
    #!/bin/sh
    echo 'Hello, World!' > /path/in/container/my_file.txt
    echo '$params.workflowJobId'
    """
}

process test{
    output: stdout
    script:
    """
    echo 'test'
    """
}

 
workflow {
    setup_persistent_volume | view { it.trim() }
}
