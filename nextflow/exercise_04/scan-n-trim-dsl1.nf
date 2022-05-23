#!/usr/bin/env nextflow
nextflow.enable.dsl = 1

/*
In this example we're going to recreate the scan and trim pipeline in Nextflow DSL1
*/

// Create the input channels (DSL1 channels cannot be reused)
my_fastq_scan_inputs = Channel.from([tuple(
    ['id': params.sample ],
    [file(params.r1, checkIfExists: true),
     file(params.r2, checkIfExists: true)]
)])

my_trimmomatic_inputs = Channel.from([tuple(
    ['id': params.sample ],
    [file(params.r1, checkIfExists: true),
     file(params.r2, checkIfExists: true)]
)])

process FASTQ_SCAN_ORIGINAL {

    // Specify the docker container to use
    container "staphb/fastq-scan:0.4.4"

    // Copy outfiles to a directory with the value of meta.id
    publishDir "${meta.id}-dsl1/", mode: 'copy'

    // Tag directive prints a string for the process
    tag "${meta.id}"

    // Take two inputs, the square and a sleep time (random number)
    input:
    set val(meta), path(reads) from my_fastq_scan_inputs
    
    // Capture the STDOUT and emit it to a triangle output 
    output:
    tuple val(meta), path("*.json"), emit: json

    // Replace square with triangle, and sleep for a random amount of time
    script:
    """
    zcat ${reads[0]} | fastq-scan > ${meta.id}_R1-original.json
    zcat ${reads[1]} | fastq-scan > ${meta.id}_R2-original.json
    """
}

// Run Trimmomatic on input fastqs
process TRIMMOMATIC {

    // Specify the docker container to use
    container "quay.io/staphb/trimmomatic:0.39"

    // Specify the number of cpus this process can use
    cpus params.max_cpus

    // Copy outfiles to a directory with the value of meta.id
    publishDir "${meta.id}-dsl1/", mode: 'copy'

    // Tag directive prints a string for the process
    tag "${meta.id}"

    // Take two inputs, the square and a sleep time (random number)
    input:
    set val(meta), path(reads) from my_trimmomatic_inputs

    // Capture the STDOUT and emit it to a triangle output 
    output:
    tuple val(meta), path("*P.fastq.gz") into trimmomatic_paired
    tuple val(meta), path("*U.fastq.gz") into trimmomatic_unpaired

    // Replace square with triangle, and sleep for a random amount of time
    script:
    """
    trimmomatic PE \\
        -threads ${task.cpus} \\
        ${reads[0]} ${reads[1]} \\
        -baseout ${meta.id}.fastq.gz \\
        SLIDINGWINDOW:${params.window_size}:${params.quality_trim_score} \\
        MINLEN:${params.minlen}
    """
}

process FASTQ_SCAN_FINAL {

    // Specify the docker container to use
    container "staphb/fastq-scan:0.4.4"

    // Copy outfiles to a directory with the value of meta.id
    publishDir "${meta.id}-dsl1/", mode: 'copy'

    // Tag directive prints a string for the process
    tag "${meta.id}"

    // Take two inputs, the square and a sleep time (random number)
    input:
    tuple val(meta), path(reads) from trimmomatic_paired
    
    // Capture the STDOUT and emit it to a triangle output 
    output:
    tuple val(meta), path("*.json"), emit: json

    // Replace square with triangle, and sleep for a random amount of time
    script:
    """
    zcat ${reads[0]} | fastq-scan > ${meta.id}_R1-final.json
    zcat ${reads[1]} | fastq-scan > ${meta.id}_R2-final.json
    """
}
