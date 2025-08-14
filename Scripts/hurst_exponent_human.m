addpath(genpath('../../Rmodules'))
lb = [-0.5,0];
ub = [1.5,10];

H_all = [];
nfcor_all = zeros(400,400);
fcor_all = zeros(400,400);
int_all = [];
sub_all = [];
run_all = [];
subjlist=readtable(('../../Dataset/childhood/QA_revision.csv'),'Delimiter',',','ReadVariableNames', 1);
datadir='../../Dataset/childhood/timeseries';
for n=1:height(subjlist)
    sub=char(subjlist.sub(n));
    run=num2str(subjlist.run(n));
    file=fullfile(datadir,strcat('sub-', num2str(sub),'_ses-01_task-rest_run-', run, '_space-MNI152NLin6Asym_atlas-Schaefer417_timeseries.tsv'));
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
    run_all = [run_all; strcat('run-0', run)];
    
end
H_all = [num2cell(H_all) cellstr(sub_all) cellstr(run_all)];
H_all = cell2table(H_all);
writetable(H_all, '../../Derivatives/childhood/H.csv');