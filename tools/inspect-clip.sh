#!/usr/bin/env bash
# tools/inspect-clip.sh <url> <out.mp4>  — download a clip, write a contact sheet,
# first frame and last frame into $SCRATCH for review.
set -euo pipefail
url=$1; out=$2; s=${SCRATCH:-/tmp}; b=$(basename "$out" .mp4)
curl -sSL -o "$out" "$url"
ffprobe -v error -show_entries stream=codec_type,width,height,r_frame_rate,nb_frames -of compact "$out"
ffmpeg -v error -y -i "$out" -vf "fps=2,scale=320:-2,tile=4x2" -frames:v 1 "$s/$b-sheet.jpg"
ffmpeg -v error -y -i "$out" -frames:v 1 "$s/$b-first.png"
ffmpeg -v error -y -sseof -0.05 -i "$out" -frames:v 1 -update 1 "$s/$b-last.png"
