#!/bin/bash


Indicators=("FA" "MD" "AD" "RD" "06LDHs" "07LDHk")
ContrastNum=6

StatsDirList=("/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/TBSS_analysis/stats")
RandDirList=("/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/TBSS_analysis/stats" )

#fill & short cut
for (( j=0; j<1; j++ ));
do
for Cov in GSAA2AxSA2xS;
    do
    RandDir=${RandDirList[$j]}/${Cov}
    ImageDir=${RandDir}/ResImage
    mkdir ${ImageDir}
    for indi in "${Indicators[@]}";
    do
    echo "-------${StatsDirList[$j]}--------\n-------${Cov}-${indi}--------"
    cd ${RandDir}/${indi}
        for ((i=1; i<=$ContrastNum; i++))
        do
        tbss_fill ${indi}_tfce_p_tstat${i}.nii.gz 0.95 ${StatsDirList[$j]}/mean_FA ${indi}_tfce_p_tstat${i}_fill &
        tbss_fill ${indi}_vox_p_tstat${i}.nii.gz 0.95 ${StatsDirList[$j]}/mean_FA ${indi}_vox_p_tstat${i}_fill 
    done

    echo "-------${StatsDirList[$j]}--------\n-----short cut--${indi}--------"
    cd ${RandDir}/${indi}
        Files=`ls *tfce_p_tstat*_fill.nii.gz`
        for file in ${Files}
        do
        echo "---------shortcut ${file}-----------"
        PicName=`basename ${file} .nii.gz`
        fsleyes render -of ${ImageDir}/${PicName}.png \
            --hideCursor --scene lightbox  \
            ${StatsDirList[$j]}/mean_FA \
            ${StatsDirList[$j]}/mean_FA_skeleton.nii.gz -cm green -dr 0.2 0.8  \
            ${file} -cm red-yellow 
        done
    done
done
done

