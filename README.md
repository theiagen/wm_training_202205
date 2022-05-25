-----

<p align="center">  
  <b>NOTE: THESE TRAININGS RESOURCES ARE BEING PROVIDED TO ITS FIRST COHORTS AND UNDER ACTIVE DEVELOPMENT </b>

</p>

-----

# Workflow Management Solutions for Public Health Bioinformatics
Theiagen Genomics repository for workshop resources, code templates, and exercise materails 


## Course Overview
This intermediate-level bioinformatics training workshop will provide conceptual and applied training for understanding and utilizing workflow management solutions (e.g. WDL and Nextflow) for interoperable, reproducible, and accessible genomic analysis.

### Length of Program
This workshop is designed as a virtual, 4-week series of live-lectures and hands-on exercises. For registered trainees, instructors will be made available for office hours and continued support throughout the duration of this course. All materials--slides, exercises, and recorded lectures--will be made available publicly accessible.

### Objectives
At the conclusion of this course, participants will be able to:
- Understand fundamental concepts, advantages, and disadvantages behind containerization and workflow management systems
- Analyze and assess WDL and Nextflow code bases 
- Utilize WDL and Nextflow workflow management systems to integrate multiple analytical modules into a single bioinformatics pipeline
- Publish custom workflows to the Dockstore pipeline repository for integration on the Terra.Bio web application
- Launch Nextflow pipeline on the Nextflow Tower platform

### Target Audience
This course is meant for public health bioinformatics scientists with experience accessing and interacting with open-source bioinformatics software through a command-line interface (CLI), version control systems such as Git, and familiarity with the concepts of containerized software systems such as Docker or Singularity. Registered Github accounts are encouraged for the completion of all planned exercises. 

Below is a list of helpful resources that we recommend all trainees review, at least in part, prior to the start of this training workshop (listed in order of highest priority):
- [StaPH-B Linux Command Sheet](https://staphb.org/resources/2019-10-4-linux_cheatsheet.html)
- [StaPH-B Docker User Guide](https://staphb.org/docker-builds/)
- [GitHub Documentation](https://docs.github.com/en/get-started/quickstart/hello-world)
- [WDL Technical Documentation](https://github.com/openwdl/wdl/blob/main/versions/1.0/SPEC.md)
- [Nextflow Technical Documentation](https://www.nextflow.io/docs/latest/index.html)
- [Learning miniWDL for WDL (@lynnlangit Educational YouTube Series)](https://www.youtube.com/watch?v=w0IUd-x_9NU&list=PL4Q4HssKcxYv1FQJUD6D1Cu0Q1O-_S1hM)

## Course Content

### Slides & Exercises
**Week 1: Introduction to Workflow Management Using WDL**
- [Lecture Slides](https://github.com/theiagen/wm_training/raw/main/docs/images/week1_slides.pdf) & [Recorded Session](https://youtu.be/DpqBEmYiQlY)
- [Exercise 00: Setting up your environment](https://github.com/theiagen/wm_training/blob/main/docs/exercises/exercise_00.md)
- [Exercise 01: Creating a WDL Workflow](https://github.com/theiagen/wm_training/blob/main/docs/exercises/exercise_01.md)

**Week 2: Closer Look at WDL Tasks and Workflows**
- [Lecture Slides](https://github.com/theiagen/wm_training/raw/main/docs/images/week2_slides.pdf) & [Recorded Session](https://youtu.be/gY6aebMEl7A)
- [Exercise 02: Multi-Task WDL Workflows](https://github.com/theiagen/wm_training/blob/main/docs/exercises/exercise_02.md)

**Week 3: Connecting WDL Workflows with Terra.Bio**
- [Lecture Slides](https://github.com/theiagen/wm_training/raw/main/docs/images/week3_slides.pdf) & [Recorded Session](https://www.youtube.com/watch?v=_lIiDz4uacI)
- [Exercise 03: Connecting WDL Workflows to the Terra.Bio Platform](https://github.com/theiagen/wm_training/blob/main/docs/exercises/exercise_03.md)

**Week 4: Getting Started with Conda and Nextflow**
- [Lecture Slides](https://github.com/theiagen/wm_training/raw/main/docs/images/week4_slides.pdf)
- [Exercise 04: Nextflow](https://github.com/theiagen/wm_training/blob/main/docs/exercises/exercise_04.md)

### Exercise Resource Requirements
- Google Cloud Platform Virtual Machines (GCP VMs) with all pre-requisite software installed will be provisioned to all registered trainees. For those interested in recreating this training with their own compute environment, here is a list of resources required for the completion of each exercise:
  - [`Docker`](https://docs.docker.com/engine/install/ubuntu/)
  - [`miniwdl`](https://miniwdl.readthedocs.io/en/latest/getting_started.html)
  - [`nextflow`](https://www.nextflow.io/)
 
*Note: All exercises were developed to run on e2-standard-4 GCP VMs (4 CPUs; 16GB RAM) running Ubuntu 20.04.4 LTS (Focal Fossa)*
