version 1.0

# import block
import "../tasks/fastq-scan_task.wdl" as fqscan
import "../tasks/trimmomatic_task.wdl" as trim

workflow template_workflow {
  input {
    # workflow inputs
    File read1
    File read2
  }
  # tasks and/or subworkflows to execute
  call fqscan.fqscan_task as fqscan_raw {
    input:
      read1 = read1,
      read2 = read2
  }
  call trim.trimmomatic_task {
    input:
      read1 = read1,
      read2 = read2
  }
  call fqscan.fqscan_task as fqscan_trimmed {
    input:
      read1 = trimmomatic_task.paired_1,
      read2 = trimmomatic_task.paired_2
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    Int r1_reads_raw = fqscan_raw.r1_reads
    Int r2_reads_raw = fqscan_raw.r2_reads
    Int r1_reads_trimmed = fqscan_trimmed.r1_reads
    Int r2_reads_trimmed = fqscan_trimmed.r2_reads
    }
}