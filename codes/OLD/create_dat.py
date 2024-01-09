import numpy as np
import pandas as pd
import os 
import glob

# JupyterNotebookで実行
#df = pd.read_csv("CBPD_data_DMD_2022.12.08.csv")
#df = df.loc[:, ['record_id', 'age_scan']].dropna(subset=['age_scan'])
#timepoint1 = [i for i in np.arange(df.shape[0]) if '_' not in df.record_id.values[i]]
#timepoint2 = [i for i in np.arange(df.shape[0]) if '_2' in df.record_id.values[i]]
#timepoint3 = [i for i in np.arange(df.shape[0]) if '_3' in df.record_id.values[i]]
#for i, timepoint in enumerate([timepoint1, timepoint2, timepoint3]):
#    df_t = df.iloc[timepoint,:]
#    df_t['age_scan'] = (df_t.age_scan - df_t.age_scan.mean())/df_t.age_scan.std()
#    df_t.to_csv(f'fsgd_t{str(i+1)}.csv', index=None)

data_dir = '/cbica/projects/cbpd_main_data/CBPD_bids/derivatives'

for ses in np.arange(3):
    ses_folder = os.path.join(data_dir, f'freesurfer_edits_t{ses+1}')
    subjects = glob.glob(os.path.join(ses_folder, 'sub-CBPD*'))
    subject_names = []
    for sbj in subjects:
        if len(glob.glob(os.path.join(sbj,'surf/*.area.pial.fwhm15.fsaverage.mgh'))) > 0 :
            subject_names.append(os.path.basename(sbj))
            #if len(glob.glob(os.path.join(sbj,'surf/*.area.pial.fwhm15.fsaverage.mgh'))) != 2:
            #    print(sbj)
        else:
            print(sbj)
    csv = pd.read_csv(f'/cbica/home/nishiom/SurfaceArea/dat/t{str(ses+1)}.csv')
    csv['fsid'] = ['sub-'+x.split('_')[0] for x in csv.record_id]
    #exists = [i for i in np.arange(csv.shape[0]) if csv.fsid.values[i] in subject_names]
    #df = csv.iloc[exists,:].reset_index(drop=True)
    df = csv.copy()
    df['age_square_scan'] = [x**2 for x in df.age_scan]
    for var in ['age', 'parent_edu', 'income_rank', 'income_median']:
        if var=='age':
            df_var = df.loc[:, ['fsid', 'age_scan', 'age_square_scan', 'male', 't1_rating_avg']]#.dropna('age_scan')#how='any')
            for v in ['age_scan', 'age_square_scan', 't1_rating_avg']:
                df_var[v] = (df_var[v] - df_var[v].mean())/df_var[v].std()
            df_var.to_csv(f'/cbica/home/nishiom/SurfaceArea/dat/t{str(ses+1)}_refine.table.dat', index=False)
            df_var = df.loc[:, ['fsid', 'age_scan', 'age_square_scan', 'male', 't1_rating_avg']].dropna(how='any')
            df_var.to_csv(f'/cbica/home/nishiom/SurfaceArea/dat/t{str(ses+1)}_refine_nonormalize.table.dat', index=False)
        else:
            df_var = df.loc[:, ['fsid', var, 'age_scan', 'male', 't1_rating_avg']].dropna(how='any')
            for v in ['age_scan', 't1_rating_avg', var]:
                df_var[v] = (df_var[v] - df_var[v].mean())/df_var[v].std()
            df_var.to_csv(f'/cbica/home/nishiom/SurfaceArea/dat/t{str(ses+1)}_{var}_refine.table.dat', index=False)

    