#!/bin/sh  
  
#将@6倍图自动缩放为@1 @2 @3倍图
path="ProcessedImages"
if [[ ! -x "$path" ]]; then
	mkdir "$path"
fi
for img in  *.png
do  
  name1x=$path/${img%@*}@1x.png
  name2x=$path/${img%@*}@2x.png
  name3x=$path/${img%@*}@3x.png
  WIDTH=$(identify "${img}" | cut -f 3 -d " " | sed s/x.*//) #width
  HEIGHT=$(identify "${img}" | cut -f 3 -d " " | sed s/.*x//) #height
  echo "$WIDTH"
  echo "$HEIGHT"
  #计算出1倍图的大小
  echo "${name1x}"
  dw=$(echo "${WIDTH}/6" |bc)
  echo "$dw"
  dh=$(echo "${HEIGHT}/6" |bc)
  echo "$dh"
  convert -resize "$dwx""$dh" "${img}" "${name1x}"
  #计算出2倍图的大小
  echo "${name2x}"
  dw=$(echo "${WIDTH}/3" |bc)
  echo "$dw"
  dh=$(echo "${HEIGHT}/3" |bc)
  echo "$dh"
  convert -resize "$dwx""$dh" "${img}" "${name2x}"
  #计算出3倍图的大小
  echo "${name3x}"
  dw=$(echo "${WIDTH}/2" |bc)
  echo "$dw"
  dh=$(echo "${HEIGHT}/2" |bc)
  echo "$dh"
  convert -resize "$dwx""$dh" "${img}" "${name3x}"
  rm "$img"
done
