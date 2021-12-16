#!/usr/bin/bash

sp=$1

echo ${sp}

module purge && module load deeptools

fileList=($(ls ./Bam/*_dm6_trim_q5_dupsMarked_sorted.bam | grep -i ${sp}))
echo ${fileList[@]}
	for file in ${fileList[@]}
		do
		tmp=${file##*/}
		basename=${tmp%%_dm6*}
		list+=(${tmp})
		#list+=(${basename})
		list=($(echo "${list[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
		echo ${tmp}
		done
 echo "list done"
	for sample in ${list[@]}
	do
		bamList+=("./Bam/${sample}")
		echo ${sample}
	done

echo "bam done!!"

multiBamSummary bins -b ${bamList[@]} -o Plots/${sp}_summary.npz --smartLabels -p 12

echo "Summary done!!"

plotPCA -in ./Plots/${sp}_summary.npz -o Plots/${sp}_PCA.eps

echo "plots done!!!"
echo "program done!!"

