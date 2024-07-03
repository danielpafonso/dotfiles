#!/bin/sh

apply_dotfile(){
	# $1 -> source file
	# $2 -> destination file
	# $3 -> folder operation
	mkdir -p $(dirname $2)
	if [ "$3" != "" ]; then
		## check for folder existence
		if [ -d "$2" ]; then
			## check if folder is a symlink
			if [ -L "$2" ]; then
				rm $2
			else
				## backup file
				mv $2 $2.bak
			fi
		fi
	else
		## check for file existence
		if [ -f "$2" ]; then
			## check if file is a symlink
			if [ -L "$2" ]; then
				rm $2
			else
				## backup file
				mv $2 $2.bak
			fi
		fi
	fi

	## create symlink
	if [ $CREATE_SYMLINK -eq 1 ]; then
		ln -s $1 $2
	else
		if [ "$3" != "" ]; then
			cp -r $1 $2
		else
			cp $1 $2
		fi
	fi
}

handle_ctrlc (){
	tput rmcup
	exit 2
}

install_configs(){
	if [ "$ZSH_INSTALL" != " " ]; then
		apply_dotfile "$ZSH_CONFIG" "$ZSH_PATH"
	fi
	if [ "$ZSH_THEME_INSTALL" != " " ]; then
		apply_dotfile "$ZSH_THEME_CONFIG" "$ZSH_THEME_PATH"
	fi
	if [ "$ZSH_PLUGIN_INSTALL" != " " ]; then
		apply_dotfile "$ZSH_PLUGIN_CONFIG" "$ZSH_PLUGIN_PATH" folder
	fi
	if [ "$BASHRC_INSTALL" != " " ]; then
		apply_dotfile "$BASHRC_CONFIG" "$BASHRC_PATH"
	fi
	if [ "$SHELL_ALIASES_INSTALL" != " " ]; then
		apply_dotfile "$SHELL_ALIASES_CONFIG" "$SHELL_ALIASES_PATH"
	fi
	if [ "$TMUX_INSTALL" != " " ]; then
		apply_dotfile "$TMUX_CONFIG" "$TMUX_PATH"
	fi
	if [ "$VIM_INSTALL" != " " ]; then
		apply_dotfile "$VIM_CONFIG" "$VIM_PATH"
	fi
	if [ "$NVIM_INSTALL" != " " ]; then
		apply_dotfile "$NVIM_CONFIG" "$NVIM_PATH"
	fi
	if [ "$NVIM_KICKSTART_INSTALL" != " " ]; then
		apply_dotfile "$NVIM_KICKSTART_CONFIG" "$NVIM_KICKSTART_PATH" folder
	fi
	if [ "$NVIM_LAZY_INSTALL" != " " ]; then
		apply_dotfile "$NVIM_LAZY_CONFIG" "$NVIM_LAZY_PATH" folder
	fi
	if [ "$FASTFETCH_INSTALL" != " " ]; then
		apply_dotfile "$FASTFETCH_CONFIG" "$FASTFETCH_PATH"
	fi
	files=""
	if [ "$NOTES_GOLANG" != " " ]; then
		files="${files} $NOTES_GOLANG_CONFIG"
	fi
	if [ "$NOTES_GIT" != " " ]; then
		files="${files} $NOTES_GIT_CONFIG"
	fi
	if [ "$NOTES_PROCESS_PORT" != " " ]; then
		files="${files} $NOTES_PROCESS_PORT_CONFIG"
	fi
	if [ "$NOTES_CLOUD" != " " ]; then
		files="${files} $NOTES_CLOUD_CONFIG"
	fi
	if [ "$NOTES_CURL" != " " ]; then
		files="${files} $NOTES_CURL_CONFIG"
	fi
	if [ "$NOTES_REGEX" != " " ]; then
		files="${files} $NOTES_REGEX_CONFIG"
	fi
	if [ "$NOTES_TERRAFORM" != " " ]; then
		files="${files} $NOTES_TERRAFORM_CONFIG"
	fi
	if [ "$files" != "" ]; then
		## local file
		mkdir -p ./local
		cat $files > ./local/notes.txt
		apply_dotfile "$PWD/local/notes.txt" "$NOTES_PATH"
	fi
}

## Banner
banner=$(cat << EOF
  ___        _     __  _  _
 |   \  ___ | |_  / _|(_)| | ___
 | |) |/ _ \|  _||  _|| || |/ -_)
 |___/ \___/ \__||_|  |_||_|\___|
     ___            _          _  _
    |_ _| _ _   ___| |_  __ _ | || | ___  _ _
     | | | ' \ (_-<|  _|/ _' || || |/ -_)| '_|
    |___||_||_|/__/ \__|\__,_||_||_|\___||_|
EOF
)

## Variables to control script
CREATE_SYMLINK=0
TPUT=$(which tput)

## load config file
. ./variables.sh

logLine=$(cat << EOF
Enter:
- install to apply changes
- quit to exit without making changes
- help to display the help message

EOF
)

if [ "$TPUT" != "" ]; then
	# save terminal state
	tput smcup
fi

# handle signal 2 (SIGINT)
trap "handle_ctrlc" 2

### Main entrypoint
while true; do
	# clear terminal
	clear
	printf "%s\n\n" "$banner"
	## Menu
	printf "Select components to install.\n"
	printf " 1) [%s] zshrc file\n    path: %s\n" "$ZSH_INSTALL" "$ZSH_PATH"
	printf " 2) [%s] zsh custom theme\n    path: %s\n" "$ZSH_THEME_INSTALL" "$ZSH_THEME_PATH"
	printf " 3) [%s] zsh custom git plugin\n    path: %s\n" "$ZSH_PLUGIN_INSTALL" "$ZSH_PLUGIN_PATH"
	printf " 4) [%s] bashrc\n    path: %s\n" "$BASHRC_INSTALL" "$BASHRC_PATH"
	printf " 5) [%s] shell aliases\n    path: %s\n" "$SHELL_ALIASES_INSTALL" "$SHELL_ALIASES_PATH"
	printf " 6) [%s] tmux\n    path: %s\n" "$TMUX_INSTALL" "$TMUX_PATH"
	printf " 7) [%s] vim\n    path: %s\n" "$VIM_INSTALL" "$VIM_PATH"
	printf " 8) [%s] Neovim, using vim-plug\n    path: %s\n" "$NVIM_INSTALL" "$NVIM_PATH"
	printf " 9) [%s] Neovim, using kickstart\n    path: %s\n" "$NVIM_KICKSTART_INSTALL" "$NVIM_KICKSTART_PATH"
	printf " 10) [%s] Neovim, using lazy.nvim\n    path: %s\n" "$NVIM_LAZY_INSTALL" "$NVIM_LAZY_PATH"
	printf " 11) [%s] Fastfetch\n    path: %s\n" "$FASTFETCH_INSTALL" "$FASTFETCH_PATH"
	printf " 12) [%s] notes (all)\n    path: %s\n" "$NOTES_ALL_INSTALL" "$NOTES_PATH"
	printf "  a) [%s] golang b) [%s] git c) [%s] process and ports d) [%s] clouds\n" "$NOTES_GOLANG" "$NOTES_GIT" "$NOTES_PROCESS_PORT" "$NOTES_CLOUD"
	printf "  e) [%s] curl f) [%s] regex g) [%s] terraform\n" "$NOTES_CURL" "$NOTES_REGEX" "$NOTES_TERRAFORM"
	printf "%s\n" "$logLine"
	#echo $logLine
	logLine=" "

	if [ "$CREATE_SYMLINK" -eq 0 ]; then
		printf "> "
	else
		printf "\e[1;36m> \e[m"
	fi
	read choice
	## operate on choice
	case $choice in
		1) ZSH_INSTALL=$([ "$ZSH_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 1")
			printf "\n zsh path> "
			read ZSH_PATH
			;;
		2) ZSH_THEME_INSTALL=$([ "$ZSH_THEME_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 2")
			printf "\n zsh theme path> "
			read ZSH_THEME_PATH
			;;
		3) ZSH_PLUGIN_INSTALL=$([ "$ZSH_PLUGIN_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 3")
			printf "\n zsh plugin path> "
			read ZSH_PLUGIN_PATH
			;;
		4) BASHRC_INSTALL=$([ "$BASHRC_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 4")
			printf "\n bashrc path> "
			read BASHRC_PATH
			;;
		5) SHELL_ALIASES_INSTALL=$([ "$SHELL_ALIASES_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 5")
			printf "\n shell aliases path> "
			read SHELL_ALIASES_PATH
			;;
		6) TMUX_INSTALL=$([ "$TMUX_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 6")
			printf "\n tmux path> "
			read TMUX_PATH
			;;
		7) VIM_INSTALL=$([ "$VIM_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 7")
			printf "\n vim path> "
			read VIM_PATH
			;;
		8) NVIM_INSTALL=$([ "$NVIM_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 8")
			printf "\n neovim path> "
			read NVIM_PATH
			;;
		9) NVIM_KICKSTART_INSTALL=$([ "$NVIM_KICKSTART_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 9")
			printf "\n neovim path> "
			read NVIM_KICKSTART_PATH
			;;
		10) NVIM_LAZY_INSTALL=$([ "$NVIM_LAZY_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 10")
			printf "\n neovim path> "
			read NVIM_LAZY_PATH
			;;
		11) FASTFETCH_INSTALL=$([ "$FASTFETCH_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 11")
			printf "\n fastfetch path> "
			read FASTFETCH_PATH
			;;
		12) if [ "$NOTES_ALL_INSTALL" = " " ]; then
				NOTES_ALL_INSTALL="*"
				NOTES_GOLANG="*"
				NOTES_GIT="*"
				NOTES_PROCESS_PORT="*"
				NOTES_CLOUD="*"
				NOTES_CURL="*"
				NOTES_REGEX="*"
				NOTES_TERRAFORM="*"
			else
				NOTES_ALL_INSTALL=" "
				NOTES_GOLANG=" "
				NOTES_GIT=" "
				NOTES_PROCESS_PORT=" "
				NOTES_CLOUD=" "
				NOTES_CURL=" "
				NOTES_REGEX=" "
				NOTES_TERRAFORM=" "
			fi
			;;
		"path 12")
			printf "\n notes path> "
			read NOTES_PATH
			;;
		"12a") NOTES_GOLANG=$([ "$NOTES_GOLANG" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"12b") NOTES_GIT=$([ "$NOTES_GIT" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"12c") NOTES_PROCESS_PORT=$([ "$NOTES_PROCESS_PORT" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"12d") NOTES_CLOUD=$([ "$NOTES_CLOUD" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"12e") NOTES_CURL=$([ "$NOTES_CURL" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"12f") NOTES_REGEX=$([ "$NOTES_REGEX" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"12g") NOTES_TERRAFORM=$([ "$NOTES_TERRAFORM" = "*" ] &&echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ] && [ "$NOTES_CLOUD" = "*" ] && [ "$NOTES_CURL" = "*" ] && [ "$NOTES_REGEX" = "*" ] && [ "$NOTES_TERRAFORM" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ] && [ "$NOTES_CLOUD" = " " ] && [ "$NOTES_CURL" = " " ] && [ "$NOTES_REGEX" = " " ] && [ "$NOTES_TERRAFORM" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;

		"install") install_configs
			break
			;;
		"help"|"h")
			logLine=$(printf "\n- Enter number to toogle config to install\n- Enter path folowed by rhe option number to modify the instalation path. ex: path 1\n ")
			;;
		"symlink") if [ "$CREATE_SYMLINK" -eq 0 ]; then
				CREATE_SYMLINK=1
				logLine=$(printf "\nInstall will create symlinks to configurations\n")
			else
				CREATE_SYMLINK=0
				logLine=$(printf "\nInstall will create copy of configurations\n")
			fi
			;;
		"quit"|"q") break ;;
		9) break ;;
		*) logLine=$(printf "\e[0;31mInvalid option selected\e[m\n")
			;;
	esac
done

if [ "$TPUT" != "" ]; then
	# restore terminal
	tput rmcup
fi
