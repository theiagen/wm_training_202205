// Run Trimmomatic on input fastqs
process TRIMMOMATIC {

    // Specify the docker container to use
    container "quay.io/staphb/trimmomatic:0.39"

    // Specify the number of cpus this process can use
    cpus params.max_cpus

    // Copy outfiles to a directory with the value of meta.id
    publishDir "${meta.id}-dsl2/", mode: 'copy'

    // Tag directive prints a string for the process
    tag "${meta.id}"

    // Take two inputs, the square and a sleep time (random number)
    input:
    tuple val(meta), path(reads)

    // Capture the STDOUT and emit it to a triangle output 
    output:
    tuple val(meta), path("*P.fastq.gz"), emit: trimmed
    tuple val(meta), path("*U.fastq.gz"), emit: unpaired

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
