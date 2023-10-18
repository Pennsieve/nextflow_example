#!/usr/bin/env nextflow


process build_virtual_path {
    container 'pennsieve/bids-validator'
    // Define the script to be executed
    script:
    """
    python /build_virtual_path.py /job/workflow/input.csv
    ls -la /root/data
    """

    // Other process configuration goes here
    // ...
}
/*
 * bids-validator
 */
process bids_validator {
    container 'pennsieve/bids-validator'
    output: stdout
 
    script: 
    """
    python /build_virtual_path.py /job/workflow/input.csv
    
    bids-validator /root/data/rns_biomarkers_trial
    
    """
}

 
workflow {
    bids_validator | view { it.trim() }
}
