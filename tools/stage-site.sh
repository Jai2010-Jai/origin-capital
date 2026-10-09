#!/usr/bin/env bash
# Copies only what the live site needs into dist/ (what Netlify publishes):
# index.html, the frame manifest, the web frames and the hero film (video, poster, end frame). Source clips, drafts and tools stay local.
#
#   tools/stage-site.sh && netlify deploy --prod
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf dist && mkdir -p dist/film
cp index.html dist/
cp film/manifest.js dist/film/
cp -R film/frames dist/film/frames
mkdir -p dist/film/intro && cp film/intro/intro.mp4 film/intro/poster.webp film/intro/end.webp dist/film/intro/
mkdir -p dist/film/audio && cp film/audio/firebird-finale.m4a dist/film/audio/
mkdir -p dist/film/after && cp film/after/*.webp dist/film/after/
mkdir -p dist/film/og && cp film/og/og.png dist/film/og/
du -sh dist | awk '{print "dist/ " $1}'
