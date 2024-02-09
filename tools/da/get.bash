#!/usr/bin/env bash

echo "This does mega.nz files a bit but breaks when it hits another like google drive"
echo "Also, the scraping format is not ideal some links are missed when tightly next to each other. i might instead have grep output offsets, then process each offset separately using preceding bytes to make a descr str."

set -e

DIR=00
mkdir -p "$DIR"
num=0

grep -r redirectcode --before=1 www.hovatek.com | grep -v '^--$' | 
    sed -e 's/^.*\.html[-:]//' |
while read a; do read b; echo "$a" "$b"; done | #sed 's/^.*\.html[-:]\(.*\)/\1/; s/ *<[^a][^>]*> *//g; s/.*<a *href="\(.[^"]*\)" .*/\1/;' | 
    sed \
        -e 's/<p>[^<]*<\/p>//' \
        -e 's/^\(.*\) *<a *href="https:\/\/www.hovatek.com\/redirectcode.php?link=\(.[^"]*\)"[^>]*>[^<]*<\/a>/\2 \1/' \
        -e 's/<[^>]*>//g;' |
while read b64url desc
do
    url="$(base64 -d <<<$b64url)"
    NUM="$(printf %0.4d $num)"
    echo "$desc" | tee "$DIR"/"$NUM".txt
    echo "$url"
    mega-get "$url" "$DIR"/"$NUM"
    num=$((num+1))
done
#www.hovatek.com/forum/thread-34324.html-<h2>Download Infinix NOTE 7 X690 / X690B / X690C stock rom / firmware below</h2><br/>
#www.hovatek.com/forum/thread-34324.html-<br/>
#www.hovatek.com/forum/thread-34324.html:<h3> Infinix Note 7 X690 (X690-H691BCFG-Q-GL-200522V300) [Factory / Signed]</h3><ul class="mycode_list"><li><span style="font-weight: bold;" class="mycode_b">Boot.img:</span> <a href="https://www.hovatek.com/redirectcode.php?link=aHR0cHM6Ly9tZWdhLm56L2ZpbGUvd3I0bDJJcEojWGJTSVAtZnlPb0FyVDZURjI1cUM5b0NleGktOG5tV0lXZWEtRTJ5RDFqWQ==" target="_blank" rel="noopener" class="mycode_url">https://mega.nz/file/wr4l2IpJ#XbSIP-fyOo...ea-E2yD1jY</a><br/>
#www.hovatek.com/forum/thread-34324.html-</li>
#www.hovatek.com/forum/thread-34324.html:<li><span style="font-weight: bold;" class="mycode_b">Recovery.img:</span> <a href="https://www.hovatek.com/redirectcode.php?link=aHR0cHM6Ly9tZWdhLm56L2ZpbGUva25oRmlLREwjY1M2eDJNR3N3cjJZdS14MHZnUjM2Vy1BUFpXMjV1bElFVWxLNnE0NGhIZw==" target="_blank" rel="noopener" class="mycode_url">https://mega.nz/file/knhFiKDL#cS6x2MGswr...UlK6q44hHg</a><br/>
#www.hovatek.com/forum/thread-34324.html-</li>
#www.hovatek.com/forum/thread-34324.html:<li><span style="font-weight: bold;" class="mycode_b">Dtbo:</span> <a href="https://www.hovatek.com/redirectcode.php?link=aHR0cHM6Ly9tZWdhLm56L2ZpbGUvSTM1VlJBQVEjYXhQOUVxTVRuckRXSGxVZXpMVFpqUW9lTGVBb3RUQl9fdW5tSmhjSXNQYw==" target="_blank" rel="noopener" class="mycode_url">https://mega.nz/file/I35VRAAQ#axP9EqMTnr...unmJhcIsPc</a><br/>
#www.hovatek.com/forum/thread-34324.html-</li>
#www.hovatek.com/forum/thread-34324.html:<li><span style="font-weight: bold;" class="mycode_b">LK.bin:</span> <a href="https://www.hovatek.com/redirectcode.php?link=aHR0cHM6Ly9tZWdhLm56L2ZpbGUvTno0SEJDREMjajNhQUtLOHc0ZDNuS2taRmFkUXRnN1BwM2FVMVctRTV1bkdBQnZ4OGNPTQ==" target="_blank" rel="noopener" class="mycode_url">https://mega.nz/file/Nz4HBCDC#j3aAKK8w4d...nGABvx8cOM</a><br/>
#www.hovatek.com/forum/thread-34324.html-</li>
