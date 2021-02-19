function result = second_step(X, model)

% The second step (test stage) of the two-step task-related component analysis (TSTRCA)-based 
% steady-state visual evoked potentials (SSVEPs) detection [1]. 
%
% function model = first_step(X, Fs)
%
% Input:
%   X         : Input SSVEP EEG data 
%               (# of targets, # of channels, Data length [sample])
%   model     : Learning model for tesing phase of the TSTRCA
%
%
% Output:
%   result    : target estimated by the TSTRCA
%
%
% Reference:
%   [1] H. K. Lee and Y.-S. Choi,
%       "Enhancing SSVEP-Based Brain-Computer Interface 
%        with Two-Step Task-Related Component Analysis",
%        Sensors, 21, 2021.
%
%
% Hyeon Kyu Lee, 12-Feb-2021
% Kwangwoon University, Seoul, Republic of Korea
% E-mail: skgusrb12@kw.ac.kr



if ~exist('model', 'var')
    error('Training model based on TSTRCA is required. See first_step.m'); 
end

for targ_i = 1:model.num_target
    testdata = squeeze(X(targ_i, :, :));
    for class_i = 1:model.num_target
        traindata =  squeeze(model.trains(class_i, :, :));
        for class_k = 1:model.num_target+1
            if class_k == 1
                r_tmp = corrcoef((testdata)', (traindata)');
            else
                w = squeeze(model.W(class_k-1, :));
                r_tmp = corrcoef((w*testdata)', (w*traindata)');
            end
            r(class_k) = sign(r_tmp(1,2))*(r_tmp(1,2)).^2;
        end %class_j(weight)
        beta_r(class_i) = sum(r);        
    end % class_i(indivisual template)
    rho = beta_r;
    [~, tau] = max(rho);
    result(targ_i) = tau;
end % targ_i

end