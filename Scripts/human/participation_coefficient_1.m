%% For each parcellation and each pipeline
pipeline='connectivity';
parcellation='schaefer400';
subjlist=readtable(strcat('../dataset/QA_revision.csv'),'Delimiter',',','ReadVariableNames', 1);
dim=str2double(parcellation(end-2:end));%what is the dimensionality of the parcellation
timeseries = dir('../dataset/childhood/correlation/sub*.tsv');
%running with the cluster mounted locally
datadir='../dataset/childhood/correlation';
z_outdir='../dataset/childhood/connectivity';

%make directories if they do not exist
if ~exist(z_outdir, 'dir')
    mkdir(z_outdir)
end

%% Z-score FC matrices
for n=1:height(subjlist)
    sub=char(subjlist.sub(n)); 
    run=num2str(subjlist.run(n)); 
    file=fullfile('../dataset/childhood/correlation', strcat('sub-', sub, '_ses-01_task-rest_run-', run, '_space-MNI152NLin6Asym_atlas-Schaefer417_measure-pearsoncorrelation_conmat.tsv'));
    outfile=fullfile(z_outdir, strcat(sub,'_','run-0',run,'_',parcellation,'MNI_znetwork.txt'));
    if (exist(outfile)==2) %if it's already written don't do it again
        fprintf('Sub %s already exists. \n', sub);
    else
        subfcmat=readtable(file, "FileType","text",'Delimiter', '\t', 'EmptyValue',0);
        subfcmat=subfcmat(:,2:width(subfcmat));
        fprintf('Loaded file 1');
        %replace the diagonal of 1's with 0's
        for i=1:width(subfcmat)
            if isequal(class(subfcmat.(i)(1)),'cell')
                subfcmat.(i)=zeros(height(subfcmat),1);
            end
        end
        for x=1:dim
            subfcmat.(x)(x)=0;
        end
        %create an empty z-matrx
        zfc=subfcmat;
        for i=1:dim
            %cycle through each column of the FC matrix and do a fisher r-to-z
            %for each value
            zfc.(i)=fisherz(subfcmat.(i));
        end
        outfile=fullfile(z_outdir, strcat(sub,'_','run-0',run,'_',parcellation,'MNI_znetwork.txt'));
        writetable(zfc,outfile);
    end
end