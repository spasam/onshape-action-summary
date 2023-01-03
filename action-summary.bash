#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o xtrace

# ${to} can be a space separated list of email addreses
#btPython3 buildSrc/tools/python/send-build-change-report ${to}

# Summary
'
{
    lastSHA=${LAST_SUCCESSFUL_COMMIT:0:$SHORT_SHA_LENGTH}
    shortSHA=$(gitShortSHA)
    range="${lastSHA}...${shortSHA}"

    echo "Building \`${GITHUB_REF_NAME}\` [newton@${shortSHA}](https://github.com/${GITHUB_REPOSITORY}/commit/$(gitSHA)) as ${NEWTON_VERSION}.${GITHUB_RUN_NUMBER}.${shortSHA}"
    echo
    echo "Change set [${range}](https://github.com/${GITHUB_REPOSITORY}/compare/${range})"
    echo '```'
    git log --cherry-pick --first-parent --reverse ${LAST_SUCCESSFUL_COMMIT}..HEAD
    echo '```'

} >> $GITHUB_STEP_SUMMARY
'

# Summary
{
    echo "OUTPUT: "
    echo ${INPUT_STRING}

} >> $GITHUB_STEP_SUMMARY