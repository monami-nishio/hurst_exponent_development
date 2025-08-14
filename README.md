# The development of neural inhibition across species: insights from the Hurst exponent

## About
This repository contains the code and data supporting the study *"The development of neural inhibition across species: insights from the Hurst exponent,"* published in *Journal of Neuroscience*.

## Setup
Install following MATLAB packages and put under /module folder.
* 2019_03_03_BCT
* nonfractal

## Dataset (/data)

| Column | Column | Description |
| ---- | ---- | ---- |
| adult | timeseries | rsfMRI timeseries for adult samples |
|  | correlation | rsfMRI pearson correlation matrix for adult samples |
|  | connectivity | rsfMRI z-scored pearson correlation matrix for adult samples |
| childhood | timeseries | rsfMRI timeseries for child samples |
|  | correlation | rsfMRI pearson correlation matrix for adult samples |
|  | connectivity | rsfMRI z-scored pearson correlation matrix for adult samples |
| rna | column_metadata |  |
|  | rows_metadata |  |
|  | expression_matrix |  |

## How to run (/codes)

To calculate hurst exponent
* `hurst_exponent.m`. 

To calculate participation coefficient
* `participation_coefficient.m`. 

To reproduce Figure 1,
* `Figure1.ipynb` reproduce RNA-analysis. 

To reproduce Figure 2,   
* `Figure2AB.ipynb` reproduce sample timeseries and spectrogram.
* `Figure2CD.Rmd` reproduce hurst exponent along S-A axis.

To reproduce Figure 3,   
* `Figure3.Rmd` reproduce hurst exponent developmental analysis.  

To reproduce Figure 4,   
* `Figure4A.ipynb` reproduce sample correlation matrix.
* `Figure4CD.Rmd` reproduce participation coefficient along S-A axis.

To reproduce Figure 5,   
* `Figure5.Rmd` reproduce participation coefficient developmental analysis.
  
To reproduce Figure 6,  
* `Figure6A-C.Rmd` reproduce correlation mapping between hurst exponent and participation coefficient.
* `Figure6D-G.Rmd` reproduce income effect on hurst exponent and participation coefficient.
