# Nextflow 

In this exercise we'll take a dive into Nextflow and nf-core.

## Nextflow


## nf-core


## Exercise 1 - Conda
First things first, let's get Miniconda installed. When installing the [Conda]() package manager you have two options, [Anaconda]() or [Miniconda](). Anaconda comes with a lot of pre-installed packages and Miniconda comes with the bare necessities. For our purposes, we'll be using Miniconda, so lets get it installed.

Head on over to [Miniconda - Installers](https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links) and download the `Miniconda3 Linux 64-bit` version. 

```{bash}
# Download Miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Run installer
bash -b Miniconda3-latest-Linux-x86_64.sh

# ... Accept and use defaults for the user input steps ...
```

Once completed, these easiest thing is just to log out and log back into your VM. For the savy, you can add the miniconda bin to your PATH and source the Miniconda `activate` script.

When you log back in, you should see `(base)` at the start of your terminal lines.

```{bash}
(base) rpetit3@training-vm:~$
```

### Conda Rules of Thumb
Its no secret, Conda can be quite sensitive to change. In order to keep Conda happy, try to follow the following rules. By following these, Conda will stay happy, which means you will too!

__Rule Number 1__  
Keep your base environment clean! Try to avoid installing anything in your `base` environment (_there are a few exceptions!_). If your `base` environment breaks, you have to reinstall Miniconda. 

__Rule Number 2__  
`conda create` is your friend, use it for everything! Treat environments as consumables, create them, install in them, delete them.  

__Rule Number 3__  
Install [Mamba](https://github.com/mamba-org/mamba) into your `base` environment. Mamba is one of the exceptions, go ahead and install it in your `base` environment. Mamaba is a drop in replacement for Conda and its much, much, much faster!   

_Note: There are efforts to begin integrating Mamba into Conda, but as of [Conda v4.12](https://github.com/conda/conda/releases/tag/4.12.0) this is still an experimental feature._  

## Exercise 2 - Nextflow Introduction


## Bonus Exercise - Use `-with-tower`
As a bonus exercise, let's try running our pipeline with metrics reported to [Tower](https://tower.nf/). To 
learn more on how you can do this, check out [Tower via Nextflow run command](https://help.tower.nf/22.1/getting-started/usage/#via-tower-api)

## Exercise 3 - Nextflow Channels and Processes

## Exercise 4 - Nextflow DSL1 vs DSL2

## Exercide 5 - `scan-and-trim` DSL1 Pipeline

## Exercise 6 - `scan-and-trim` DSL2 Pipeline

