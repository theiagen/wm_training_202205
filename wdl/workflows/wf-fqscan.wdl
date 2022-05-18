version 1.0

# import block
import "../tasks/fqscan.wdl" as fqscan

workflow fqscan_workflow {
  input {
    # workflow inputs
    File fqfile1
    File fqfile2
  }
  # tasks and/or subworkflows to execute
  call fqscan.fastq_scan {
    input:
      fqfile1 = fqfile1,
      fqfile2 = fqfile2
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    File outputfile = fastq_scan.outputfile 
    }
}
