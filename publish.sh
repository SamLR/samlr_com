#!/bin/bash

# check that there are no uncommited changes
# Run Tachikoma and make sure it exits correctly

set -o errexit
set -u nounset

tachikoma_dir="externals/Tachikoma"
site_dir="samlr_com"
publish_dir="../published"
exe="python3 $tachikoma_dir/tachikoma.py samlr_com"
# exe="python3 test.py"
uncommited_changes="git status --porcelain --ignore-submodules"
if [[ $uncommited_changes ]]; then
	echo "There are uncommited changes, please commit them or revert them before publishing"
	$uncommited_changes
	exit 1
fi

# Re-run Tachikoma and generate the site
$exe 
cp -r $site_dir $publish_dir
echo "Now pushing to web"
cd $publish_dir
ls -l
# git push web
