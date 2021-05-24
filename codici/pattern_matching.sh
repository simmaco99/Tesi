#!/bin/bash
file="3nodi.txt"

for i in {1..33}
do
    a=`sed -n "${i}p" pattern3nodi.txt`
    sed -i -e "s|$a|y($i)|g" $file
done

sed -i -e "s|spa||g" $file
sed -i -e "s|dot{y|f|g" $file
sed -i -e "s|&||g" $file
sed -i -e "s|*+|+|g" $file
