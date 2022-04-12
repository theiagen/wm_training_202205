version 1.0

task hworld_task {
  meta {
    # task metadata
    description: "Description about my task file"
  }
  input {
    # task inputs
    String name
    String docker = "quay.io/theiagen/utility:1.2"
    Int cpu = 4
    Int memory = 8
  }
  command <<<
    # code block executed 
    echo "Hello, world. My name is ~{name}."
  >>>
  output {
    # task outputs
    String hworld_results = read_string(stdout())
  }
  runtime {
    # runtime environment
    docker: "~{docker}"
    memory: "~{memory} GB"
    cpu: 4
    disks: "local-disk 50 SSD"
    preemptible: 0
  }
}
