# Exercise 01: Creating a WDL Workflow

In this exercise, trainees will learn how to write a single-task WDL workflow and how to use miniwdl to run this workflow locally. 

**Exercise Objective**: Create a WDL workflow to capture the total number of reads in a fastq file using fastq-scan. 
- Part 1: Exploring fastq-scan to calculate total numbe of reads in a fastq file
- Part 2: Writing a WDL task and workflow to capture this functionality  

## Part 1 - Exploring FASTQ-SCAN
1. From your training VM, navigate to the training_data directory and launch an interactive docker container using the StaPH-B Docker Image for fastq-scan version 0.4.4: ```docker run --rm -it -v $PWD:/data staphb/fastq-scan:0.4.4```.

2. Use the [fastq-scan documentation](https://github.com/rpetit3/fastq-scan/blob/master/README.md) to write a one-liner that:
    - Calcaultes the total number of reads within a gzipped fastq file and 
    - Writes this value (INT) to a file called `TOTAL_READS`.

<details>
 <summary> Hint & Solution
 </summary><br />
 
 The total number of reads is captured as `qc_stats.read_total` in the `fastq-scan` output json file. Think of ways to parse the fastq-scan output file to capture this value.
 
 Check out the [fastq-scan StaPH-B Docker Builds README.md](https://github.com/StaPH-B/docker-builds/tree/master/fastq-scan/0.4.4) before seeing the final solution!
   <details>
   <summary> Solution 
   </summary> 
   
   One approach could be to concatenate the gzipped fastq file with `zcat`, pipe it into fastq-scan, and then pipe fastq-scan json output into the `jq` tool to query for `qc_stats.read_total`:<br />
   
    $ zcat {read_file} |  fastq-scan | jq .qc_stats.read_total > TOTAL_READS
</details>
</details>

## Part 2 - Writing a WDL Task and Workflow
1. Use the `miniwdl run` command to execute the `hworld` WDL workflow hosted in this repository:<br />
  ` $ miniwdl run ~/wm_training/wdl/workflows/wf_hworld.wdl -i ~/wm_training/data/hworld/hworld_inputs.json`
  
2. Modify the workflow input file (`~/wm_training/data/hworld/hworld_inputs.json`) to print your name, e.g. John Doe.
<details>
 <summary> Solution
 </summary><br />
 
 ```
 $ cat ~/wm_training/wdl/data/hwrold/hworld_inputs.json
 {
  "hworld_workflow.name": "John Doe"
}

</details>

3. Use the WDL workflow and task template files (`~/wm_training/wdl/workflows/wf_template.wdl` & `~/wm_training/wdl/tasks/wf_task.wdl`) to write:
 1. A WDL task for calculating the total number of reads in a zipped fastq file using `fastq-scan`.
 2. A single-task WDL workflow that incorporates the fastq-scan task above