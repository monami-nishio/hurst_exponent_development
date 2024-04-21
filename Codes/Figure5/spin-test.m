
addpath(genpath('../Scripts/ENIGMA/matlab/scripts/permutation_testing'))

concat_adult  = readtable('../../Derivatives/adult/original.csv');
concat_child  = readtable('../../Derivatives/childhood/original_motion_0.5mm.csv');

[fc_ctx_p, fc_ctx_d] = spin_test(concat_child.part, concat_child.H, surface_name='fsa5', parcellation_name='schaefer_400',type='pearson', n_rot=1000); 
disp(fc_ctx_p)

[fc_ctx_p, fc_ctx_d] = spin_test(concat_adult.part, concat_adult.H, surface_name='fsa5', parcellation_name='schaefer_400',type='pearson', n_rot=10000);
disp(fc_ctx_p)
