version 1.0

task fqscan_task {
  meta {
    # task metadata
    description: "fastq-scan task file"
  }
  input {
    # task inputs
    File read1
    File read2
    String docker = "quay.io/staphb/fastq-scan:0.4.4"
    Int cpu = 2
    Int memory = 2
  }
  command <<<
    # code block executed 
    zcat ~{read1} | fastq-scan | jq .qc_stats.read_total > TOTAL_READS_1
    zcat ~{read2} | fastq-scan | jq .qc_stats.read_total > TOTAL_READS_2
  >>>
  output {
    # task outputs
    Int r1_reads = read_string("TOTAL_READS_1")
    Int r2_reads = read_string("TOTAL_READS_2")
  }
  runtime {
    # runtime environment
    docker: "~{docker}"
    memory: "~{memory} GB"
    cpu: cpu
    disks: "local-disk 50 SSD"
    preemptible: 0
  }
}
