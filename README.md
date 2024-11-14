# t-ANTV-for-Blind-Deblurring
This repository contains the codes and some of the datasets to reproduce the results from the paper "Blind Deconvolution via a Tensor Adaptive Non-convexTotal Variation Prior". 
All code is implemented in MATLAB. 

Abstract: Blind image deconvolution is a challenging task that aims to recover sharpimages from blurry ones without knowing the blur kernel.  Deblurring colorimages is even more difficult due to three color channels.  Existing deblurringmethods typically tackle each channel separately, treating them as individualgrayscale images and designing priors specifically for grayscale images.  How-ever, these methods need to consider the relationships between color chan-nels, leading to the need for a more precise estimation of blur kernels.  In thispaper, we have observed that the total variations of the three color channels ofan image exhibit low-rank characteristics, which can be effectively capturedusing the tensor decomposition framework.  To incorporate this observation,we propose a novel prior for color image deblurring.  Specifically, we definea new tensor product using an image-adaptive transform matrix and applya non-convex function to the tensor singular values to create a novel tensornorm.  Then, we present the new tensor adaptive non-convex total variationprior for image deblurring.  Numerically, we develop an efficient deblurringalgorithm based on the half-quadratic splitting scheme.  We provide detailedsolutions for each sub-problem.  Experimental results demonstrate that ourmethod  accurately  estimates  blur  kernels  and  produces  fewer  artifacts  onseveral benchmark datasets.

# Dataset
Three datasets used in the paper can be donwloaded from the following links. 

[Pan](https://jspan.github.io/projects/text-deblurring/index.html)

[Kohler](https://webdav.tuebingen.mpg.de/pixel/benchmark4camerashake/)

[Levin](https://webee.technion.ac.il/people/anat.levin/papers/LevinEtalCVPR09Data.rar)

# Demo
Run demo_text_antv.m to reproduce the results on Pan dataset. Similar demos for other datasets. 

# Citation
If our work is useful for your research, please cite our paper:
