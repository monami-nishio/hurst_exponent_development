# hurst_exponent_development

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

## About
This is the codes to replicate the analysis in Nishio et al.  
[Link to the paper]

## Dataset (/dataset)
- adult
-   connectivity
-   correlation
-   timeseries
- childhood

| Column | Column | Description |
| ---- | ---- | ---- |
| adult | timeseries | rsfMRI timeseries for adult samples |
|  | correlation | rsfMRI pearson correlation matrix for adult samples |
|  | connectivity | rsfMRI z-scored pearson correlation matrix for adult samples |
| childhood | timeseries | rsfMRI timeseries for adult samples |
|  | correlation | rsfMRI pearson correlation matrix for adult samples |
| | connectivity | rsfMRI z-scored pearson correlation matrix for adult samples |
| rna | column_metadata |  |
|  | rows_metadata |  |
|  | expression_matrix |  |

## How to run (/codes)

To reproduce Figure 1,
* 'Figure1.ipyng' reproduce RNA-analysis. 

To reproduce Figure 2,   
* `Figure2AB.ipynb` reproduce sample timeseries and spectrogram.
* `Figure2CD.Rmd' reproduce hurst exponent along S-A axis.

To reproduce Figure 3,   
* `Figure3' reproduce hurst exponent developmental analysis.  

To reproduce Figure 4,   
* `Figure4A.ipynb` reproduce sample correlation matrix.
* `Figure4CD.Rmd` reproduce participation coefficient along S-A axis.

To reproduce Figure 5,   
* `Figure5.Rmd` reproduce participation coefficient developmental analysis.
  
To reproduce Figure 6,  
* `Figure6A-C.Rmd` reproduce correlation mapping between hurst exponent and participation coefficient.
* `Figure6D-G.Rmd` reproduce income effect on hurst exponent and participation coefficient.
