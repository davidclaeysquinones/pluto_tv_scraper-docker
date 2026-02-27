#!/bin/bash

GIT_REPO_URL="https://github.com/4v3ngR/pluto_tv_scraper.git"
GIT_COMMIT="f40908dd18f0f9ee6a770a35c3bea594ba524548"
BUILD_FOLDER="/build"
BIN_FOLDER=$"/bin/pluto"

apk add git
git clone --revision=$GIT_COMMIT $GIT_REPO_URL $BUILD_FOLDER
cd $BUILD_FOLDER
npm install -g npm@latest
npm install
npm install -g .
apk del git
#remove unnecessary files to run the binary to save space
rm -rf .git
rm config.json
rm LICENSE
rm README.md
rm package-lock.json
rm .gitignore