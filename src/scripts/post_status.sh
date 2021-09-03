#!/bin/sh

PostStatus() {
    [ -n "${CONTEXT}" ] || CONTEXT="circleci/$CIRCLE_JOB"

    # Export the latest values for CONTEXT and DESCRIPTION so later calls
    # don't need to set them explicitly again
    echo "export GITHUB_STATUS_CONTEXT='$CONTEXT'" >> "$BASH_ENV"
    echo "export GITHUB_STATUS_DESCRIPTION='$DESCRIPTION'" >> "$BASH_ENV"

    API=https://api.github.com
    USER=$CIRCLE_PROJECT_USERNAME
    REPO=$CIRCLE_PROJECT_REPONAME
    SHA=$CIRCLE_SHA1

    URL=$API/repos/$USER/$REPO/statuses/$SHA

    [[ $DEBUG ]] && echo "$URL"

    ACCEPT="Accept: application/vnd.github.v3+json"

    AUTH=circleci:$GH_TOKEN

    BODY='
        {
            "state": "'"$STATE"'",
            "target_url": "'"$TARGET_URL"'",
            "description": "'"$DESCRIPTION"'",
            "context": "'"$CONTEXT"'"
        }
    '

    [[ $DEBUG ]] && echo "$BODY"

    curl -H "$ACCEPT" -u "$AUTH" -d "$BODY" -X POST "$URL"
}

# Will not run if sourced for bats-core tests
# View src/tests for more information
ORB_TEST_ENV="bats-core"
if [ "${0#*"$ORB_TEST_ENV"}" = "$0" ]; then
    PostStatus
fi
