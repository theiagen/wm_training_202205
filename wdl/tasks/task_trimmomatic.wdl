version 1.0

task trimmomatic_task {
  meta {
    # trims reads using trimmomatic
  }
  input {
    # task inputs
    File read1
    File read2
    String docker = "quay.io/staphb/trimmomatic:0.39"
    Int minlen = 75
    Int window_size = 10
    Int required_quality = 20
    Int cpu = 2
    Int memory = 2
  }
  command <<<
    # code block executed
    trimmomatic PE \
    ~{read1} ~{read2} \
    output_forward_paired.fq.gz output_forward_unpaired.fq.gz output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz \
    SLIDINGWINDOW:~{window_size}:~{required_quality} \
    MINLEN:~{minlen} 
  >>>
  output {
    # task outputs
    File read1_trimmed = "output_forward_paired.fq.gz"
    File read2_trimmed = "output_reverse_paired.fq.gz" 
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
