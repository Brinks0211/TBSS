#!/bin/bash


Indicators=("FA" "MD" "AD" "RD" "06LDHs" "07LDHk")
#ContrastNum=

StatsDirList=("/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/TBSS_analysis/stats")
RandDirList=("/home/wangkangchengps/local/zhangyihao/HYDRA_Analysis/TBSS_analysis/stats" )

#fill & short cut
for (( j=0; j<1; j++ ));
do
for Cov in GSAA2AxSA2xS;
    do
    RandDir=${RandDirList[$j]}/${Cov}
    ImageDir=${RandDir}/ArticleResPic
    mkdir ${ImageDir}
    for indi in "${Indicators[@]}";
    do
    echo "-------${StatsDirList[$j]}--------\n-----short cut--${indi}--------"
    cd ${RandDir}/${indi}
        Files=`ls *tfce_corrp_tstat*_fill.nii.gz`
        for file in ${Files}
        do
        echo "---------shortcut ${file}-----------"
        PicName=`basename ${file} .nii.gz`
        for num in -15 0 15 30 45 60
        do
        fsleyes render -of ${ImageDir}/${PicName}_z${num}_yr.png \
	    --scene ortho --hideLabels --worldLoc 1 1 ${num} \
	    --showLocation no --layout horizontal \
	    --hidex --hidey --hideCursor \
	    --size 600 800 \
            ${StatsDirList[$j]}/mean_FA \
            ${StatsDirList[$j]}/mean_FA_skeleton.nii.gz -cm green -dr 0.2 0.8  \
            ${file} -cm red-yellow
        done
        for num in -15 0 15 30 45 60
        do
        fsleyes render -of ${ImageDir}/${PicName}_z${num}_blue.png \
	    --scene ortho --hideLabels --worldLoc 1 1 ${num} \
	    --showLocation no --layout horizontal \
	    --hidex --hidey --hideCursor \
	    --size 600 800 \
            ${StatsDirList[$j]}/mean_FA \
            ${StatsDirList[$j]}/mean_FA_skeleton.nii.gz -cm green -dr 0.2 0.8  \
            ${file} -cm blue-lightblue
        done
        done
    done
done
done

