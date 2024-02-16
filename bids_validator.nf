#!/usr/bin/env nextflow

/*
 * bids-validator
 */
process main_flow {
    input:stdin
    container 'pennsieve/bids-validator:latest'
    output: stdout
 
    script: 
    """
    bids-validator /data/
    
    """
}
