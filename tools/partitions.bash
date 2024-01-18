#!/usr/bin/env bash
path="$1"
part="$2"
# BYT;
# /run/media/user/546B-6466/HPP-L55B-2-2024-01-17/meid-f028bda62ca235ec4d569c853a00c06f/2024-01-17T1300-0800.img:15634268160B:file:512:512:gpt::;
# 1:32768B:1081343B:1048576B::boot_para:;
parted -m "$path" unit B print | sed -ne 's/\(.*\):\(.*\)B:\(.*\)B:\(.*\)B:.*:\(.*\):.*;/\1 \5 \2 \4/p' | while read num name offset size
do
    if [ "$part" == "" ]
    then
        echo "$num" "$name" "$offset" "$size"
    elif [ "$name" == "$part" ] || [ "$num" == "$part" ]
    then
        dd if="$path" iflag=skip_bytes,count_bytes skip="$offset" count="$size" status=none
    fi
done
