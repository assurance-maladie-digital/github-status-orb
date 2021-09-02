# Mock curl function to return only the body
function curl() {
    # The command will be called with these parameters:
    # -H "$ACCEPT" -u "$AUTH" -d "$BODY" -X POST "$URL"
    ACCEPT=$2
    AUTH=$4
    BODY=$6
    METHOD=$8
    URL=$9

    echo "$BODY"
}
