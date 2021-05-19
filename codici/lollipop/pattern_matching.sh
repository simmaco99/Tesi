#!/bin/bash
for i in {1..33}
do
    a=`sed -n "${i}p" patterncut.txt`
    sed -i -e "s|$a|y($i)|g" matlabcut.txt
done

sed -i -e "s|spa||g" matlabcut.txt

