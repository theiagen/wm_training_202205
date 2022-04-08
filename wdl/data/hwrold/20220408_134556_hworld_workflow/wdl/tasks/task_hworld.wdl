version 1.0

task hworld_task {
  meta {
    description: "Description about my task file"
  }
  input {
    String name
    String docker = "quay.io/theiagen/utility:1.2"
    Int cpu = 4
    Int memory = 8
  }
  command <<<
    # code block executed 
    echo "Hello, world. My name is ~{name}." > message2world.txt
  >>>
  output {
    File hworld_results = "message2world.txt"
    String hworld_docker = docker
  }
  runtime {
    docker: "~{docker}"
    memory: "~{memory} GB"
    cpu: 4
    disks: "local-disk 50 SSD"
    preemptible: 0
  }
}
