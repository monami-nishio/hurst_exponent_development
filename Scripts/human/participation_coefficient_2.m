
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
part_coef_pos=zeros(height(unique_subjlist),1);
part_coef_neg=zeros(height(unique_subjlist),1);
part_coef_avg_all=zeros(height(unique_subjlist),dim);
modul_comms=zeros(100,dim);

for n=1:height(unique_subjlist)
    sub=char(unique_subjlist.sub(n)); %look at this
    clear aggregmat
    totalsizet = 0;
    totalvolsensored = 0;
    for r=1:4
        try
            file=fullfile(datadir,strcat(sub,'_run-0', num2str(r), '_schaefer400MNI_znetwork.txt'));
            subfcmat = readtable(file);
            subfcmat = table2array(subfcmat);
            for x=1:dim
                subfcmat(x,x)=0;
            end
            rows = (string(subjlist.sub)==sub & string(subjlist.run)==num2str(r));
            vars = {'num_censored_volumes', 'size_t'};
            weights=subjlist(rows, vars);
            if isnumeric(weights.num_censored_volumes)
                weighted=subfcmat.*(weights.size_t-double(weights.num_censored_volumes));
                totalvolsensored = totalvolsensored + double(weights.num_censored_volumes);
            else
                weighted=subfcmat.*(weights.size_t-str2double(weights.num_censored_volumes));
                totalvolsensored = totalvolsensored + str2double(weights.num_censored_volumes);
            end
            totalsizet = totalsizet + weights.size_t;
            aggregmat(:,:, r)=weighted;
        catch
            fprintf('There is no run %s for sub %s \n', num2str(r), sub);
        end
    end
    aggregmat(aggregmat == 0) = NaN;    %skip any matrices that are empty.     
    meanMatrix = sum(aggregmat,3, 'omitnan')/(totalsizet-totalvolsensored); %doc mean for more info.
    [Ppos, Pneg]=participation_coef_sign(meanMatrix, yeo_nodes);
    part_coef_pos(n,1)=mean(Ppos);
    part_coef_neg(n,1)=mean(Pneg);
    %write out all nodes participation coefficient
    part_coef_avg_all(n,:)=((Ppos+Pneg)/2);
end
header={'sub', 'part_coef_avg_all'};
outfile=dataset(char(unique_subjlist.sub), part_coef_avg_all);
export(outfile,'File',strcat('../derivatives/childhood/n125_long_inc_part_coef_avg_nodewise_avgruns', parcellation,'.csv'),'Delimiter',',')

