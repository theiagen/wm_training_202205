task fqscan_task {
  meta {
    # task metadata
  }
  input {
    # task inputs
    File fqfile1
    File fqfile2
  }
  command <<<
    # code block executed
    zcat ${fqfile1} ${fqfile2}| fastq-scan | jq .qc_stats.read_total > reads_counts.txt
  >>>
  output {
    # task outputs
    File outputfile = "reads_counts.txt"
  }
  runtime {
    # runtime environment
    docker: "staphb/fastq-scan"
    memory: '8 GB'

  }
}

