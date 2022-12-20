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

# What to run, and branch names
publish_dir="../published"
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
	exit 1
fi
commit_msg=`git log -1 --pretty=%B`

# Delete previous contents
rm -rf "${publish_dir}/*"

# Build a docker image, run it and copy out of it
publish_img=samlr_publish
docker build -t "${publish_img}" .
docker_container_id=$(docker run -d --rm --entrypoint sleep "${publish_img}" -- 30)

for item in $(docker exec "${docker_container_id}" ls /app/samlr_com/_site);
do
	docker cp "${docker_container_id}":"/app/samlr_com/_site/${item}" "${publish_dir}/${item}"
done
docker stop "${docker_container_id}"

# Move to the publishing dir 
cd "$publish_dir"
# Add everything (including new files)
git add -A
# Use the same commit message & push
git commit -m "$commit_msg"
git push
