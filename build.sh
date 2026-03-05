#!/bin/bash

GIT_REPO_URL="https://github.com/4v3ngR/pluto_tv_scraper.git"
GIT_COMMIT="cf3c05f67002b1d1b4036dbaaa7d373405b4b5a6"
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