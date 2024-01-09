
addpath('../modules/2019_03_03_BCT')
addpath('../modules/system-segregation-and-graph-tools/MATLAB')
pipeline='connectivity';

%% Within and between network connectivity
parcellation='schaefer400';
subjlist=readtable(('../dataset/QA_revision.csv'),'Delimiter',',','ReadVariableNames', 1);
[unique_subs, index]=unique(subjlist.sub);
unique_subjlist= subjlist(index,:);
dim=str2double(parcellation(end-2:end)); %what is the dimensionality of the parcellation

clear modul
clear avgweight
clear num_comms_modul
clear system_segreg
clear system_connectivity
clear system_connectivity_all
clear mean_within_sys
clear mean_between_sys
clear system_conn
clear part_coef_pos
clear part_coef_neg
clear avgclustco_both
clear avgclustco_all
clear part_coef_avg_all
clear modul_comms
datadir='../dataset/childhood/connectivity';
yeo_nodes=dlmread('../modules/schaefer400x7CommunityAffiliation.1D.txt');
modul=zeros(height(subjlist),1);
avgweight=zeros(height(subjlist),1);
num_comms_modul=zeros(height(subjlist),1);
system_conn=zeros(height(subjlist),7*7); 
system_segreg=zeros(height(subjlist),1);
mean_within_sys=zeros(height(subjlist),1);
mean_between_sys=zeros(height(subjlist),1);
part_coef_pos=zeros(height(subjlist),1);
part_coef_neg=zeros(height(subjlist),1);
avgclustco_both=zeros(height(subjlist),1);
avgclustco_all=zeros(height(subjlist),dim);
part_coef_avg_all=zeros(height(subjlist),dim);
modul_comms=zeros(100,dim);

for n=1:height(unique_subjlist)
    sub=char(subjlist.sub(n)); %look at this
    file=fullfile(datadir,strcat(num2str(sub),'_run-01_schaefer400MNI_znetwork.txt'));
    file2=fullfile(datadir,strcat(num2str(sub),'_run-02_schaefer400MNI_znetwork.txt'));
    file3=fullfile(datadir,strcat(num2str(sub),'_run-03_schaefer400MNI_znetwork.txt'));
    if isfile(file)
        file=file;
    elseif isfile(file2)
        file=file2;
    elseif isfile(file3)
        file=file3;
    end
    subfcmat = readtable(file);
    subfcmat = table2array(subfcmat);
    subfcmat = subfcmat(2:height(subfcmat), 1:width(subfcmat));
    for x=1:dim
        subfcmat(x,x)=0;
    end

    [Ppos, Pneg]=participation_coef_sign(subfcmat, yeo_nodes);
    part_coef_pos(n,1)=mean(Ppos);
    part_coef_neg(n,1)=mean(Pneg);
    %write out all nodes participation coefficient
    part_coef_avg_all(n,:)=((Ppos+Pneg)/2);

    header={'sub', 'part_coef_avg_all'};
    outfile=dataset(char(subjlist.sub), part_coef_avg_all);
    export(outfile,'File',strcat('../derivatives/childhood/n125_long_inc_part_coef_avg_nodewise_avgruns', parcellation,'.csv'),'Delimiter',',')
end

