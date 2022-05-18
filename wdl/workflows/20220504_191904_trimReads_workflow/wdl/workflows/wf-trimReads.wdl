version 1.0

# import block
import "../tasks/fqscan.wdl" as fqscan
import "../tasks/trim.wdl" as trim

workflow trimReads_workflow {
  input {
    # workflow inputs
    File fqfile1
    File fqfile2
    Int minlength
    Int window
    Int qual
    
  }
  # tasks and/or subworkflows to execute
  call fqscan.fqscan_task {
    input:
      fqfile1 = fqfile1,
      fqfile2 = fqfile2
  }

  call trim.trim_task {
  	input:
  		fqfile1 = fqfile1,
  		fqfile2 = fqfile2,
		minlength = minlength,
		window = window,
		qual = qual,
		

  }

  call fqscan.fqscan_task as second_fqscan {
	input:
		fqfile1 = trim_task.out1,
		fqfile2 = trim_task.out2

  }

  #output {
    # workflow outputs (output columns in Terra data tables)
    #File outputfile = fastq_scan.outputfile
    #}
}

