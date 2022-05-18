version 1.0

# import block
import "../tasks/task_foo.wdl" as foo
import "../tasks/task_bar.wdl" as bar

workflow foobar_workflow {
  input {
    # workflow inputs
    Int some_number
  }
  # tasks and/or subworkflows to execute
  call foo.foo_task {
    input:
      some_number = some_number
  }
  call bar.bar_task {
    input:
      some_number = foo_task.foo_number
  }
  call foo.foo_task as second_foo_task {
    input:
      some_number = bar_task.bar_number
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    Int foo_number = foo_task.foo_number
    Int bar_number = bar_task.bar_number
    Int second_foo_number = second_foo_task.foo_number
  }
}