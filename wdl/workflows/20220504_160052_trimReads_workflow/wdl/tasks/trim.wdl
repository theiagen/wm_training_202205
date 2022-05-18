task trim_task {
  meta {
    # task metadata
  }
  input {
    # task inputs
    File fqfile1
    File fqfile2
    Int minlength
    Int window
    Int qual
    String baseName = basename(fqfile1, "_.*")
  }
  command <<<
    # code block executed
    trimmomatic PE ${fqfile1} ${fqfile2} ${baseName}_R1.fq.gz ${baseName}_RU1.fg.gz ${baseName}_R2.fg.gz ${baseName}_RU2.fq.gz SLIDINGWINDOW ${window} AVGQUAL ${qual} MINLEN ${minlength}  
  >>>
  output {
    # task outputs
    File out1 = "${baseName}_R1.fq.gz"
    File out2 = "${baseName}_R2.fq.gz"
  }
  runtime {
    # runtime environment
    docker: "staphb/trimmomatic"
    memory: '8 GB'

  }
}

