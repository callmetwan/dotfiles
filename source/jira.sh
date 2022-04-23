#!/bin/bash


# Purpose:
# All Jira-related scripts and variables should live here

# This will prefix all JIRA issues.
# ex. Kazoo is: KAZ
export JIRA_ISSUE_PREFIX='KAZ'
export JIRA_TOKEN_AUTH=$(echo -n '<put_jira_username>:<put_jira_api_token>' | base64) # Always use an API token for the password, never an actual password!
export JIRA_URL='https://kazoohr.atlassian.net'

# Get the JIRA task name of the git branch.
# Highly useful for getting/sending data from JIRA's API.
function getJIRATaskName() {
  local branch=''
  if [[ ! -z "$1" ]]; then branch="$1"; else branch=$(getBranch); fi
  # echo "${branch}" | sed -n "s/^.*\/\(.*\)/\1/p" | OLD ONE
  echo "${branch}" | sed -En "s/^(.*\/)?(.*)/\2/p"
}

# Given a ticket of format: ABCD-XYZ, fetch the result and echo it out to be used elsewhere
function getJiraTicketMetadata() {
  if [ -z "$JIRA_TOKEN_AUTH" ]; then
    echo "Need a Jira Auth Token"
    exit 1
  fi

  if [ -z "$1" ]; then
    echo "Need to pass a jira ticket in the format of ABCD-XYZ"
    exit 2
  fi

  RES=$(curl --request GET \
    --url $JIRA_URL/rest/api/2/issue/"${1}" \
    --header "Authorization: Basic $JIRA_TOKEN_AUTH" \
    --header 'Content-Type: application/json')

  echo "$RES"
}

# Create a new git branch based off of a Jira ticket ID
function getiss() {
  if [[ -z "$1" ]]; then
    echo -e "\nUsage:\n"
    echo -e "\tgetiss 1234\t\tFetch ${JIRA_ISSUE_PREFIX}-1234 from Jira"
    echo -e "\n"
    return
  fi

  ISSUE_KEY="$JIRA_ISSUE_PREFIX-$1"
  RES=$(getJiraTicketMetadata "$ISSUE_KEY")

  TITLE=$(echo "$RES" | jq -r '.fields.summary')

  # Create new branch
  git checkout -b "${ISSUE_KEY}"

  # Save to branch-map
  echo "${ISSUE_KEY}~-~$TITLE" >> "$BRANCH_MAP_FILE"

}

# Set the JIRA status for the branch-map for the branch currently checked out.
function getBranchMapTitle() {
  cat $BRANCH_MAP_FILE | grep $(getBranch) | awk -F ':' '{ print $3 }'
}

# Set the JIRA status for the branch-map for the branch currently checked out.
function setJiraStatus() {
  local BRANCH=''
  local TRANSITION=''
  # If no transition is provided, just exit
  if [[ -z "$1" ]]; then TRANSITION='No Status'; else TRANSITION="$1"; fi
  # Use passed-in branch, or use the current branch if none was passed-in.
  if [[ ! -z "$2" ]]; then BRANCH="$2"; else BRANCH=$(getBranch); fi

  # echo "(setJiraStatus) ${BRANCH}: Transition: ${TRANSITION}"

  # Don't operate on master branch
  if [[ "$BRANCH" == "master" ]]; then
    echo "Can't set status on master \n"
    return
  fi

  # If it's 'Selected for Development' switch it to 'SFD' because it's shorter.
  TRANSITION="${TRANSITION/Selected for Development/Selected for Dev}"

  # -i ""  Replace the matched sed pattern in-place. (The "" is OSX specific)
  # sed matching pattern -> /<Line Context>/s/<Regex Pattern>/<Text to paste>
  # `getBranch | awk -F '/' '{print $2}'` -> Get branch and replace the task|bug/ line so that I can use it for line context
  sed -i "" "/$(getJIRATaskName ${BRANCH})/s/:.*:/:[${TRANSITION}]:/" $BRANCH_MAP_FILE
}

#	WORK IN PROGRESS - NOT COMPLETE
#	Update a branch's map entry using passed-in variables. This is meant to be called from another
#	function—not necessarily from the cli itself.
#
#	--branch	- The branch on which to apply all updates
#	--name		- (Optional) Name
#	--status	- (Optional) Status
#	--descrip	- (Optional) Description
function updateBranchMap() {
  BRANCH="$1"
}

# Open the JIRA task associated with the branch currently checked out.
function openTask() {
  open "${JIRA_URL}/browse/$(getJIRATaskName)"
}

export -f getiss
