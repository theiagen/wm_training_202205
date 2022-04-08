version 1.0

# import block
import {task_file} as {task_file_variable}

workflow template_workflow {
  input {
    # workflow inputs
  }
  # tasks and/or subworkflows to execute
  call {task_file_variable}.{task} {
    input:
      {task_inputs}
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    {DataType} {output_variable} = {output_entity}n
    }
}