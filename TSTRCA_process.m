function [accs, itrs] = TSTRCA_process(data, win_size, win_delay)

% The frist step(training stage) of the two-step task-related component analysis (TSTRCA)-based 
% steady-state visual evoked potentials (SSVEPs) detection [1].
%
% function [accs, itrs] = TSTRCA_process(data, win_size, win_delay)
%
% Input:
%   data         : Input eeg data 
%                 (# of targets, # of channels, Data length [sample])
%   win_size     : Time windows
%   win_delay    : Visual latency being considered in the analysis
%
% Output:
%   acc      : Accuracy
%   itrs     : Information transfer rate (ITR)
%
%
% See also:
%   first_step.m
%   second_step.m
%
% Reference:
%   [1] H. K. Lee and Y.-S. Choi,
%       "Enhancing SSVEP-Based Brain-Computer Interface 
%        with Two-Step Task-Related Component Analysis",
%        Sensors, 21, 2021.
%   [2] M. Nakanishi, Y. Wang, X. Chen, Y.-T. Wang, X. Gao, and T.-P. Jung,
%       "Enhancing detection of SSVEPs for a high-speed brain speller using
%        task-related component analysis", 
%       IEEE Trans. Biomed. Eng, 65(1): 104-112, 2018.
%   [3] H. K. Lee and Y.-S. Choi,
%       "A Benchmark Dataset for SSVEP-Based Brain-Computer Interfaces",
%        IEEE Trans. Biomed. Eng, 25(10): 1746-1752, 2017.
%
% Hyeon Kyu Lee, 12-Feb-2021
% Kwangwoon University, Seoul, Republic of Korea
% E-mail: skgusrb12@kw.ac.kr


% List of stimulus frequencies
list_freqs = [8:1:15 8.2:1:15.2 8.4:1:15.4 8.6:1:15.6 8.8:1:15.8];
                                        
% The number of stimuli
num_targs = length(list_freqs);    

% Labels of data
labels = 1:num_targs;

% # of EEG channels
channel = 1:64; 

%% parameter

% Sampling frequency 
Fs = 250;            

% Stimuli start point
start_point = 0.5;

%% useful variables (DONT'T need to modify)

% Duration for gaze shifting [s]
len_shift_s = 0.5; 

% Selection time interval [s]
len_sel_s = win_size + len_shift_s;

%% preprocessing

segment_data = int32(Fs*(start_point+win_delay)+1 : Fs*(start_point+win_size+win_delay)); % 0.64s ~ 0.64s*d

for trial = 1:6
    for target = 1:size(data,3)
        ssvep_eeg(:,:,target,trial) = data(channel, segment_data, target, trial);
    end
end

ssvep_eeg = permute(ssvep_eeg, [3 1 2 4]);
[~, ~, ~, num_trial] = size(ssvep_eeg);

% Estimate classification performance
for trial = 1:num_trial
    
    % Frist step (Training stage)
    traindata = ssvep_eeg;
    traindata(:, :, :, trial) = [];
    model = first_step(traindata, Fs);
    
    % Second step (Test stage)
    testdata = squeeze(ssvep_eeg(:, :, :, trial));
    estimated = second_step(testdata, model);

    
    % Evaluation 
    is_correct = (estimated==labels);
    accs(trial) = mean(is_correct)*100;
    itrs(trial) = itr(num_targs, mean(is_correct), len_sel_s);
    fprintf('Trial %d: Accuracy = %2.2f%%, ITR = %2.2f bpm\n\n',...
        trial, accs(trial), itrs(trial));
    
end 

