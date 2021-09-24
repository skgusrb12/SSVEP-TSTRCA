# Two-step Task-Related Component Analysis (TSTRCA)
>Hyeon Kyu Lee : skgusrb12@kw.ac.kr
>
>This project provide the source code for this study: [Enhancing SSVEP-Based Brain-Computer Interface with Two-Step Task-Related Component Analysis](https://www.mdpi.com/1424-8220/21/4/1315)

## 1. Introduction

**To 

The project consists of three modes: `main_TSTRCA`, `TSTRCA_process`, `first_step`, `second_step` and `itr`.

## 3. Run this project

This mode is used to create input image data including the four features(MFCC, MFCC-△, MFCC-△2, RMSE of mel-spectogram) of VAD model.\

**The parameter lists and defaults of this mode**
```
- raw_data : raw data (e.g. LibriSpeech ASR corpus dataset)
- labels : labels of voice and non-voice
- save_dir : the file for saving the input images
- test_img_ratio : the ratio of test data from total input data
- parallel : using the cpu parallel processing, 'True' and 'False'
```

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
