# Nextflow 

In this exercise we'll be getting an introduction into Conda and Nextflow. 

## Exercise 1 - Conda

When installing the [Conda](https://conda.io/)
package manager you have two options, [Anaconda](https://www.anaconda.com/products/distribution)
or [Miniconda](https://conda.io/miniconda.html). Anaconda comes with a lot of
pre-installed packages and Miniconda comes with the bare necessities. For our purposes,
we'll be using Miniconda, so lets get it installed.

---

### Install Miniconda3

First things first, let's get Miniconda installed. _A link is used in the below code_, but for 
future reference you can always get links to the available
[Miniconda - Installers](https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links).
Today, since we are on a Linux VM, we will be installing the `Miniconda3 Linux 64-bit` version. 

```{bash}
# Download Miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Run installer
bash Miniconda3-latest-Linux-x86_64.sh

# >>> In order to continue the installation process, please review the license
# >>> agreement.
# >>> Please, press ENTER to continue
# Press <enter> here to read the license
# 
# >>> ... <LICENSE> ...
# 
# >>> Do you accept the license terms? [yes|no]
# Type 'yes' (without quotes) to accept the license
# >>> ...
# >>>  - Press ENTER to confirm the location
# >>>  - Press CTRL-C to abort the installation
# >>>  - Or specify a different location below
# >>>
# >>> [/home/rpetit/miniconda3] >>>
# Press <enter> to install to the default location
# 
# ... Installation and setup will happen ...
# 
# >>> installation finished.
# >>> Do you wish the installer to initialize Miniconda3
# >>> by running conda init? [yes|no]
# Type 'yes' (without quotes) to initialize Miniconda
# 
# >>> Thank you for installing Miniconda3!
source ~/.bashrc
```

If everything was successful, you should now have `(base)` at the start of your command line:
```{bash}
(base) rpetit@rpetit-training:~$ 
```

Now everytime you login or create a new shell, the `base` environment will be activated and you
will be able to use `conda`.

---

### Conda Rules of Thumb
Its no secret, Conda can be quite sensitive to change. In order to keep Conda happy, try to follow the following rules. By following these, Conda will stay happy, which means you will too!

__Rule Number 1 - Keep `base` clean__  
Keep your base environment clean! Try to avoid installing anything in your `base` environment (_there are a few exceptions!_). If your `base` environment breaks, you have to reinstall Miniconda. 

_There is an exception to this rule of thumb though!_

__Rule Number 2 - Create enviroments__  
`conda create` is your friend, use it for everything! Treat environments as consumables, create them, install in them, delete them.  

__Rule Number 3 - Use Mamba__  
Install [Mamba](https://github.com/mamba-org/mamba) into your `base` environment. Mamba is one of the exceptions, go ahead and install it in your `base` environment. Mamaba is a drop in replacement for Conda and its much, much, much faster!   

_Note: There are efforts to begin integrating Mamba into Conda, but as of [Conda v4.12](https://github.com/conda/conda/releases/tag/4.12.0) this is still an experimental feature._  

__Rule Number 4 - Use containers for critical tasks__
Conda is great, but for critical things its best to use containers (Docker or Singularity). Containers are static and 
once built you know exactly what it contains. When installing packages through Conda dependencies are selected at the
time of installation. Therefore if you install something today, then again in 6 months, you are likely to get different
tool versions.

---

### Installing `mamba`

Well here I am telling you not to install anything in your `base` environment, and immeadiately
we'll be installing `mamba` in your `base` environment! [Mamba](https://github.com/mamba-org/mamba)
is a _drop in replacement_ for Conda. Everything you can do with Conda you can do with Mamba,
except so much faster!

Although for most cases the Conda solver is sufficient, but there are some cases where it can take
hours or even days! Mamba on the other hand will take seconds!

So let's get `mamba` installed:
```{bash}
# While in the (base) environment
conda install -y -c conda-forge mamba
```

- `-y`: means to tell Conda 'yes' to everything
- `-c conda-forge`: tells Conda to search the `conda-forge` channel for `mamba`

Once completed, you can verify `mamba` is installed:
```{bash}
mamba --version
mamba 0.15.3
conda 4.12.0
```

_Note: You might have different versions that what appears above._

---

### Create a new `shigatyper` environment

When working with Conda, its a good practice to liberally create a new envrionments. These
environments are essentially disposable, and when you are done with them you can just delete
them. Another important aspect of environments is they do not interfere with one another.

Today we'll be creating a new environment for [ShigaTyper](https://github.com/CFSAN-Biostatistics/shigatyper),
a tools for serotyping Shigella genomes. ShigaTyper supports reads from Illumina (paired and single-end)
as well as Oxford Nanopore.

So, lets create a new environment:
```{bash}
mamba create -n shigatyper -c conda-forge -c bioconda shigatyper
```

Notice here we are using `conda create`, which will create a new environment instead of installing
packages in the current environment.

- `-n`: Used to name the Conda environment
- `-c conda-forge -c bioconda`: Tells Conda to search `conda-forge` then `bioconda` for ShigaTyper

_Note: the channel order is enforced on all dependencies_

After installation we can now activate the `shigatyper` environment and check the version

```{bash}
conda activate shigatyper
shigatyper --version
ShigaTyper 2.0.0
```

Here `activate` tells Conda to move out of the `base` environment and into the specified
environment.

You can use `conda env list` to available environments:
```{bash}
conda env list
# conda environments:
#
base                     /home/rpetit/miniconda3
shigatyper            *  /home/rpetit/miniconda3/envs/shigatyper
```

You can also use `conda env export` to get a list of packages and versions installed in the 
current environment:
```{bash}
conda env export
name: shigatyper
channels:
  - bioconda
  - conda-forge
  - defaults
dependencies:
  - _libgcc_mutex=0.1=conda_forge
  - _openmp_mutex=4.5=2_gnu
  - bcftools=1.15.1=h0ea216a_0
  - bzip2=1.0.8=h7f98852_4
  - c-ares=1.18.1=h7f98852_0
  - ca-certificates=2022.5.18.1=ha878542_0
  - gsl=2.7=he838d99_0
  - htslib=1.15.1=h9753748_0
  - k8=0.2.5=hd03093a_2
  - keyutils=1.6.1=h166bdaf_0
  - krb5=1.19.3=h3790be6_0
  - ld_impl_linux-64=2.36.1=hea4e1c9_2
  - libblas=3.9.0=14_linux64_openblas
  - libcblas=3.9.0=14_linux64_openblas
  - libcurl=7.83.1=h7bff187_0
  - libdeflate=1.10=h7f98852_0
  - libedit=3.1.20191231=he28a2e2_2
  - libev=4.33=h516909a_1
  - libffi=3.4.2=h7f98852_5
  - libgcc-ng=12.1.0=h8d9b700_16
  - libgfortran-ng=12.1.0=h69a702a_16
  - libgfortran5=12.1.0=hdcd56e2_16
  - libgomp=12.1.0=h8d9b700_16
  - liblapack=3.9.0=14_linux64_openblas
  - libnghttp2=1.47.0=h727a467_0
  - libnsl=2.0.0=h7f98852_0
  - libopenblas=0.3.20=pthreads_h78a6416_0
  - libssh2=1.10.0=ha56f1ee_2
  - libstdcxx-ng=12.1.0=ha89aaad_16
  - libuuid=2.32.1=h7f98852_1000
  - libzlib=1.2.11=h166bdaf_1014
  - minimap2=2.24=h7132678_1
  - ncurses=6.3=h27087fc_1
  - numpy=1.22.3=py310h4ef5377_2
  - openssl=1.1.1o=h166bdaf_0
  - pandas=1.4.2=py310h769672d_1
  - perl=5.32.1=2_h7f98852_perl5
  - pip=22.1.1=pyhd8ed1ab_0
  - python=3.10.4=h9a8a25e_0_cpython
  - python-dateutil=2.8.2=pyhd8ed1ab_0
  - python_abi=3.10=2_cp310
  - pytz=2022.1=pyhd8ed1ab_0
  - readline=8.1=h46c0cb4_0
  - samtools=1.15.1=h1170115_0
  - setuptools=62.3.2=py310hff52083_0
  - shigatyper=2.0.1=pyhdfd78af_0
  - six=1.16.0=pyh6c4a22f_0
  - sqlite=3.38.5=h4ff8645_0
  - tk=8.6.12=h27826a3_0
  - tzdata=2022a=h191b570_0
  - wheel=0.37.1=pyhd8ed1ab_0
  - xz=5.2.5=h516909a_1
  - zlib=1.2.11=h166bdaf_1014
prefix: /home/rpetit/miniconda3/envs/shigatyper
```

---

### Run ShigaTyper

Let's give ShigaTyper a try.

I maintain a repository of test data over at [bactopia-tests](https://github.com/bactopia/bactopia-tests). So lets grab some, to give ShigaTyper a test run:
```{bash}
mkdir shigatyper-test
cd shigatyper-test
wget https://github.com/bactopia/bactopia-tests/raw/main/data/species/shigella_dysenteriae/nanopore/SRR13039589.fastq.gz
wget https://github.com/bactopia/bactopia-tests/raw/main/data/species/shigella_dysenteriae/illumina/ERR6005894SE.fastq.gz
wget https://github.com/bactopia/bactopia-tests/raw/main/data/species/shigella_dysenteriae/illumina/ERR6005894_R1.fastq.gz
wget https://github.com/bactopia/bactopia-tests/raw/main/data/species/shigella_dysenteriae/illumina/ERR6005894_R2.fastq.gz
```

Once downloads have completed you will have the following:
```{bash}
ls -lh
-rw-rw-r-- 1 rpetit rpetit 4.3M May 22 21:58 ERR6005894SE.fastq.gz
-rw-rw-r-- 1 rpetit rpetit 2.2M May 22 21:58 ERR6005894_R1.fastq.gz
-rw-rw-r-- 1 rpetit rpetit 2.1M May 22 21:58 ERR6005894_R2.fastq.gz
-rw-rw-r-- 1 rpetit rpetit 4.6M May 22 21:58 SRR13039589.fastq.gz
```

Let's see how ShigaTyper works:
```
shigatyper --help
usage: shigatyper [-h] [--R1 FASTA] [--R2 FASTA] [--SE FASTA] [--ont] [-n SAMPLE_NAME] [--verbose] [--version]

... TRUNCATED ...

options:
  -h, --help            show this help message and exit
  --R1 FASTA            Input FASTQ is R1 of paired-end reads
  --R2 FASTA            Input FASTQ is R2 of paired-end reads
  --SE FASTA            Input FASTQ is contains single-end reads
  --ont                 The input FASTQ file contains ONT reads
  -n SAMPLE_NAME, --name SAMPLE_NAME
  --verbose, -v
  --version             show program's version number and exit
```

Looks pretty straightforward:

- `--R1` and `--R2` for paired-end Illumina reads
- `--SE` for single-end Illumina reads
- `--SE` and `--ont` for Nanopore reads

Here, I'll demonstrate how to do it for paired-end reads:
```{bash}
shigatyper --R1 ERR6005894_R1.fastq.gz --R2 ERR6005894_R2.fastq.gz 2> /dev/null
        Hit     Number of reads Length Covered  reference length        % covered       Number of variants      % accuracy
0       ipaH_c  31      574     780     73.6    0.0     100.0
1       ipaB    22      1015    1743    58.2    0.0     100.0
2       SdProv_wzx      16      1017    1320    77.0    0.0     100.0
3       SdProv_wzy      53      1104    1212    91.1    0.0     100.0
sample  prediction      ipaB    notes
ERR6005894      Shigella dysenteriae Provisional serotype 96-265        +       this strain is ipaB+, suggesting that it retains the virulent invasion plasmid.
```

It appears `ERR6005894` is `Shigella dysenteriae Provisional serotype 96-265`.

Go ahead and try running the single-end reads and the Nanopore reads through ShigaTyper. You
might even be interested in running your own genomes through! 


---

# Remove the `shigatyper` environment

Once you think you are all ShigaTyped out, we can shut things down!

In order to exit an environment you must `deactivate` it, like so:
```{bash}
conda deactivate
```

_Note: You don't have to specify the environment name with `deactivate`_

And if you are completely ShigaTyped out, you can even remove the `shigatyper` environment, like so:
```{bash}
conda env remove -n shigatyper

Remove all packages in environment /home/rpetit/miniconda3/envs/shigatyper:

# Verify its gone
conda env list
# conda environments:
#
base                  *  /home/rpetit/miniconda3
```

With that, you can rapidly create new environments, run tools, and remove environments.

---

### Additional Exercises

If you are feeling adventurous, you can keep playing around with Conda. Head on over to
[Bioconda](https://bioconda.github.io/), and use the search function to find a tool you are
interested in trying.

Examples: `shovill`, `prokka`, `dragonflye`, `seqsero2`, so many to choose from!

---

## Exercise 2 - Nextflow Introduction

OK! Hopefully you didn't skip Exercise 1, because we'll be using Conda again! In this exercise
you will be getting an introduction into [Nextflow](https://www.nextflow.io/). Nextflow is both
a language and workflow manager.

For this exercise the goal is to:

1. Create a `nextflow` environment
2. Execute "Hello World"
3. Execute [Bactopia](https://bactopia.github.io/) and/or [nf-core](https://nf-co.re/) test pipelines
4. Browse Nextflow outputs

Let's get started

---

### Create a `nextflow` environment

In the previous exercise we made a environment for ShigaTyper, this time will do the same except for Nextflow:
```{bash}
mamba create -y -n nextflow -c conda-forge -c bioconda nextflow
conda activate nextflow
nextflow -version

      N E X T F L O W
      version 22.04.0 build 5697
      created 23-04-2022 18:00 UTC 
      cite doi:10.1038/nbt.3820
      http://nextflow.io

```

Based on this, Nextflow v22.04.0 was installed in my `nextflow` environment. This is actually important, 
because [v22.04.0](https://github.com/nextflow-io/nextflow/releases/tag/v22.04.0) was the first non-edge version to default to using [DSL2](https://www.nextflow.io/docs/edge/dsl2.html).

We have Nextflow installed, time to test it out with a _Hello world_ example

---

### Execute "Hello World"

A convenient of Nextflow is that you can provide it an address to a GitHub repo and Nextflow will
execute any existing workflows. Let's give it a try with [nextflow-io/hello](https://github.com/nextflow-io/hello).

```{bash}
nextflow run nextflow-io/hello
N E X T F L O W  ~  version 22.04.0
Pulling nextflow-io/hello ...
 downloaded from https://github.com/nextflow-io/hello.git
Launching `https://github.com/nextflow-io/hello` [berserk_koch] DSL2 - revision: 4eab81bd42 [master]
executor >  local (4)
[56/962938] process > sayHello (4) [100%] 4 of 4 ✔
Ciao world!

Hello world!

Bonjour world!

Hola world!

```

And just like that you've just executed a Nextflow pipeline! 

If we take a look at the folder contents you'll have a few new folders and files:
```{bash}
drwxrwxr-x  4 rpetit rpetit 4.0K May 22 22:40 .nextflow
-rw-rw-r--  1 rpetit rpetit 7.2K May 22 22:40 .nextflow.log
drwxrwxr-x  6 rpetit rpetit 4.0K May 22 22:40 work
```

#### `.nextflow` Folder
The `.nextflow` folder is created by Nextflow to keep Nextflow related files. These files are
really only meant for Nextflow and used for things like caching and locking. I've been using
Nextflow for years and have never had a need to mess with any files in the `.nextflow` folder.

Once you've completed your Nextflow run, it is ok to delete the `.nextflow` folder. But please
keep in mind if you delete it you will no longer be able to resume (`-resume`) previous runs. So,
make sure you are actually done!

#### `.nextflow.log` File
The [.nextflow.log](https://www.nextflow.io/docs/edge/tracing.html#execution-log) contains all
sorts of logging information output by Nextflow. It can be quite
useful to sift through when things aren't working out like you expect them to. In this `.nextflow.log`
file you can see which [config files were loaded](https://www.nextflow.io/docs/edge/config.html)
and in what order, which [executor](https://www.nextflow.io/docs/edge/executor.html) was used, any
errors that might have occured, and many many more details.

#### `work` folder
The `work` folder is where all the Nextflow processes are executed. For each job Nextflow executes
a new folder is created in the `work` directory. This allows jobs to be executed in isolation and
not be affected by other jobs. 

But, the `work` directory is rather infamous for expanding to great sizes. For every job, the inputs
and outputs are staged in the work directory. As you might imagine, if you are using rather large 
input FASTQ files they are going to make the `work` directory grow rather large!

Once you've completed your Nextflow run, it is ok to delete the `work` folder. But please
keep in mind if you delete it you will no longer be able to resume (`-resume`) previous runs. So,
make sure you are actually done!

---

### Execute Bactopia and/or nf-core

This time around we're going to execute real pipelines. In the below example, I'm going to use
[Bactopia](https://bactopia.github.io/) due to experience using it over the years. But, please
don't hesitate to use some of the popular [nf-core pipelines](https://nf-co.re/pipelines). 

You see nf-core practices require that a `test` profile exist to allow users to rapidly test
a pipeline. We can take advantage of that now!

```{bash}
# Run Bactopia
nextflow run bactopia/bactopia -profile test,docker

# Run nf-core/rnaseq
nextflow run nf-core/rnaseq -profile test,docker

# Run nf-core/<INSERT_PIPELINE_NAME_HERE>
nextflow run nf-core//<INSERT_PIPELINE_NAME_HERE> -profile test,docker
```

Let's go ahead and break down `-profile test,docker`

- `-profile`: Is a Nextflow parameter to tell Nextflow which profiles to use
- `test`: Is a profile that is configured with test data ([Bactopia](https://github.com/bactopia/bactopia/blob/master/conf/profiles/test.config), [nf-core/rnaseq](https://github.com/nf-core/rnaseq/blob/master/conf/test.config))
- `docker`: Is a profile for using Docker with Nextflow ([Bactopia](https://github.com/bactopia/bactopia/blob/master/conf/profiles/docker.config), [nf-core/rnaseq](https://github.com/nf-core/rnaseq/blob/master/nextflow.config#L146-L153))


Ok let's run one! Again, I'm running Bactopia, but feel free to run nf-core/rnaseq if you like! There should be strong 
similarities between Bactopia and nf-core pipelines.

```{bash}
nextflow run bactopia/bactopia -profile test,docker
N E X T F L O W  ~  version 22.04.0
Launching `https://github.com/bactopia/bactopia` [zen_cray] DSL2 - revision: ed19d6c279 [master]


---------------------------------------------
   _                _              _             
  | |__   __ _  ___| |_ ___  _ __ (_) __ _       
  | '_ \ / _` |/ __| __/ _ \| '_ \| |/ _` |   
  | |_) | (_| | (__| || (_) | |_) | | (_| |      
  |_.__/ \__,_|\___|\__\___/| .__/|_|\__,_| 
                            |_|                  
  bactopia v2.0.3
  Bactopia is a flexible pipeline for complete analysis of bacterial genomes. 
---------------------------------------------
Core Nextflow options
  revision         : master
  runName          : zen_cray
  containerEngine  : docker
  container        : quay.io/bactopia/bactopia:2.0.3
  launchDir        : /home/rpetit/shigatyper-test
  workDir          : /home/rpetit/shigatyper-test/work
  projectDir       : /home/rpetit/.nextflow/assets/bactopia/bactopia
  userName         : rpetit
  profile          : test,docker
  configFiles      : /home/rpetit/.nextflow/assets/bactopia/bactopia/nextflow.config

Required Parameters
  R1               : https://github.com/bactopia/bactopia-tests/raw/main/data/species/portiera/illumina/SRR2838702_R1.fastq.gz
  R2               : https://github.com/bactopia/bactopia-tests/raw/main/data/species/portiera/illumina/SRR2838702_R2.fastq.gz
  sample           : SRR2838702

Dataset Parameters
  genome_size      : 358242

Max Job Request Parameters
  max_cpus         : 2
  max_memory       : 6

Nextflow Profile Parameters
  condadir         : /home/rpetit/.nextflow/assets/bactopia/bactopia/conda/envs
  registry         : quay
  singularity_cache: /home/rpetit/.bactopia/singularity

!! Only displaying parameters that differ from the pipeline defaults !!
--------------------------------------------------------------------
If you use bactopia for your analysis please cite:

* Bactopia
  https://doi.org/10.1128/mSystems.00190-20

* The nf-core framework
  https://doi.org/10.1038/s41587-020-0439-x

* Software dependencies
  https://bactopia.github.io/acknowledgements/
--------------------------------------------------------------------
executor >  local (7)
[2f/98d4e7] process > BACTOPIA:GATHER_SAMPLES (SRR2838702)     [100%] 1 of 1 ✔
[99/fe5614] process > BACTOPIA:QC_READS (SRR2838702)           [100%] 1 of 1 ✔
[a7/4923be] process > BACTOPIA:ASSEMBLE_GENOME (SRR2838702)    [100%] 1 of 1 ✔
[13/3977a5] process > BACTOPIA:ASSEMBLY_QC (SRR2838702)        [100%] 1 of 1 ✔
[d0/7a6f09] process > BACTOPIA:ANNOTATE_GENOME (SRR2838702)    [100%] 1 of 1 ✔
[f9/df1a78] process > BACTOPIA:MINMER_SKETCH (SRR2838702)      [100%] 1 of 1 ✔
[-        ] process > BACTOPIA:ANTIMICROBIAL_RESISTANCE        -
[-        ] process > BACTOPIA:ARIBA_ANALYSIS                  -
[-        ] process > BACTOPIA:MINMER_QUERY                    -
[-        ] process > BACTOPIA:BLAST                           -
[-        ] process > BACTOPIA:CALL_VARIANTS                   -
[-        ] process > BACTOPIA:MAPPING_QUERY                   -
[-        ] process > BACTOPIA:SEQUENCE_TYPE                   -
[1c/7ca933] process > BACTOPIA:CUSTOM_DUMPSOFTWAREVERSIONS (1) [100%] 1 of 1 ✔

    Bactopia Execution Summary
    ---------------------------
    Bactopia Version : 2.0.3
    Nextflow Version : 22.04.0
    Command Line     : nextflow run bactopia/bactopia -profile test,docker
    Resumed          : false
    Completed At     : 2022-05-22T23:14:59.473537Z
    Duration         : 7m 20s
    Success          : true
    Exit Code        : 0
    Error Report     : -
    Launch Dir       : /home/rpetit/shigatyper-test
    
WARN: To render the execution DAG in the required format it is required to install Graphviz -- See http://www.graphviz.org for more info.
Completed at: 22-May-2022 23:15:00
Duration    : 7m 21s
CPU hours   : 0.1
Succeeded   : 7
```

Fun stuff, took ~7 minutes to complete! You've just quickly verified a pipeline is working for you!
Even better it'll probably run even faster next time because much of the time was devoted to pulling 
the docker containers.

#### Additional Nextflow Files

##### Nextflow's Execution Report
Many pipelines will output a Nextflow [Execution Report](https://www.nextflow.io/docs/edge/tracing.html#execution-report).
Which is an HTML report that provides summary details about your Nextflow execution. This file can actually be super useful
for optimizing your resource usage.

##### Nextflow's Trace Report
The Nextflow [Trace Report](https://www.nextflow.io/docs/edge/tracing.html#trace-report) is a tabular file
containing trace information for each executed process. There are 20+ fields with information such as disk usage,
memory usage, and runtime. 

##### Nextflow's Timeline Report
The Nextflow [Timeline Report](https://www.nextflow.io/docs/edge/tracing.html#timeline-report) is a HTML file
which as a nice representation of how long processes took. This report can be useful to see if processes took 
longer than expected.

##### Nextflow's DAG
If [Graphviz](https://graphviz.org/) is installed Nextflow can render a 
[direct acyclic graph (DAG)](https://www.nextflow.io/docs/edge/tracing.html#dag-visualisation) which provides a
visualization of the how channels and processes are all linked together in a Nextflow pipeline.

Before moving to the next exercise, please take a little while to explore the output files from our test runs. 

---

## Exercise 3 - Nextflow Channels and Processes

The basic units of Nextflow are [Channels](https://www.nextflow.io/docs/latest/channel.html) and
[Processes](https://www.nextflow.io/docs/latest/process.html). 

A Channel holds the data that is passed between Processes or transformed using 
[Operators](https://www.nextflow.io/docs/latest/operator.html#). There are more than 50 Operators
available to manipulate Nextflow Channels.

A Process is used to execute user scripts. This is where the tools and code are executed.

Here is the basic structure of a Nextflow Process
```
process < name > {

   [ directives ]

   input:
    < process inputs >

   output:
    < process outputs >

   when:
    < condition >

   [script|shell|exec]:
   < user script to be executed >
}
```

- `< name >`: A name to refere to the process by
- `[ directives ]`: [30+ options](https://www.nextflow.io/docs/edge/process.html#directives) to tweak the process
- `< process inputs >`: input Channels to be consumed by the Process
- `< process outputs >`: output Channels to be emitted by the Process
- `when`: Allows the processes to be executed based on a condition
- `[script|shell|exec]`: Where you put the tools and code you would like to execute

---

### Channel Operators

A Nextflow script named [exercise_03/nextflow_ex1.nf](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_03/nextflow_ex1.nf)
was put together to demonstrate how Operators can be used on Nextflow Channels.

In this example, not processes are be executed. Instead we are generating Channels, applying Operators, then
printing the contents of the Channel.

You can use `nextflow run` to execute the script. Here's an example execution:

```{bash}
nextflow run ~/wm_training/nextflow/exercise_03/nextflow_ex1.nf 
N E X T F L O W  ~  version 22.04.0
Launching `/home/rpetit/wm_training/nextflow/exercise_03/nextflow_ex1.nf` [stoic_perlman] DSL2 - revision: ce7fde1d53
1
2
.toList(): [1, 2, 3, 4, 5]
.min(): 1
3
4
Output of .count(): 5
5
.sum(): 15
Square of: 1 is 1
Square of: 2 is 4
Square of: 3 is 9
.randomSample(): 3
.randomSample(): 4
Square of: 4 is 16
Square of: 5 is 25
```

For this example, try running it a few times. Are the outputs in the same order or different each time?

After executing it a few times, try changing things in the script to see what happens. For example, try using
the `max()` Operator. There are more than [50 Operators](https://www.nextflow.io/docs/latest/operator.html#) you can give a go.

---

### Channels and Processes

Once you are all Operatored out, let's take a look at [exercise_03/nextflow_ex2.nf](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_03/nextflow_ex2.nf).

In this exercise we'll be introduced to the _first in, first out_ (FIFO) nature of Channels.

Basically we've created a script to:

1. Convert Squares to Triangles
2. Group Squares and Triangles with the same color
3. Print the grouped pairs

Here's an example of what we want: 

```
nextflow run ~/wm_training/nextflow/exercise_03/nextflow_ex2.nf 
N E X T F L O W  ~  version 22.04.0
Launching `/home/rpetit/wm_training/nextflow/exercise_03/nextflow_ex2.nf` [boring_euclid] DSL2 - revision: 6947e43df9
executor >  local (6)
[de/87f1ad] process > make_triangle (green-square - 8) [100%] 3 of 3 ✔
[d3/02b8ba] process > merge_shapes (3)                 [100%] 3 of 3 ✔
blue-square - blue-triangle
green-square - green-triangle
red-square - red-triangle
```

You'll notice the squares and triangles are grouped by color. You try executing this script a few times,
does it print the correct pairs all the time? If not, can you figure out what's happening?

---

### Using Operators to Ensure Channel Order

Unless you completely skipped the previous section, you should now better understand how the FIFO 
nature of Channels can produce unintended side-effects. In the previous example, sometimes we did
get the correct pairs, but most of the time our pairs were mixed. 

In this example, we're going to use the [`toSortedList`](https://www.nextflow.io/docs/edge/operator.html#tosortedlist)
Operator to ensure we always get correct pairs. Let's go a head take a look at 
[exercise_03/nextflow_ex3.nf](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_03/nextflow_ex3.nf).

In this exercise we'll use Operators to manipulate the Channels and ensure _first in, first out_ (FIFO) is always the same. This script will:

1. Convert Squares to Triangles
2. Group Squares and Triangles with the same color, using sorted lists
3. Print the grouped pairs

Now are you always getting the same outputs? Can you foresee any issues using a sorted lists?

---

### Using Outputs to Ensure Channel Order

While the sorted lists worked to ensure we always had the correct pairs, I can't help but wonder: _What if our pairs weren't alphabetical?_

An alternative (_there are so many ways to do the same thing, get creative!_), is to carry the outputs together. Let's
go a head take a look at the final example for this exercise: [exercise_03/nextflow_ex4.nf](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_03/nextflow_ex4.nf).

```
nextflow run ~/wm_training/nextflow/exercise_03/nextflow_ex4.nf 
N E X T F L O W  ~  version 22.04.0
Launching `/home/rpetit/wm_training/nextflow/exercise_03/nextflow_ex4.nf` [modest_crick] DSL2 - revision: 4bdd5646bf
executor >  local (6)
[1d/dad619] process > make_triangle (green-square - 8) [100%] 3 of 3 ✔
[3c/544437] process > merge_shapes (3)                 [100%] 3 of 3 ✔
red-square - red-triangle
blue-square - blue-triangle
green-square - green-triangle
```

Similar to the previous example, we will always get the correct pairs. Take a look at the script
and see if you can figure out what we are doing? Is this way better than using sorted lists?

Take some time to just peruse these scripts. Because these scripts are the basic structure for 
some really complex Nextflow pipelines!

---

## Exercise 4 - Nextflow DSL1 vs DSL2

Here we are, you go thrown into the deep end of Nextflow. You've played around with Channels, Operators,
and Processes. Now its time to jump into Nextflow DSL1 and Nextflow DSL2. 

_Note: This exercise is really meant to be done together with the instructor, because there is a lot of discussion_

DSL1 and DSL2 are versions of the syntax used in Nextflow langauge. For all extensive purposes, you
should be using DSL2, but it helps to understand the differences between the two.

In the exercise will be taking a look at [`scan-n-trim`](https://github.com/theiagen/wm_training/blob/solutions/wdl/workflows/wf_scan_n_trim.wdl),
a WDL workflow we produced a few weeks ago, in Nextflow DSL1 and DSL2. `scan-n-trim` used 
[fastq-scan](https://github.com/rpetit3/fastq-scan) to generate statistics on the original FASTQ,  
[Trimmomatic](https://github.com/usadellab/Trimmomatic) trim the original FASTQ, then run fastq-scan again on 
the trimmed reads.

For this exercise will also be making use of a 
[nextflow.config](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_04/nextflow.config) file. This config file has the following:
```
docker.enabled = true

// Set default inputs
params.sample = "SRR2838702"
params.r1 = "https://github.com/bactopia/bactopia-tests/raw/main/data/species/portiera/illumina/SRR2838702_R1.fastq.gz"
params.r2 = "https://github.com/bactopia/bactopia-tests/raw/main/data/species/portiera/illumina/SRR2838702_R2.fastq.gz"

// Trimmomatic paramters 
params.window_size = 4
params.minlen = 75
params.quality_trim_score = 30
params.max_cpus = 4
```

What this config file does is specify a few default values that our `scan-n-trim` pipelines will use.
You have full control to change any of the `params.` at the command line. For instance to change `params.max_cpus`
you would add `--max_cpus 2` to the command.

---

### `scan-n-trim` DSL1

Again, for all extensive purposes going forward, you should be writing new Nextflow pipelines in DSL2.
But being able to use and navigate DSL1 is still needed, as there are still many DSL1 pipelines out
there.

Go ahead and take a look at [exercise_04/scan-n-trim-dsl1.nf](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_04/scan-n-trim-dsl1.nf).

Try executing it:
```
nextflow run ~/wm_training/nextflow/exercise_04/scan-n-trim-dsl1.nf 
N E X T F L O W  ~  version 22.04.0
Launching `/home/rpetit/wm_training/nextflow/exercise_04/scan-n-trim-dsl1.nf` [crazy_descartes] DSL1 - revision: 271b352b08
executor >  local (3)
[1b/4eab6f] process > FASTQ_SCAN_ORIGINAL (SRR2838702) [100%] 1 of 1 ✔
[6f/0136f3] process > TRIMMOMATIC (SRR2838702)         [100%] 1 of 1 ✔
[ed/62e158] process > FASTQ_SCAN_FINAL (SRR2838702)    [100%] 1 of 1 ✔

ls -lh SRR2838702-dsl1/
total 9.9M
-rw-r--r-- 1 rpetit rpetit  4.2M May 23 03:36 SRR2838702_1P.fastq.gz
-rw-r--r-- 1 rpetit rpetit 1008K May 23 03:36 SRR2838702_1U.fastq.gz
-rw-r--r-- 1 rpetit rpetit  4.2M May 23 03:36 SRR2838702_2P.fastq.gz
-rw-r--r-- 1 rpetit rpetit  556K May 23 03:36 SRR2838702_2U.fastq.gz
-rw-r--r-- 1 rpetit rpetit  3.2K May 23 03:36 SRR2838702_R1-final.json
-rw-r--r-- 1 rpetit rpetit  2.8K May 23 03:36 SRR2838702_R1-original.json
-rw-r--r-- 1 rpetit rpetit  3.2K May 23 03:36 SRR2838702_R2-final.json
-rw-r--r-- 1 rpetit rpetit  2.7K May 23 03:36 SRR2838702_R2-original.json
```

Now, try rerunning it but on different FASTQs (_maybe the ones used for the WDL scan-n-trim_), change the parameters, what happens if you set `--minlen` to a super high value?

---

### `scan-n-trim` DSL2

The latest and greatest of Nextflow: DSL2. Go ahead and take a look at [exercise_04/scan-n-trim-dsl2.nf](https://github.com/theiagen/wm_training/blob/main/nextflow/exercise_04/scan-n-trim-dsl2.nf).

You will probably notice its a bit more streamlined than the DSL1 version. In the DSL2 version we make use of modules:
```
include { FASTQ_SCAN as FASTQ_SCAN_ORIGINAL } from './modules/fastqscan.nf'
include { FASTQ_SCAN as FASTQ_SCAN_FINAL } from './modules/fastqscan.nf'
include { TRIMMOMATIC } from './modules/trimmomatic.nf'
```

What this does is allow us to reuse the same files. Even better if we want to use these modules in another pipeline, 
all we have to do is point to them.

We all get to reuse Channels in DSL2, in the previous DSL1 version duplicate input channels were needed for the 
original FASTQ inputs.

Go ahead and try executing the DSL2 pipeline:
```
nextflow run ~/wm_training/nextflow/exercise_04/scan-n-trim-dsl2.nf 
N E X T F L O W  ~  version 22.04.0
Launching `/home/rpetit/wm_training/nextflow/exercise_04/scan-n-trim-dsl2.nf` [dreamy_darwin] DSL2 - revision: b641a6c405
executor >  local (3)
[65/51da6f] process > FASTQ_SCAN_ORIGINAL (SRR2838702) [100%] 1 of 1 ✔
[e3/085ccf] process > TRIMMOMATIC (SRR2838702)         [100%] 1 of 1 ✔
[95/703152] process > FASTQ_SCAN_FINAL (SRR2838702)    [100%] 1 of 1 ✔
```

Hard to tell the difference between the two! As you might expect the outputs are identical as well.

Go ahead and see what happens when you change the `params` on the command line. Think you can convert it
to use Conda instead? 

---

## Bonus Exercises

The following exercises start to get into advanced features of Nextflow. Overtime, if you
continue to develop in Nextflow, they'll become unavoidable.

### Use Nextflow Tower
Try running our pipeline with metrics reported to [Tower](https://tower.nf/). To 
learn more on how you can do this, check out [Tower via Nextflow run command](https://help.tower.nf/22.1/getting-started/usage/#via-tower-api)

---

### Adjust how files are output
There is a process directive called [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir). Try adding
it to our DSL2 pipeline to change where output files are published to.

---

### Use labels to adjust runtime requirements
The [label](https://www.nextflow.io/docs/latest/process.html#label) directive is heavily used in 
[nf-core](https://github.com/nf-core/rnaseq/blob/master/conf/base.config#L21-L42) to assign the
runtime requirements of a process. Try creating your own labels to alter how much resources a
process can use.

---

### Use profiles to switch between Conda and Docker
Try creating your own [config profile](https://www.nextflow.io/docs/latest/config.html#config-profiles)
to allow easy switching between Docker and Conda. Hey maybe you could even toss Singularity or a 
Cloud provider (_if you have access to one_).

---

### Create a DSL2 pipeline using modules from nf-core/modules
There are so many pre-built DSL2 modules available from 
[nf-core/modules](https://github.com/nf-core/modules#using-existing-modules). Try creating your
own DSL2 pipeline using the [nf-core/tools](https://github.com/nf-core/tools) package and modules
from `nf-core/modules`
