#!/bin/bash

# convert txt to design matrix via command Text2Vest DesignMatrix
DesignDir=$(pwd)
StatsDir=/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/TBSS_analysis/stats
RandDir=${StatsDir}/GSAA2AxSA2xS
Indicators=("FA" "MD" "AD" "RD" "06LDHs" "07LDHk")
ContrastNum=6

mkdir ${RandDir}
cd ${DesignDir}
Text2Vest B2_Contrast.txt B2_Contrast.con
Text2Vest B2_ftest.txt B2_ftest.fts

for indi in "${Indicators[@]}"
do
# generate design matrix
echo "------convert ${indi}-------"
Text2Vest B2_Design.txt B2_Design.mat

RandIndiDir=${RandDir}/${indi}
mkdir ${RandIndiDir}
cp B2_Design.mat ${RandIndiDir}/Design_${indi}.mat
cp B2_Contrast.con ${RandIndiDir}/contrast.con
cp B2_ftest.fts ${RandIndiDir}/ftest.fts
done

# randomise for t-test and f-test DesignMatrix
for indi in "${Indicators[@]}"
do
randomise -i ${StatsDir}/all_${indi}_skeletonised.nii.gz \
	-o ${RandDir}/${indi}/${indi} \
	-m ${StatsDir}/mean_FA_skeleton_mask.nii.gz \
	-d ${RandDir}/${indi}/Design_${indi}.mat \
	-t ${RandDir}/${indi}/contrast.con \
	-n 5000 -x --T2 -R --uncorrp -D &
done