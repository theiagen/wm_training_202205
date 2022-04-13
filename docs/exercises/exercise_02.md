# Exercise 02: Multi-Task WDL Workflows

In this exercise, trainees will learn how to chain multiple tasks in a single WDL workflow. 

**Exercise Objective**: Create a WDL workflow to capture the total number of reads in a fastq file using fastq-scan. 
- Part 1: Exploring the foo-bar_workflow to understand task interactions within a WDL workflow
- Part 2: Writing a WDL task for `trimmomatic` and a workflow to calculate total reads before and after read trimming

## Part 1 - Exploring the FOO-BAR WDL Workflow
**1.1:** If the `foo_task` multiplies `some_number` by `3` and the `bar_task` subtracts `25` from `some_number`, what will the outputs of the `foobar_workflow` be if `some_number` = `5`?

```
version 1.0

# import block
import "../tasks/task_foo.wdl" as foo
import "../tasks/task_bar.wdl" as bar


workflow foobar_workflow {
  input {
    # workflow inputs
    Int some_number
  }
  # tasks and/or subworkflows to execute
  call foo.foo_task {
    input:
      some_number = some_number
  }
  call bar.bar_task {
    input:
      some_number = foo_task.foo_number
  }
  call foo.foo_task as second_foo_task {
    input:
      some_number = bar_task.bar_number
  }
  output {
    # workflow outputs (output columns in Terra data tables)
    Int foo_number = foo_task.foo_number
    Int bar_number = bar_task.bar_number
    Int second_foo_number = second_foo_task.foo_number
  }
}
```

-  Use the `miniwdl run` command to execute the `foobar` WDL workflow hosted in this repository:<br />
  `$ miniwdl run ~/wm_training/wdl/workflows/wf_foobar.wdl -i ~/wm_training/data/exercise_02/foobar_inputs.json`

## Hints and Solutions
<details>
 <summary> 1.2 Hint
 </summary><br />
 
 The total number of reads is captured as `qc_stats.read_total` in the `fastq-scan` output json file. Think of ways to parse the fastq-scan output file to capture this value.
 
 Check out the [fastq-scan StaPH-B Docker Builds README.md](https://github.com/StaPH-B/docker-builds/tree/master/fastq-scan/0.4.4) before seeing the final solution!

</details>

<details>
 <summary> 1.2 Solution 
 </summary><br />   

One approach could be to concatenate the gzipped fastq file with `zcat`, pipe it into fastq-scan, and then pipe fastq-scan json output into the `jq` tool to query for `qc_stats.read_total`:<br />
   
`$ zcat {read_file} |  fastq-scan | jq .qc_stats.read_total > TOTAL_READS`

</details>

<details>
 <summary> 2.2 Hint
 </summary><br />
 
 How does the hworld_inputs.json file define the `name` input attribute?

</details>

<details>
  <summary> 2.2 Solution 
   </summary><br />

   By modifying the string `"Kevin G. Libuit"` the input file can be modified to print any name, *e.g.*:<br />

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
 
Here's a potential start to  `task_fastq_scan.wdl` file:

```
task fastq_scan_task {
  meta {
    # task metadata
    description: "Task to run fastq_scan"
  }
  input {
    # task inputs
    File read1
    File read2
    String docker = "staphb/fastq-scan:0.4.4"
    Int cpu = 2
    Int memory = 2
  }
```

With these input attributes, how can we construct a `command` block to execute the appropriate `fastq-scan` command? What information needs to be defined in the `runtime` block?

</details>

<details>
  <summary> 2.3 Solution 
  </summary><br />
  
Check the following files in the [`solutions` branch](https://github.com/theiagen/wm_training/tree/solutions) of this repository: 
    - [`wm_training/wdl/tasks/task_fastq_scan.wdl`](https://github.com/theiagen/wm_training/blob/solutions/wdl/tasks/task_fastq_scan.wdl)
    - [`wm_training/wdl/workflows/wf_fastq_scan.wdl`](https://github.com/theiagen/wm_training/blob/solutions/wdl/workflows/wf_fastq_scan.wdl)

</details>