version 1.0

task trimmomatic_task {
  meta {
    # task metadata
    description: "Task to trim paired-end read data with trimmomatic"
  }
  input {
    File read1
    File read2
    String docker = "quay.io/staphb/trimmomatic:0.39"
    Int cpu = 4
    Int memory = 8
    # Trimmomatic params
    Int trimmomatic_minlen = 75
    Int trimmomatic_window_size = 4
    Int trimmomatic_quality_trim_score = 30
    Int threads = 4
  }
  command <<<
  # run trimmomatic 
  trimmomatic PE \
    -threads ~{threads} \
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