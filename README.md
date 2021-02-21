# Two-Step Task-Related Component Analaysis (TSTRCA)

> contact : skgusrb12@gmail.com
> 
> This project provides the sample codes of two-step task-related component analysis (TSTRCA)-based algorithm for recognizing steady-state visual evoked potential (SSVEPs) [1].

## 1. Introduction

This 

If you want to run this code, which download the SSVEP EEG dataset from http://bci.med.tsinghua.edu.cn/


## 2. Usage

- main_TSTRCA.m : main script of this sample code
- TSTRCA_process.m : the main script of TSTRCA
- first_step.m : Training stage of TSTRCA
- second_step.m : Classifying SSVEP target frequnecy using TSTRCA-based ensemble classifier
- itr.m : Calculating information transfer rate (ITR)


## 3. References

[1] H.K. Lee and Y.-S. Choi, [Enhancing SSVEP-Based Brain-Computer Interface with Two-Step Task-Related Component Analysis](https://www.mdpi.com/1424-8220/21/4/1315), *Sensors*, 21(4), Jan 2021 

[2] M. Nakanishi, Y. Wang, X. Chen, Y. -T. Wang, X. Gao, and T.-P. Jung, [Enhancing detection of SSVEPs for a high-speed brain speller using task-related component analysis](https://ieeexplore.ieee.org/document/7904641), IEEE Trans. Biomed. Eng, 65(1): 104-112, 2018.

[3] https://github.com/mnakanishi/TRCA-SSVEP
