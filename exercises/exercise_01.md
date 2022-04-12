# Exercise 01: Creating a WDL Workflow

In this exercise, trainees will learn how to write a single-task WDL workflow and how to use miniwdl to run this workflow locally. 

**Exercise Objective**: Create a WDL workflow to capture the total number of reads in a fastq file using fastq-scan. 
- Part 1: Exploring fastq-scan to calculate total numbe of reads in a fastq file
- Part 2: Writing a WDL task and workflow to capture this functionality  

## Part 1 - Exploring FASTQ-SCAN
**1.1:** From your training VM, navigate to the training_data directory and launch an interactive docker container using the StaPH-B Docker Image for fastq-scan version 0.4.4: ```docker run --rm -it -v $PWD:/data staphb/fastq-scan:0.4.4```.

**1.2:** Use the [fastq-scan documentation](https://github.com/rpetit3/fastq-scan/blob/master/README.md) to write a one-liner that:
- Calcaultes the total number of reads within a gzipped fastq file and 
- Writes this value (INT) to a file called `TOTAL_READS`

## Part 2 - Writing a WDL Task and Workflow<br />

**2.1:** Use the `miniwdl run` command to execute the `hworld` WDL workflow hosted in this repository:<br />
  ` $ miniwdl run ~/wm_training/wdl/workflows/wf_hworld.wdl -i ~/wm_training/data/hworld/hworld_inputs.json`
  
**2.2:** Modify the workflow input file (`~/wm_training/data/hworld/hworld_inputs.json`) to print your name.

**2.3:** Use the WDL workflow and task template files (`~/wm_training/wdl/workflows/wf_template.wdl` & `~/wm_training/wdl/tasks/wf_task.wdl`) to write:
- A WDL task for calculating the total number of reads in a zipped fastq file using `fastq-scan` 
- A single-task WDL workflow that incorporates the fastq-scan task above


## Hints and Solutions
<details>
 <summary> 1.2 Hint
 </summary><br />
 
 The total number of reads is captured as `qc_stats.read_total` in the `fastq-scan` output json file. Think of ways to parse the fastq-scan output file to capture this value.
 
 Check out the [fastq-scan StaPH-B Docker Builds README.md](https://github.com/StaPH-B/docker-builds/tree/master/fastq-scan/0.4.4) before seeing the final solution!

</details>

<details>
 <summary> 1.2 Solution 
 </summary> 
 <br />    
One approach could be to concatenate the gzipped fastq file with `zcat`, pipe it into fastq-scan, and then pipe fastq-scan json output into the `jq` tool to query for `qc_stats.read_total`:<br />
   
 $ zcat {read_file} |  fastq-scan | jq .qc_stats.read_total > TOTAL_READS

</details>

<details>
 <summary> 2.2 Hint
 </summary><br />
 
 How does the hworld_inputs.json file define the `name` input attribute?

</details>

<details>
  <summary> 2.2 Solution 
   </summary> 
 
```
 $ cat ~/wm_training/wdl/data/hwrold/hworld_inputs.json
 {
  "hworld_workflow.name": "John Doe"
}
```

</details>

<details>
 <summary> 2.3 Hint
 </summary><br />
 
 HINT
  
</details>

<details>
  <summary> 2.2 Solution 
  </summary><br />
  
Check the following files in the [`solutions` branch](https://github.com/theiagen/wm_training/tree/solutions) of this repository: 
    - [`wm_training/wdl/tasks/task_fastq_scan.wdl`](https://github.com/theiagen/wm_training/blob/solutions/wdl/tasks/task_fastq_scan.wdl)
    - [`wm_training/wdl/workflows/wf_fastq_scan.wdl`](https://github.com/theiagen/wm_training/blob/solutions/wdl/workflows/wf_fastq_scan.wdl)

</details>
