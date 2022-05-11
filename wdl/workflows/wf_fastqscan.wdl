version 1.0

# import block
import task_fastqscan.wdl as fastqscan

workflow wf_fastqscan {
  input {
    # workflow inputs
    File read1
    File read2
  }
  # tasks and/or subworkflows to execute
  call fastqscan.template_task {
    input:
      read1 = read1
      read2 = read2
  }
  output {
    # workflow outputs (output columns in Terra data tables)
     Int read1_total_reads = template_task.read1_total_reads
     Int read2_total_reads = template_task.read2_total_reads
    }
}