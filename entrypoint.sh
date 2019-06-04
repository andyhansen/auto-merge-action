#!/bin/bash -l

set -eu

# Environment variable reference
# https://developer.github.com/actions/creating-github-actions/accessing-the-runtime-environment/#environment-variables

FROM_BRANCH="${FROM_BRANCH:=master}"
TO_BRANCH="${TO_BRANCH:=uat}"

# Exit early if we aren't on the branch we want to merge from
if [[ $GITHUB_REF != *"/${FROM_BRANCH}" ]]
then
  echo "Not on ${FROM_BRANCH}, exiting.";
  exit 0;
fi

# Merge the branches using the default commit message
# GitHub merge reference https://developer.github.com/v3/repos/merging/#perform-a-merge
curl -X POST \
  "https://api.github.com/repos/${GITHUB_REPOSITORY}/merges" \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{ \"base\": \"${TO_BRANCH}\", \"head\": \"${FROM_BRANCH}\" }"
