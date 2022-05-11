version 1.0

# import block
import "../tasks/task_trimmomatic.wdl" as trimmomatic
import "../tasks/task_fastqscan.wdl" as fastqscan

workflow scantrim_workflow {
  input {
    # workflow inputs
    File read1
    File read2
  }
  # tasks and/or subworkflows to execute
  call fastqscan.fastqscan_task as first_fastqscan {
    input:
      read1 = read1,
      read2 = read2
  }
  # tasks and/or subworkflows to execute
  call trimmomatic.trimmomatic_task {
    input:
      read1 = read1,
      read2 = read2
  }
  # tasks and/or subworkflows to execute
  call fastqscan.fastqscan_task as second_fastqscan {
    input:
      read1 = trimmomatic_task.read1_trimmed,
      read2 = trimmomatic_task.read2_trimmed
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    Int read1_raw = first_fastqscan.read1_total_reads
    Int read2_raw = first_fastqscan.read2_total_reads
    Int read1_trimmed = second_fastqscan.read1_total_reads
    Int read2_trimmed = second_fastqscan.read2_total_reads
    }
}