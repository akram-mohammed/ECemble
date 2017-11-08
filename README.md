<div align="center">
  <img src="logo.png" width="512">
</div>

---

<h1 align="center">
  ECemble
</h1>

<h4 align="center">
  A data mining suite for enzyme classification
</h4>

<p align="center">
  <a href="http://ECemble.readthedocs.io">
    <img src="https://readthedocs.org/projects/ECemble/badge/?version=latest"/>
  </a>
  <a href="https://saythanks.io/to/akram-mohammed">
    <img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg?style=flat-square">
  </a>
  <a href="https://paypal.me/akram9">
    <img src="https://img.shields.io/badge/Donate-%24-blue.svg?style=flat-square">
  </a>
</p>

**ECemble** is an open source ensemble machine learning pipeline tool (released under the [GNU General Public License v3](LICENSE.md)) that allow users to efficiently and automatically process proteomes to predict enzyme and enzyme classes from unannotated protein sequences. ECemble uses various learning algorithms to generate multiple prediction models that distinguish different classes of enzymes, where it first predicts if a protein is an enzyme or a non-enzyme, and then subsequently predict specific class and subclass of an enzyme in the EC number hierarchy. The predictions are selected when at least two of the three top-performing ML classifiers show consistent predictions.
If you use this resource, please cite the following reference: 
Mohammed A, Guda C. Application of Hierarchical enzyme classification method reveals the role gut microbiome in human metabolism. BMC Genomics 2015
https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-16-S7-S16


***Note***: ECemble is an open-source software, in case if you run across bugs or errors, raise an issue over [here](https://github.com/akram-mohammed/ECemble/issues).

### Table of Contents
* [Downloading ECemble](#downloading-ecemble)
* [Dependencies](#dependencies)
* [System Requirements](#system-requirements)
* [Directory Structure of the Pipeline](#directory-structure-of-the-pipeline)
* [Execution of Pipeline](#execution-of-pipeline)
* [Contribution](#contribution)
* [License](#license)

This README file will serve as a guide for using this software tool. We suggest reading through the entire document at least once, in order to get an idea of the options available, and how to customize the pipeline to fit your needs.

### Downloading CancerDiscover
Clone the git repository:
```console
$ git clone https://github.com/akram-mohammed/ECemble.git && cd ECemble
```

### Dependencies 
Before downloading **ECemble**, make sure you have all the necessary software packages installed. 
#### Installing R
From the command line, enter the following commands below: 
```
sudo apt-get update
sudo apt-get install r-base
```

#### Installing Bioconductor and R packages
**Run R**

Once `R` is installed you’ll need to run the commands from within `R`.
From the commandline enter the following command:
```
R
```

**Install Bioconductor**

Once R has finished loading, enter the following command:
```
source("http://bioconductor.org/biocLite.R")
```

If there is a updated bioconductor package is available, run the following command:
```
biocLite("BiocUpgrade")
```

**Install Affy R module**

Enter the following command to install the `Affy` `R` package:
```
biocLite("affy")
```

**Annotation Database Interface**

You will also need a package called `AnnotationDbi` which can be installed with the command below:
```
biocLite("AnnotationDbi")
```

It provides user interface and database connection code for annotation data packages using SQLite data storage.

**CDF (Chip Definition File)**

Command to download the plate *HG_U133_Plus2* `cdf`:
```
biocLite("hgu133plus2cdf")
```

It is important to note that not all data must have been derived from affymetrix plates which meet the requirements put in place by the `Affy` `R` package. Plates such as *HG_U95* and *HG_U133* are known to be acceptable as long as their associated `cdf` has been installed.

#### Installing WEKA
This project utilizes [WEKA](http://www.cs.waikato.ac.nz/ml/weka/) 3-6-11. In order to get this version, in a directory outside of the `CancerDiscover` directory, execute  the following command:

```
wget https://sourceforge.net/projects/weka/files/weka-3-6/3.6.11/weka-3-6-11.zip/download
```
Next, set the `WEKA` classpath by entering the following command in `.bashrc` file under Alias definitions:
```
export WEKAINSTALL=/absolute/path/to/weka/directory/`
export CLASSPATH=$CLASSPATH:$WEKAINSTALL/weka.jar
```
For example: 
```
export WEKAINSTALL=/home/general/weka/weka-3-6-11`
export CLASSPATH=$CLASSPATH:$WEKAINSTALL/weka.jar
```
**Note:** Since WEKA is Java-based framework, the user needs to install and set the classpath for `JAVA`. 

To install ECemble dependencies right from scratch, check out our exhaustive guides:
* [A Hitchhiker's Guide to Installing ECemble on Linux OS](https://github.com/akram-mohammed/ECemble/wiki/A-Hitchhiker's-Guide-to-Installing-ECemble-on-Linux-OS)
* [A Hitchhiker's Guide to Installing ECemble on Mac OS X](https://github.com/akram-mohammed/ECemble/wiki/A-Hitchhiker's-Guide-to-Installing-ECemble-on-Mac-OS-X)

### System Requirements
You will need current or very recent generations of your operating system: 
**Linux OS**, **Mac OS X**.

### Directory Structure of the Pipeline
After downloading **ECemble**, notice inside the **ECemble** directory there are several empty directories and one which contains all of the scripts necessary to process data:

### Execution of Pipeline



### Contribution

  Akram Mohammed	amohammed3@unl.edu

### License
This software has been released under the [GNU General Public License v3](LICENSE.md).
