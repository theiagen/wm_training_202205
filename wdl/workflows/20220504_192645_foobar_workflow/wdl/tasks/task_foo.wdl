version 1.0

task foo_task {
  meta {
    # task metadata
    description: "Foo task file: multiply some number by 3"
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
    let "foo_number = ~{some_number} * 3"
    echo $foo_number | tee FOO_NUMBER
  >>>
  output {
    # task outputs
    Int foo_number = read_string("FOO_NUMBER")
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
