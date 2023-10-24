#!/bin/bash
cd ~/WebstormProjects/JS-Apprologic-$1/apps/$2
git pull
cd ../../
git pull
git checkout development
git add apps/$2
git commit -n -m "Update $2 Submodule"
git push
