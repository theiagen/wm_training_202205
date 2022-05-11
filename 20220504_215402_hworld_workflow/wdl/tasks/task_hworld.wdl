version 1.0

task hworld_task {
  meta {
    # task metadata
    description: "Hello world task file"
  }
  input {
    # task inputs
    String name
    String docker = "quay.io/theiagen/utility:1.2"
    Int cpu = 2
    Int memory = 2
  }
  command <<<
    # code block executed 
    echo "Hello, world. My name is ~{name}." > HWORLD_OUT
  >>>
  output {
    # task outputs
    String hworld_results = read_string("HWORLD_OUT")
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
