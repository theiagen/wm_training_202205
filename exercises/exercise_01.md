# Exercise 01: Creating a WDL Workflow

In this exercise, trainees will learn how to write a single-task WDL workflow and how to use miniwdl to run this workflow locally. 

**Exercise Objective**: Create a WDL workflow to capture the total number of reads in a fastq file using fastq-scan. 
- Part 1: Exploring fastq-scan to calculate total numbe of reads in a fastq file
- Part 2: Writing a WDL task and workflow to capture this functionality  

## Part 1 - Exploring FASTQ-SCAN
1. From your training VM, navigate to the training_data directory and launch an interactive docker container using the StaPH-B Docker Image for fastq-scan version 0.4.4: ```docker run --rm -it -v $PWD:/data staphb/fastq-scan:0.4.4```.
2. Use the [fastq-scan documentation](https://github.com/rpetit3/fastq-scan/blob/master/README.md) to write a one-liner that:
    - Calcaultes the total number of reads within a fastq file and 
    - Writes this value (INT) to a file called `TOTAL_READS`.

<details>
 <summary> Hint & Solution
 </summary><br />
 
 The total number of reads is captured as `qc_stats.read_total` in the `fastq-scan` output json file. 
 Think of ways to parse the fastq-scan output file to capture this value!
 
 Check out the [StaPH-B fastq-scan Dockerfile](https://github.com/StaPH-B/docker-builds/tree/master/fastq-scan/0.4.4) before seeing the final solution.
   <details>
   <summary> Solution 
   </summary> 
   
   One approach could be to concatenate the read file, pipe it into fastq-scan, and then pipe fastq-scan output into the `jq` tool to query the json output for `qc_stats.read_total`:<br />
   
    $ cat {read_file} |  fastq-scan | jq .qc_stats.read_total > TOTAL_READS
</details>
</details>

