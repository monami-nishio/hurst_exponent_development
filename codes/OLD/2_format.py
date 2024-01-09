import numpy as np
import pandas as pd
import os
import glob
import matplotlib.pyplot as plt
from scipy.stats import zscore

for batch in [1,2,3]:

    income_median = pd.read_csv('../derivatives/t'+str(batch)+'_income_median_normalize.table.dat')
    parent_edu = pd.read_csv('../derivatives/t'+str(batch)+'_parent_edu_normalize.table.dat')
    age = pd.read_csv('../derivatives/t'+str(batch)+'_normalize.table.dat')

    hurst = pd.read_csv('/cbica/home/nishiom/Functional/derivative/hurst_exponent/H'+str(batch)+'.csv',header=None)
    INT = pd.read_csv('/cbica/home/nishiom/Functional/derivative/hurst_exponent/int'+str(batch)+'.csv',header=None)
    hurst.columns = list(np.arange(400)) + ['fsid'] + ['run']
    INT.columns = list(np.arange(400)) + ['fsid'] + ['run']
    for i in np.arange(400):
        hurst[i] = [float(x) for x in hurst[i]]
        INT[i] = [float(x) for x in INT[i]]
    hurst['fsid'] = ['sub-'+x for x in hurst.fsid]
    INT['fsid'] = ['sub-'+x for x in INT.fsid]
    hurst = hurst.groupby('fsid').mean().reset_index()
    hurst.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/hurst'+str(batch)+'.csv'))
    hurst_income = pd.merge(hurst, income_median, on='fsid')
    hurst_parent = pd.merge(hurst, parent_edu, on='fsid')
    hurst_age = pd.merge(hurst, age, on='fsid')
    hurst_income.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/hurst_income'+str(batch)+'.csv'), index=False)
    hurst_parent.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/hurst_parent'+str(batch)+'.csv'), index=False)
    hurst_age.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/hurst_age'+str(batch)+'.csv'), index=False)
    #INT = INT[INT.session=='ses-01']
    INT = INT.groupby('fsid').mean().reset_index()
    INT.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/INT'+str(batch)+'.csv'))
    INT_income = pd.merge(INT, income_median, on='fsid')
    INT_parent = pd.merge(INT, parent_edu, on='fsid')
    INT_age = pd.merge(INT, age, on='fsid')
    INT_income.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/int_income'+str(batch)+'.csv'), index=False)
    INT_parent.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/int_parent'+str(batch)+'.csv'), index=False)
    INT_age.to_csv(os.path.join('/cbica/home/nishiom/Functional/derivative/hurst_exponent/int_age'+str(batch)+'.csv'), index=False)
    print(hurst.shape)
    print(hurst_age.shape)

    csvs = glob.glob(os.path.join(output_dir, 'test/*400.csv'))
    for csv in csvs:
        df = pd.read_csv(csv)
        df = df.iloc[:,1:]
        non = [i for i in np.arange(df.shape[0]) if df.iloc[i,:].sum()>0]
        df = df.iloc[non,:]
        df_mean = pd.DataFrame([df.columns, df.mean()]).T
        df_mean.columns = ['region', 'color']
        # visualizeの時にエラーになるので-は削除
        #df_mean['color'] = [0.1 if x <= 0 else x for x in df_mean.color]
        #df_mean['color'] = (df_mean['color'] - np.mean(df_mean['color']))/np.std(df_mean['color'])
        df_mean.iloc[:int(df_mean.shape[0]/2),:].to_csv(csv.replace('.csv', '_lh_average.csv'), index=False)
        df_mean.iloc[int(df_mean.shape[0]/2):,:].to_csv(csv.replace('.csv', '_rh_average.csv'), index=False)

        sbjlist = pd.read_csv(os.path.join(output_dir,'QA_revision.csv'))
        if df.shape[0] == sbjlist.shape[0]:
            for i, x in enumerate(['lh','rh']):
                df_hem = df.iloc[:, 200*i:200*(i+1)]
                df_hem['fsid'] = ['sub-'+x for x in sbjlist['sub']]
                df_income = pd.merge(df_hem, income_median, on='fsid')
                df_parent = pd.merge(df_hem, parent_edu, on='fsid')
                df_age = pd.merge(df_hem, age, on='fsid')
                df_income.to_csv(os.path.join(csv.replace('.csv', f'{x}_median_income.csv')), index=False)
                df_parent.to_csv(os.path.join(csv.replace('.csv', f'{x}_parent_edu.csv')), index=False)
                df_age.to_csv(os.path.join(csv.replace('.csv', f'{x}_age.csv')), index=False)
    print(df_age.shape)

    csvs = glob.glob(os.path.join(output_dir, 'test/*Yeo7_avgruns_withmodulpartcoef_schaefer400.csv.csv'))
    for csv in csvs:
        df = pd.read_csv(csv)
        df = df.iloc[:,1:]
        non = [i for i in np.arange(df.shape[0]) if df.iloc[i,:].sum()>0]
        sbjlist = pd.read_csv(os.path.join(output_dir,'QA_revision.csv'))
        if df.shape[0] == sbjlist.shape[0]:
            df['fsid'] = ['sub-'+x for x in sbjlist['sub']]
            df_income = pd.merge(df, income_median, on='fsid')
            df_parent = pd.merge(df, parent_edu, on='fsid')
            df_age = pd.merge(df, age, on='fsid')
            df_income.to_csv(os.path.join(csv.replace('.csv', f'_median_income.csv')), index=False)
            df_parent.to_csv(os.path.join(csv.replace('.csv', f'_parent_edu.csv')), index=False)
            df_age.to_csv(os.path.join(csv.replace('.csv', f'_age.csv')), index=False)

