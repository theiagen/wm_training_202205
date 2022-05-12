version 1.0

task trimmomatic_task {
  meta {
    # task metadata
    description: "trimmomatic task file"

  }
  input {
    # task inputs
    File read1
    File read2
    String docker = "quay.io/staphb/trimmomatic:0.39"
    Int cpu = 2
    Int memory = 2
    Int minlen = 75
    Int window_size = 10
    Int required_quality = 20
  }
  command <<<
    # code block executed
    java -jar /Trimmomatic-0.39/trimmomatic-0.39.jar PE ~{read1} ~{read2} -baseout reads_trimmed.fq.gz MINLEN:~{minlen} SLIDINGWINDOW:~{window_size}:~{required_quality}
  >>>
  output {
    # task outputs
    File paired_1 = "reads_trimmed_1P.fq.gz"
    File paired_2 = "reads_trimmed_2P.fq.gz"
    File unpaired_1 = "reads_trimmed_1U.fq.gz"
    File unpaired_2 = "reads_trimmed_1U.fq.gz"
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
