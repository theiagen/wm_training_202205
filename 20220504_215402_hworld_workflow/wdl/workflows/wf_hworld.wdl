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
    String hworld_results = hworld_task.hworld_results
  }
}