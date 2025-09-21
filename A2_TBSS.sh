#!/bin/bash
# step_2: TBSS
SciPath=`pwd`
WkDir1=/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/TBSS_analysis

for WkDir in $WkDir1 
do
cd ${WkDir}
echo "-----------step 1 preproc-----------"
tbss_1_preproc *.nii.gz
echo "-----------step 2 reg select-----------"
tbss_2_reg -T
echo "-----------step 3 registration-----------"
tbss_3_postreg -S
echo "-----------step 4 generate skeleton for stats-----------"
tbss_4_prestats 0.2

tbss_non_FA MD
tbss_non_FA AD
tbss_non_FA RD
tbss_non_FA 06LDHs
tbss_non_FA 07LDHk
done