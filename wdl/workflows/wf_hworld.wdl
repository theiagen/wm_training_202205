version 1.0

# import block
import "../tasks/task_hworld.wdl" as hworld

workflow hworld_workflow {
  input {
    # workflow inputs
    String name 
  }
  # tasks and/or subworkflows to execute
  call hworld.hworld_task {
    input:
      name = name
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    File hworld_message = hworld_task.hworld_results
    String hworld_docker = hworld_task.hworld_docker
  }
}