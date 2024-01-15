#!/usr/bin/env bash

# "nvim session strategy"
#
# Same as vim strategy, see file 'vim_session.sh'

ORIGINAL_COMMAND="$1"
DIRECTORY="$2"

nvim_session_file_exists() {
    if [ -e "${DIRECTORY}/Session.vim" ]; then
        echo "${DIRECTORY}/Session.vim"
        return 0
    elif [ -e "${DIRECTORY}/.session.vim" ]; then
        echo "${DIRECTORY}/.session.vim"
        return 0
    else
        return 1
    fi
}

original_command_contains_session_flag() {
	[[ "$ORIGINAL_COMMAND" =~ "-S" ]]
}

main() {
	if SESSION_FILE=$(nvim_session_file_exists); then
		echo "nvim -S $SESSION_FILE"
	elif original_command_contains_session_flag; then
		# Session file does not exist, yet the original nvim command contains
		# session flag `-S`. This will cause an error, so we're falling back to
		# starting plain nvim.
		echo "nvim"
	else
		echo "$ORIGINAL_COMMAND"
	fi
}
main
