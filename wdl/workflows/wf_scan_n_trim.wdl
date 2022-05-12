version 1.0

# import block
import "../tasks/task_fastq_scan.wdl" as fastqsc
import "../tasks/task_trimmomatic.wdl" as trim

workflow scan_n_trim_workflow {
  input {
    # workflow inputs
    File read1
    File read2
  }
  # tasks and/or subworkflows to execute
  call fastqsc.fastq_scan_task {
    input:
      read1 = read1,
      read2 = read2
  }
  call trim.trimmomatic_task {
    input:
      read1 = read1,
      read2 = read2
  }
  call fastqsc.fastq_scan_task as fastq_scan_task_trim{
    input:
      read1 = trimmomatic_task.read1_trimmed,
      read2 = trimmomatic_task.read2_trimmed
  }
  output {
    Int read1_raw_total_reads = fastq_scan_task.scan_results1
    Int read2_raw_total_reads = fastq_scan_task.scan_results2
    Int read1_trimmed_total_reads = fastq_scan_task_trim.scan_results1
    Int read2_trimmed_total_reads = fastq_scan_task_trim.scan_results2
    }
}
