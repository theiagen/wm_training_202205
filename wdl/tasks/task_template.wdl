version 1.0

task template_task {
  meta {
    # task metadata
  }
  input {
    # task inputs
    {DataType} {input_variable}
  }
  command <<<
    # code block executed 
  >>>
  output {
    # task outputs
    {DataType} {output_variable} = {output_entity}
  }
  runtime {
    # runtime environment
    docker:
    memory:
    cpu:
    disks:
    preemptible: 
  }
}
