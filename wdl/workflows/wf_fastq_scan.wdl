version 1.0

# import block
import "../tasks/task_fastq_scan.wdl" as fastq_scan

workflow fastq_scan_workflow {
  input {
    # workflow inputs
    File read1
    File read2
  }
  # tasks and/or subworkflows to execute
  call fastq_scan.fastq_scan_task {
    input:
      read1 = read1,
      read2 = read2
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    String read1_total_reads = fastq_scan_task.read1_total_reads
    String read2_total_reads = fastq_scan_task.read2_total_reads
  }
}