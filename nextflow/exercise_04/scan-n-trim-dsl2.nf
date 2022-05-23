#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

/*
In this example we're going to recreate the scan and trim pipeline in Nextflow DSL2
*/

include { FASTQ_SCAN as FASTQ_SCAN_ORIGINAL } from './modules/fastqscan.nf'
include { FASTQ_SCAN as FASTQ_SCAN_FINAL } from './modules/fastqscan.nf'
include { TRIMMOMATIC } from './modules/trimmomatic.nf'

// Create the input channel
my_inputs = tuple(
    ['id': params.sample ],
    [file(params.r1, checkIfExists: true),
     file(params.r2, checkIfExists: true)]
)

workflow {
    // Run fastq-scan on the original FASTQs
    FASTQ_SCAN_ORIGINAL(my_inputs, 'original')

    // Run Trimmomatic on the original FASTQs
    TRIMMOMATIC(my_inputs)

    // Run fastq-scan on the Timmomatic proccessed FASTQs
    FASTQ_SCAN_FINAL(TRIMMOMATIC.out.trimmed, 'final')
}
