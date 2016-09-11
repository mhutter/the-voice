#!/bin/sh
# Build and upload a jekyll site

set -e

### SETUP
if [ $(uname -s) == "Darwin" ]; then ECHO='echo'; else ECHO='echo -e'; fi
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
function green() { $ECHO "$GREEN$*$NORMAL"; }

cd "$(dirname $0)/.."

green '---> clean compressed files...'
find _site -iname '*.gz' -type f -delete -print

green '---> Building site...'
bundle exec jekyll build

green '---> compress all html, css and js files...'
files=$(find _site -iname '*.html' -o -iname '*.css' -o -iname '*.js')
for f in $files; do
  gzip --no-name --best --keep --verbose $f
done

green '---> upload site...'
rsync -avz --delete _site/ the-voice.cc:public_html/the-voice.cc/

green '---> Done!'
