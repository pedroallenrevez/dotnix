#!/run/current-system/sw/bin/bash
EXT=$1
for FILE in $(find $2 | grep -e "\.$EXT"); do
  echo $FILE
  rm "$FILE"
done
rm -rf docs
rm toread
