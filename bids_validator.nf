#!/usr/bin/env nextflow

/*
 * bids-validator
 */
process bids_validator {
    container 'pennsieveci/bids-validator'
    output: stdout
 
    """
    bids-validator /data
    """
}

/*
 * bids-validator
 */
process python_actions {
    container 'python:latest'
    output: stdout

    input: stdin
 
 
    """
    #!/usr/bin/env python
    import sys
    import csv
    import hashlib
    import os

    # Prints output from bids_validator process
    print(sys.stdin.read())
    
    for root, dirs, files in os.walk('/data'):
        for file in files:
            file_path = os.path.join(root, file)
            with open(file_path, 'rb') as file:
                content = file.read()
                md5_hash = hashlib.md5(content).hexdigest()
                print(file_path + "::" + md5_hash)
    """
}

 
workflow {
    bids_validator | python_actions |  view { it.trim() }
}
