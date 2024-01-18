#!/usr/bin/env bash
SCRIPTS="$(dirname "$0")"
path="$1"
set -e

ANDROID_DYNPARTS="$(type -p parse-android-dynparts)"
loop=$(sudo losetup --show -r -P -f "$path")
supernum=$(sudo parted -m "$path" print | sed -ne 's/\([^:]*\):.*:super:.*/\1/p')
dev="$loop"p"$supernum"

dynparts="$(sudo "$ANDROID_DYNPARTS" "$dev" | sed "s/dynpart-/${dev##*/}-/g" )"
sudo dmsetup create --concise "$dynparts"
echo "$dynparts" | sed 's!\([^;,]*\),,,[^;]*!/dev/mapper/\1!g' | tr ';' '\n'
