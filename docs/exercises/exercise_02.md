# Exercise 02: Multi-Task WDL Workflows

In this exercise, trainees will learn how to chain multiple tasks in a single WDL workflow. 

**Exercise Objective**: Create a WDL workflow that calculates the total number of reads in a fastq file before and after read trimming. 
- Part 1: Exploring the foo-bar_workflow to understand task interactions within a WDL workflow
- Part 2: Writing a multi-task WDL workflow with `trimmomatic` and `fastq-scan`

## Part 1 - Exploring the FOO-BAR WDL Workflow
**1.1:** If the `foo_task` multiplies `some_number` by `3` and the `bar_task` subtracts `25` from `some_number`, what will the workflow outputs of the `foobar_workflow` be if `some_number` = `5`?

- `foo_number`: ____
- `bar_number`: ____
- `second_foo_number`: ____

```
$ cat wm_training/wdl/workflows/wf_foobar.wdl 
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

## Part 2 - Writing a Multi-Task WDL workflow
**2.1:** From your training VM, launch an interactive docker container using the StaPH-B Docker Image for trimmomatic version 0.39: `docker run --rm -it -v ~/wm_training/data/:/data staphb/trimmomatic:0.39`.

**2.2:** Use the [trimmomatic documentation](http://www.usadellab.org/cms/?page=trimmomatic) to write a `trimmomatic_task` file that trims paired-end read data; `minlen`, `window_size`, and `required_quality` should be modifiable input attributes (default: `minen` = `75`, `window_size` = `10`, `required_quality` = `20`)

**2.3:** Use the WDL workflow and task template files (`~/wm_training/wdl/workflows/wf_template.wdl` & `~/wm_training/wdl/tasks/wf_task.wdl`) to write a multi-task WDL workflow that takes in paired-end fastq files (`read1` & `read2`) and uses `fastq-scan` and `trimmomatic` to calcaulte the total paired reads within each fastq file before and after read tirmming:

<p align="center">
  <img src="../images/scan-n-trim_workflow.png" width="800" class="center">
</p>

## Hints and Solutions
<details>
 <summary> 1.1 Hint
 </summary><br />
 
 Use the `miniwdl run` command to execute the `foobar` WDL workflow hosted in this repository to find out:<br />

   `$ miniwdl run ~/wm_training/wdl/workflows/wf_foobar.wdl -i ~/wm_training/data/exercise_02/foobar_inputs.json`

</details>

<details>
 <summary> 1.1 Solution 
 </summary><br />   

If `some_number` = `5`:
 - `foo_number` = `5 * 3` = `15`
 - `bar_number` = `15 - 25` = `-10`
 - `second_foo_number`: = `-10 * 3` = `-30`

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
