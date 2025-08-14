addpath(genpath('../../Rmodules'))
lb = [-0.5,0];
ub = [1.5,10];

H_all = [];
nfcor_all = zeros(400,400);
fcor_all = zeros(400,400);
int_all = [];
sub_all = [];
run_all = [];
timeseries = dir('../../Dataset/mouse/timeseries/*.txt');
for n=1:height(timeseries)
    disp(n/height(timeseries)*100)
    subpath = append(timeseries(n).folder, '/', timeseries(n).name);
    sub = timeseries(n).name(1:4);
    table = readtable(subpath);
    for j = 1:width(table)
        if isa(table.(j)(1),'double') == 0
            table.(j) = table.(j-1);
        end
    end 
    ArrayTable = table2array(table);
    %ArrayTable = ArrayTable(2:1001,1:59);
    [H, nfcor, fcor] = bfn_mfin_ml(ArrayTable, 'filter', 'Haar', 'lb', lb, 'ub', ub);
    H_all = [H_all; H];
    sub_all = [sub_all; sub];
    run_all = [run_all; 'run-01'];
end
H_all = [num2cell(H_all) cellstr(sub_all) cellstr(run_all)];
H_all = cell2table(H_all);
writetable(H_all, '../../Derivatives/mouse/H_structural.csv');