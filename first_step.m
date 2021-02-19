function model = first_step(X, Fs)

% The frist step (training stage) of the two-step task-related component analysis (TSTRCA)-based 
% steady-state visual evoked potentials (SSVEPs) detection [1]. 
%
% function model = first_step(X, Fs)
%
% Input:
%   X       : Input SSVEP EEG data
%             (# of targets, # of channels, Data length [sample], # of trials)
%   Fs      : Sampling rate
%
%
% Output:
%   model   :  Learning model for tesing phase of the TSTRCA 
%                 
% See also:
%   second_step.m
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


if nargin < 2
    error('Not enough input arguments.'); 
end


[num_target, num_channel, num_sample, ~] = size(X);

trains = zeros(num_target, num_channel, num_sample);
W = zeros(num_target, num_channel);

for targ_i = 1:num_target
    
    eeg_tmp = squeeze(X(targ_i, :, :, :));
    trains(targ_i,:,:) = squeeze(mean(eeg_tmp, 3)); % reference signal
    w_tmp = trca(eeg_tmp);
    W(targ_i, :) = w_tmp(:, 1);
    
end 

model = struct('trains', trains, 'W', W,'fs', Fs, 'num_target', num_target);

end


function W = trca(X)

[num_channel, num_sample, num_trials]  = size(X);
S = zeros(num_channel);
for trial_i = 1:num_trials-1
    x1 = squeeze(X(:,:,trial_i));
    x1 = bsxfun(@minus, x1, mean(x1,2));
    for trial_j = trial_i+1:num_trials
        x2 = squeeze(X(:,:,trial_j));
        x2 = bsxfun(@minus, x2, mean(x2,2));
        S = S + x1*x2' + x2*x1';         
    end % trial_j
end % trial_i
UX = reshape(X, num_channel, num_sample*num_trials);
UX = bsxfun(@minus, UX, mean(UX,2));
Q = UX*UX';
[W,~] = eigs(S, Q);
    
end