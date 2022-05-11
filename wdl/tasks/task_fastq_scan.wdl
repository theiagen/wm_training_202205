version 1.0

task fastq_scan_task {
  meta {
    # task metadata
    description: "fastq-scan task file"
  }
  input {
    # task inputs
    #{DataType} {input_variable}
    File read1
    File read2
    String docker = "staphb/fastq-scan:0.4.4"
    Int cpu = 2
    Int memory = 2
  }
  command <<<
    # code block executed
    zcat ~{read1} | fastq-scan | jq .qc_stats.read_total > TOTAL_READS1
    zcat ~{read2} | fastq-scan | jq .qc_stats.read_total > TOTAL_READS2
  >>>
  output {
    # task outputs
    #{DataType} {output_variable} = {output_entity}
    Int scan_results1 = read_string("TOTAL_READS1")
    Int scan_results2 = read_string("TOTAL_READS2")
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
