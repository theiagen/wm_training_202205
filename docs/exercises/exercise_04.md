# Nextflow 

In this exercise we'll be getting an introduction into Conda and Nextflow. 

## Exercise 1 - Conda

When installing the [Conda](https://conda.io/)
package manager you have two options, [Anaconda](https://www.anaconda.com/products/distribution)
or [Miniconda](https://conda.io/miniconda.html). Anaconda comes with a lot of
pre-installed packages and Miniconda comes with the bare necessities. For our purposes,
we'll be using Miniconda, so lets get it installed.


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

### Note about the `base` environment

A good rule of thumb when using Conda is to avoid installing anything in the `base` environment.
If for some reason your `base`environment gets messed up, you will need to reinstall Miniconda.
While not too difficult to reinstall, its even easier to just avoid installing things in your
`base` environment!

_There is an exception to this rule of thumb though!_

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

### Additional Exercises

If you are feeling adventurous, you can keep playing around with Conda. Head on over to
[Bioconda](https://bioconda.github.io/), and use the search function to find a tool you are
interested in trying.

Examples: `shovill`, `prokka`, `dragonflye`, `seqsero2`, so many to choose from!

### 

### Conda Rules of Thumb
Its no secret, Conda can be quite sensitive to change. In order to keep Conda happy, try to follow the following rules. By following these, Conda will stay happy, which means you will too!

__Rule Number 1 - Keep `base` clean__  
Keep your base environment clean! Try to avoid installing anything in your `base` environment (_there are a few exceptions!_). If your `base` environment breaks, you have to reinstall Miniconda. 

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

## Exercise 2 - Nextflow Introduction

## Bonus Exercise - Use `-with-tower`
As a bonus exercise, let's try running our pipeline with metrics reported to [Tower](https://tower.nf/). To 
learn more on how you can do this, check out [Tower via Nextflow run command](https://help.tower.nf/22.1/getting-started/usage/#via-tower-api)

## Exercise 3 - Nextflow Channels and Processes

## Exercise 4 - Nextflow DSL1 vs DSL2

## Exercide 5 - `scan-and-trim` DSL1 Pipeline

## Exercise 6 - `scan-and-trim` DSL2 Pipeline

