% This project provided the sample codes for the 
% two-step task-related component analysis (TSTRCA)-based steady
% -state visual evoked potential (SSVEP) detection method [1]. 
% This project and codes was developed based on the standard TRCA[2].
%
% Dataset:
%   The SSVEP dataset used in this project consist of 35 subjects and
%   64 EEG channels. This dataset can be downloaded from 
%   http://bci.med.tsinghua.edu.cn/download.html 
%   and the detailed descriptions are provided by [2],[3].
%
%
% See also:
%   TSTRCA_process.m
%   first_step.m
%   second_step.m
%   itr.m
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
% Department of electronics and communications engineering, 
% Kwangwoon University
% E-mail: skgusrb12@kw.ac.kr


% path = 'path to SSVEP EEG dataset';
path = 'D:\research_source\Public_dataset\SSVEP\Thinghua University\filted_data\';

% # of time windows
win_size = 0.2:0.1:1;

% Visual latency being considered in the analysis [s]
win_delay = 0.14;

% 100*(1-alpha_ci): confidence intervals
alpha_ci = 0.05;

% Confidence interval
ci = 100*(1-alpha_ci);

for i = 1:length(win_size)
    
    fprintf('Results of the Two-Step TRCA-based method(win_size = %f).\n', win_size(i));
%     filename = [path, []]; % [] is SSVEP EEG data file
    filename = [path, sprintf('S%d.mat',1)]; % [] is SSVEP EEG data file

    load(filename);

    [acc, itrs] = TSTRCA_process(eeg, win_size(i), win_delay);

    [mu_acc, ~, mu_ci_acc, ~] = normfit(acc, alpha_ci);
    fprintf('Average accuracy = %2.2f %% (%2d%% CI: %2.2f - %2.2f %%)\n',...
    mu_acc, ci, mu_ci_acc(1), mu_ci_acc(2));

    [mu_itr, ~, mu_ci_itr, ~] = normfit(itrs, alpha_ci);
    fprintf('Average ITR = %2.2f bpm (%2d%% CI: %2.2f - %2.2f bpm)\n',...
    mu_itr, ci, mu_ci_itr(1), mu_ci_itr(2));
    fprintf('===============================================================\n\n');

end




