#!/usr/bin/env nextflow

process setup_persistent_volume {
    container 'alpine'
    memory '1GB'
    output: stdout

    containerOptions "-v pennsieve_workflow_${params.workflowJobId}:/data"

    script:
    """
    #!/bin/sh
    echo '$params.workflowJobId'
    """
}

/*
 * bids-validator
 */
process bids_validator {
    input:stdin
    container 'pennsieve/bids-validator:latest'
    output: stdout
 
    script: 
    """
    python /build_virtual_path.py /job/workflow/input.csv
    
    bids-validator /root/data/
    
    """
}

 
workflow {
    setup_persistent_volume | bids_validator | view { it.trim() }
}
