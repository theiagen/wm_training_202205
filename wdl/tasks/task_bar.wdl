version 1.0

task bar_task {
  meta {
    # task metadata
    description: "Bar task file: subtract 25 from some number"
  }
  input {
    # task inputs
    Int some_number
    String docker = "quay.io/theiagen/utility:1.2"
    Int cpu = 2
    Int memory = 2
  }
  command <<<
    # code block executed 
    let "bar_number = ~{some_number} - 25"
    echo $bar_number | tee BAR_NUMBER
  >>>
  output {
    # task outputs
    Int bar_number = read_string("BAR_NUMBER")
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
