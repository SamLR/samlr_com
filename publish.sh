#!/bin/bash

#
# Sam Cook 2013-05-28
# CC-BY-SA
#
# This script will check that we're on the production branch, 
# fully commited then re-run the Tachikoma generation script
# and push it (via git) live
# 

# Exit on errors and unassigned variables
set -o errexit
set -u nounset

# Where stuff is
copy_src="samlr_com/_site/*"
publish_dir="../published"

# What to run, and branch names
build_cmd="gulp build"
publish_repo="publish"
publish_branch="master"
# Checks that we're on the right branch & everything's commited 
uncommited_changes=`git status --porcelain --ignore-submodules`
current_branch=`git rev-parse --abbrev-ref HEAD`
if [[ $uncommited_changes ]]; then
	echo "There are uncommited changes, please commit them or revert them before publishing"
	echo "$uncommited_changes"
	exit 1
elif [[ $current_branch != $publish_branch ]]; then
	echo "On, $current_branch, not master branch, change and try again"
	# exit 1
fi
commit_msg=`git log -1 --pretty=%B`

echo "Add JS accordion"
echo "Re-write 'about me'"

# Run the build process
$build_cmd
# Delete previous contents
rm -rf $publish_dir/*
# Copy everything across (git will still diff properly)
cp -r $copy_src $publish_dir
exit 1
# Move to the publishing dir 
cd $publish_dir
# Add everything (including new files)
git add -A 
# Use the same commit message & push
git commit -m "$commit_msg"
git push $publish_repo $publish_branch 
