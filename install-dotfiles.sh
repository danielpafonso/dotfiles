#!/bin/sh

apply_dotfile(){
    # $1 -> source file
    # $2 -> destination file
    mkdir -p $(dirname $2)
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
    ## create symlink
	if [ $CREATE_SYMLINK -eq 1 ]; then
		ln -s $1 $2
	else
		cp $1 $2
	fi
}

install_configs(){
	## ZSH
	if [ "$ZSH_INSTALL" != " " ]; then
		apply_dotfile "$ZSH_CONFIG" "$ZSH_PATH"
	fi
	## ZSH Theme
	if [ "$ZSH_THEME_INSTALL" != " " ]; then
		apply_dotfile "$ZSH_THEME_CONFIG" "$ZSH_THEME_PATH"
	fi
	## Neovim 
	if [ "$NVIM_INSTALL" != " " ]; then
		apply_dotfile "$NVIM_CONFIG" "$NVIM_PATH"
	fi
	## ZSH Theme
	if [ "$BASHRC_INSTALL" != " " ]; then
		apply_dotfile "$BASHRC_CONFIG" "$BASHRC_PATH"
	fi
	## ZSH Theme
	if [ "$BASH_ALIASES_INSTALL" != " " ]; then
		apply_dotfile "$BASH_ALIASES_CONFIG" "$BASH_ALIASES_PATH"
	fi
	## Concat notes files
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


## Variables to controll script
CREATE_SYMLINK=1

## load config file
. ./variables.sh

logLine=$(cat << EOF
Enter:
- install to apply changes
- quit to exit without making changes
- help to display the help message
 
EOF
)


# save terminal state
# tput smcup

### Main entrypoint
while true; do
	#clear
	printf "%s\n\n" "$banner"
	## Menu
	printf "Select components to install.\n"
	printf " 1) [%s] zshrc file\n    path: %s\n" "$ZSH_INSTALL" "$ZSH_PATH"
	printf " 2) [%s] zsh custom theme\n    path: %s\n" "$ZSH_THEME_INSTALL" "$ZSH_THEME_PATH"
	printf " 3) [%s] Neovim, using vim-plug\n    path: %s\n" "$NVIM_INSTALL" "$NVIM_PATH"
	printf " 4) [%s] bashrc\n    path: %s\n" "$BASHRC_INSTALL" "$BASHRC_PATH"
	printf " 5) [%s] bash aliases\n    path: %s\n" "$BASH_ALIASES_INSTALL" "$BASH_ALIASES_PATH"

	printf " 6) [%s] notes (all)\n    path: %s\n" "$NOTES_ALL_INSTALL" "$NOTES_PATH"
	printf "  a) [%s] golang    b) [%s] git    c) [%s] process and ports\n" "$NOTES_GOLANG" "$NOTES_GIT" "$NOTES_PROCESS_PORT"
	printf "%s\n" "$logLine"
	#echo $logLine
	logLine=" "

	printf "> "
	read choice
	## operate on choice
	case $choice in
		1) ZSH_INSTALL=$([ "$ZSH_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 1")
			printf "s\n zsh path> "
			read ZSH_PATH
			;;

		2) ZSH_THEME_INSTALL=$([ "$ZSH_THEME_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 2")
			printf "\n zsh theme path> "
			read ZSH_THEME_PATH
			;;
		
		3) NVIM_INSTALL=$([ "$NVIM_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 3")
			printf "\n neovim path> "
			read NVIM_PATH
			;;

		4) BASHRC_INSTALL=$([ "$BASHRC_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 4")
			printf "\n bashrc path> "
			read BASHRC_PATH
			;;

		5) BASH_ALIASES_INSTALL=$([ "$BASH_ALIASES_INSTALL" = "*" ] && echo " " || echo "*")
			;;
		"path 5")
			printf "\n bash aliases path> "
			read BASH_ALIASES_PATH
			;;

		6) if [ "$NOTES_ALL_INSTALL" = " " ]; then
				NOTES_ALL_INSTALL="*"
				NOTES_GOLANG="*"
				NOTES_GIT="*"
				NOTES_PROCESS_PORT="*"
			else
				NOTES_ALL_INSTALL=" "
				NOTES_GOLANG=" "
				NOTES_GIT=" "
				NOTES_PROCESS_PORT=" "
			fi
			;;
		"path 6")
			printf "\n notes path> "
			read NOTES_PATH
			;;
		"6a") NOTES_GOLANG=$([ "$NOTES_GOLANG" = "*" ] && echo " " || echo "*")
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT_CONFIG" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT_CONFIG" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"6b") NOTES_GIT=$([ "$NOTES_GIT" = "*" ] && echo " " || echo "*")
			NOTES_ALL_INSTALL="-"
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ]; then
				NOTES_ALL_INSTALL=" "
			else
				NOTES_ALL_INSTALL="-"
			fi
			;;
		"6c") NOTES_PROCESS_PORT=$([ "$NOTES_PROCESS_PORT" = "*" ] && echo " " || echo "*")
			NOTES_ALL_INSTALL="-"
			if [ "$NOTES_GOLANG" = "*" ] && [ "$NOTES_GIT" = "*" ] && [ "$NOTES_PROCESS_PORT" = "*" ]; then
				NOTES_ALL_INSTALL="*"
			elif [ "$NOTES_GOLANG" = " " ] && [ "$NOTES_GIT" = " " ] && [ "$NOTES_PROCESS_PORT" = " " ]; then
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
		"quit"|"q") break ;;
		7) break ;;
		*) logLine="\033[0;31mInvalid option selected\033[0m"
			;;
	esac
done

# restore terminal
# tput rmcup
