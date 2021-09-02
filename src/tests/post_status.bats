# Runs prior to every test
setup() {
    source ./src/tests/mocks/curl.sh
    source ./src/scripts/post_status.sh
}

@test '1: Posts a status check to Github' {
    export CIRCLE_PROJECT_USERNAME="test"
    export CIRCLE_PROJECT_REPONAME="test"
    export CIRCLE_SHA1="example"
    export GH_TOKEN="token"

    export STATE="success"
    export TARGET_URL="https://example.com"
    export DESCRIPTION="Test"
    export CONTEXT="test"

    result=$(echo $(PostStatus)|tr -d '\n')

    # Validate the body
    [ "$result" == '{ "state": "'"$STATE"'", "target_url": "'"$TARGET_URL"'", "description": "'"$DESCRIPTION"'", "context": "'"$CONTEXT"'" }' ]
}
