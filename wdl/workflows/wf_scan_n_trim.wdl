version 1.0

# import block
import "../tasks/task_fastq_scan.wdl" as fastq_scan
import "../tasks/task_trimmomatic.wdl" as trimmomatic

workflow scan_n_trim_workflow {
  input {
    # workflow inputs
    File read1
    File read2
  }
  # tasks and/or subworkflows to execute
  call fastq_scan.fastq_scan_task as fastq_scan_raw {
    input:
      read1 = read1,
      read2 = read2
  }
  call trimmomatic.trimmomatic_task{
    input:
      read1 = read1,
      read2 = read2
  }
  call fastq_scan.fastq_scan_task as fastq_scan_clean {
    input:
      read1 = trimmomatic_task.read1_trimmed,
      read2 = trimmomatic_task.read2_trimmed
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    String read1_raw_total_reads = fastq_scan_raw.read1_total_reads
    String read2_raw_total_reads = fastq_scan_raw.read2_total_reads
    String read1_clean_total_reads = fastq_scan_clean.read1_total_reads
    String read2_clean_total_reads = fastq_scan_clean.read2_total_reads
  }
}