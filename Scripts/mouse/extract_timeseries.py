from nilearn.maskers import NiftiMasker, NiftiLabelsMasker
from nilearn.image import load_img
from nilearn.connectome import ConnectivityMeasure
from nilearn import plotting
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import glob
import os

#mask_path = glob.glob(os.path.join('/cbica/home/nishiom/Mouse/modules/MultiRat/assets/nifti/roi/*.nii.gz'))
mask_path = '/cbica/home/nishiom/Mouse/modules/SIGMA_Wistar_Rat_Brain_TemplatesAndAtlases_Version1.2.1/SIGMA_Rat_Brain_Atlases/SIGMA_Anatomical_Atlas/InVivo_Atlas/SIGMA_InVivo_Anatomical_Brain_Atlas.nii'
mouse_path = glob.glob(os.path.join('/cbica/home/nishiom/Mouse/RAS/sub-*.nii.gz'))
#mask_img = load_img(mask_path)

all_mouse = []
for i, mouse in enumerate(mouse_path):
    if not os.path.exists(os.path.join('/cbica/home/nishiom/Mouse/derivatives/connectivity', os.path.basename(mouse).replace('.nii.gz', '_connectivity.csv'))):
        print(mouse)
        mouse_img = load_img(mouse)
        masker = NiftiLabelsMasker(labels_img=mask_path, standardize=True,memory="nilearn_cache",verbose=5) #"zscore_sample"    standardize_confounds="zscore_sample",
        timeseries = masker.fit_transform(mouse_img)
        pd.DataFrame(timeseries).to_csv(os.path.join('/cbica/home/nishiom/Mouse/derivatives/timeseries', os.path.basename(mouse).replace('.nii.gz', '_timeseries.csv')), index=False)
        correlation_measure = ConnectivityMeasure(kind="correlation") #,standardize=True
        correlation_matrix = correlation_measure.fit_transform([timeseries])[0]
        pd.DataFrame(correlation_matrix).to_csv(os.path.join('/cbica/home/nishiom/Mouse/derivatives/connectivity', os.path.basename(mouse).replace('.nii.gz', '_connectivity.csv')), index=False)
