#!/bin/bash

# check that there are no uncommited changes
# Run Tachikoma and make sure it exits correctly

set -o errexit
set -u nounset

tachikoma="externals/Tachikoma/tachikoma.py"
site_dir="samlr_com"
publish_dir="../published"
exe="python3 $tachikoma $site_dir"
publish_repo="publish"
publish_branch="master"
uncommited_changes=`git status --porcelain --ignore-submodules`
if [[ $uncommited_changes ]]; then
	echo "There are uncommited changes, please commit them or revert them before publishing"
	echo "$uncommited_changes"
	exit 1
fi

commit_msg=`git log -1 --pretty=%B`

# Re-run Tachikoma and generate the site
$exe 
cp -r $site_dir/_site/* $publish_dir
echo "Now pushing to web"
cd $publish_dir
git add -A 
git commit -m "$commit_msg"
git push $publish_repo $publish_branch 
exit 
