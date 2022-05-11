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
    Int? threads = 4
    Int minlen = 75
    Int window_size = 10
    Int required_quality = 20    
    String docker = "staphb/trimmomatic:0.39"
    }
  command <<<
    # code block executed
    trimmomatic PE -threads ~{threads} ~{read1} ~{read2} -baseout OUTPUT.fastq.gz \
    SLIDINGWINDOW:~{window_size}:~{required_quality} MINLEN:~{minlen}
  >>>
  output {
    # task outputs  
    File read1_trimmed = "OUTPUT_1P.fastq.gz"
    File read2_trimmed = "OUTPUT_2P.fastq.gz"
  }
  runtime {
    # runtime environment
    docker: "~{docker}"
    memory: "8 GB"
    cpu: "~{threads}"
    disks: "local-disk 50 SSD"
    preemptible: 0
  }
}
