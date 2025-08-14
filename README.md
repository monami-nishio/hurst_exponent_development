# The Development of Neural Inhibition Across Species: Insights from the Hurst Exponent

## About
This repository contains the code and metadata supporting the study  
*"The Development of Neural Inhibition Across Species: Insights from the Hurst Exponent"*, published in *XX*.

## Setup
Install the following MATLAB packages and place them in the `/module` folder:
- `2019_03_03_BCT`
- `nonfractal`

## Dataset (`/Data`)
The datasets are too large to be stored on GitHub. They are available on Zenodo: **[Zenodo DOI/URL here]**.

| Folder     | File                          | Description |
|------------|------------------------------|-------------|
| **adult**  | `timeseries`                  | rs-fMRI time series for adult samples |
|            | `participants.tsv`            | Demographic information for adult samples |
|            | `schaefer_XX.csv`             | RNA expression (Human Allen Brain Atlas) across 400 Schaefer parcels |
| **childhood** | `timeseries`                | rs-fMRI time series for child samples |
|            | `correlation`                 | rs-fMRI Pearson correlation matrix for adult samples |
|            | `expression_matrix.csv`       | RNA expression (Lifespan Brain Atlas) across 11 cortical regions |
| **mouse**  | `timeseries`                   | rs-fMRI time series for mouse samples |
|            | `participants.tsv`            | Demographic information for mouse samples |
|            | `celldensity_mmc3.csv`         | Inhibitory neuronal cell density in mouse samples |

## How to Run (`/Scripts`)
To calculate the Hurst exponent:
- `hurst_exponent_human/mouse.m`

## How to Run (`/Codes`)
To reproduce the figures:

- **Figure 1** – `Figure1_spatial_distribution/`  
- **Figure 2** – `Figure2_spatial_correlation/`  
- **Figure 3** – `Figure3_developmental_trajectory/`  
- **Supplementary Figure 2** – `FigureS2_highres_spatial_correlation/`  

All necessary data for running these scripts are stored in `/Derivatives`.
