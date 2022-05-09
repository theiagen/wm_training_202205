version 1.0

task trimmomatic_task {
  meta {
    # task metadata
    description: "Trim paired-end read data with Trimmomatic tool"
  }
  input {
    # task inputs
    File read1
    File read2
    Int trimmomatic_minlen = 75
    Int trimmomatic_window_size = 10
    Int trimmomatic_quality_trim_score = 20
    String docker = "staphb/trimmomatic:0.39"
    Int cpu = 2
    Int memory = 2
  }
  command <<<
    # code block executed
    trimmomatic PE \
    ~{read1} ~{read2} \
    -baseout trimmed.fastq.gz \
    SLIDINGWINDOW:~{trimmomatic_window_size}:~{trimmomatic_quality_trim_score} \
    MINLEN:~{trimmomatic_minlen}
  >>>
  output {
    # task outputs
    File read1_trimmed = "trimmed_1P.fastq.gz"
    File read2_trimmed = "trimmed_2P.fastq.gz"
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
