#!/bin/bash

# Purpose:
# Centralize / organize all branch-related functions

# This function gives advanced details about the branches including a brief branch description that
# matches the JIRA description. This helps me remember what branches are used for.
# The file used to keep track of the branches' descriptions in $BRANCH_MAP_FILE
function git_branch_advanced() {
	echo # Starting line for easier-reading
	IDX=1 # The index used for numbering the branches

	# Loop each branch
	for branch in `git branch | sed "s/^. //"`; do
		# Reset the color variables for each line printed
		BRANCH_COLOR="${NC}" # The default branch color
		DESCRIPTION_COLOR="${PURP}" # The default description color
		NUMBER_COLOR="${ORANGE}" # The default number color
		STATUS_COLOR="${ORANGE}" # The color for the branch's JIRA status

		# -F changes the field parsing separator. The awk default is ' ' whitespace. However we can set it to be ':' for easier parsing of the map file
		# Grabbing branch description from branch-map file
		BRANCH_DESC="`cat $BRANCH_MAP_FILE | grep $branch | awk -F '~' '{ print $3 }'`"
		# Grab branch status from branch-map file.
		BRANCH_STATUS="`cat $BRANCH_MAP_FILE | grep $branch | awk -F '~' '{ print $2 }'`"

		# If the current branch, make it green.
		BRANCH_COLOR="${NC}"
		if [[ `getBranch` == $branch ]]; then
			BRANCH_COLOR="${SUCCESS_GREEN}"
			DESCRIPTION_COLOR="${SUCCESS_GREEN}"
			NUMBER_COLOR="${SUCCESS_GREEN}"
			STATUS_COLOR="${SUCCESS_GREEN}"
		fi

		# Print everything with colors and ish
		printf "${NUMBER_COLOR}%2s${NC} ${BRANCH_COLOR}%15s${NC} ${STATUS_COLOR}%-1s${NC} ${DESCRIPTION_COLOR}%s${NC}\n" "$IDX" "$branch" "$BRANCH_STATUS" "$BRANCH_DESC"
		IDX=$(($IDX + 1))
	done
	echo
}

# Checkout master
function gcm() {
  CURR_BRANCH=$(getBranch)
  gc master
}

function gcd() {
  CURR_BRANCH=$(getBranch)
  gc development
}

# Checkout the previous branch. Only really works when using gcm()
function gcp() {
  gc $CURR_BRANCH
}

# Get the name of the branch currently checked-out.
# Ex. task/CBT-3501
function getBranch() {
  local branch=$(git symbolic-ref HEAD 2>/dev/null)
  # The ${parameter##word} pattern returns the parameter after deleting the shortest (#) or longest (##) match of word
  echo "${branch##refs/heads/}" # if branch ==  refs/heads/master -> return master
}

# This function acts as an advanced git checkout command
# gc {number} - Will checkout the branch at number as listed by the git_branch_advanced command
# gc {string} - Will checkout any branch that matches the string as a normal git checkout would work
function gc() {
  # If a number, do the fancy line-checkout
  if [[ $1 =~ ^[0-9]+$ ]]; then
    # Take the branch at line number ${1} and return it, then pipe that to replace all leading spaces and '*' chars
    branch=$(git branch | sed "${1}q;d" | sed 's/^[ \*]*//')
    git checkout $branch
  # If not a number, regular ol checkout
  else
    git checkout "$@" # The "$@" passes ALL args to the function. This is useful for overloading a method like we've done here
  fi
}

# Rebase the current branch off of master
function rbm() {
  CURR_BRANCH=$(getBranch)
  gcm # Checkout master
  printf "${CYAN}-------- Updating Master ----------${NC}\n"
  git pull # Update master
  gc "$CURR_BRANCH"
  git rebase master # Rebase feature branch
  printf "${CYAN}------ Successfully Rebased -------${NC}\n"
  # All successful
}

# Delete branch even if you're on it currently
#   $1 (optional) {Number} - The corresponding branch number to delete
#   -	If $1 is not a number passed in, then it will attempt to delete the branch you're on.
function delbr() {
  # If passed a number, delete the branch corresponding with that number.
  # Else, try to delete the current branch.
  if [[ $1 =~ ^[0-9]+$ ]]; then
    branch=$(git branch | sed "${1}q;d" | sed 's/^[ \*]*//')
  else
    branch=$(getBranch) # Current branch
  fi

  echo # Newline
  echo "Attempting to delete:"
  echo # Newline
  # Print <branchName> - <branchDescription>
  echo -e "$CYAN${branch}$NC - $GREEN$(cat $BRANCH_MAP_FILE | grep $branch | awk -F '~' '{ print $3 }')$NC"
  echo # Newline
  read -p "$(echo -e $ORANGE"Delete? "$NC"(y/n) ")" -r
  # The =~ expression does a RegEx test on the pattern to the right
  if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Not deleting branch."
    return
  fi

  if [[ "$branch" == $(getBranch) ]]; then
    # You're on the same branch you're trying to delete,
    # so switch to development first, and then delete
    gcm
    git branch -D $branch
    removeBranchFromMap "$branch"
  else
    # You're on a different branch, so you can delete without switching branches
    git branch -D $branch
    removeBranchFromMap "$branch"
  fi
}

# @param 1 - Key with which to map branch in map
function removeBranchFromMap() {
  # -i removes the line inline rather than printing results
  # The .bak gives macos a backup suffix for the file: https://stackoverflow.com/a/7573438/6535053
  sed -i.bak "/$1/d" $BRANCH_MAP_FILE # Remove that branch from branch-map
  echo "Removed $1 from branch map"
}


export -f git_branch_advanced
