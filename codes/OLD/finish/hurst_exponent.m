addpath('../modules/nonfractal')
addpath('../modules/wmtsa-matlab-0.2.6')
lb = [-0.5,0];
ub = [1.5,10];

H_all = [];
nfcor_all = zeros(400,400);
fcor_all = zeros(400,400);
int_all = [];
sub_all = [];
run_all = [];
subjlist=readtable(('../dataset/QA_revision.csv'),'Delimiter',',','ReadVariableNames', 1);
[unique_subs, index]=unique(subjlist.sub);
unique_subjlist= subjlist(index,:);
datadir='../dataset/childhood/timeseries';
for n=1:height(unique_subjlist)
    sub=char(subjlist.sub(n));
    file=fullfile(datadir,strcat('sub-', num2str(sub),'_ses-01_task-rest_run-1_space-MNI152NLin6Asym_atlas-Schaefer417_timeseries.tsv'));
    file2=fullfile(datadir,strcat('sub-', num2str(sub),'_ses-01_task-rest_run-2_space-MNI152NLin6Asym_atlas-Schaefer417_timeseries.tsv'));
    file3=fullfile(datadir,strcat('sub-', num2str(sub),'_ses-01_task-rest_run-3_space-MNI152NLin6Asym_atlas-Schaefer417_timeseries.tsv'));
    if isfile(file)
        file=file;
    elseif isfile(file2)
        file=file2;
    elseif isfile(file3)
        file=file3;
    end
    table = readtable(file, "FileType","text",'Delimiter', '\t');
    for j = 1:width(table)
        if isa(table.(j)(1),'double') == 0
            table.(j) = table.(j-1);
        end
    end 
    ArrayTable = table2array(table);
    [H, nfcor, fcor] = bfn_mfin_ml(ArrayTable, 'filter', 'Haar', 'lb', lb, 'ub', ub);
    H_all = [H_all; H];
    sub_all = [sub_all; sub];
    run_all = [run_all; 'run-01'];
end
H_all = [num2cell(H_all) cellstr(sub_all) cellstr(run_all)];
H_all = cell2table(H_all);
writetable(H_all, '../derivatives/childhood/H.csv');