// Run fastq-scan on input fastqs
process FASTQ_SCAN {

    // Specify the docker container to use
    container "staphb/fastq-scan:0.4.4"

    // Copy outfiles to a directory with the value of meta.id
    publishDir "${meta.id}-dsl2/", mode: 'copy'

    // Tag directive prints a string for the process
    tag "${meta.id}"

    // Take two inputs, the square and a sleep time (random number)
    input:
    tuple val(meta), path(reads)
    val fastq_type
    
    // Capture the STDOUT and emit it to a triangle output 
    output:
    tuple val(meta), path("*.json"), emit: json

    // Replace square with triangle, and sleep for a random amount of time
    script:
    """
    zcat ${reads[0]} | fastq-scan > ${meta.id}_R1-${fastq_type}.json
    zcat ${reads[1]} | fastq-scan > ${meta.id}_R2-${fastq_type}.json
    """
}
