#!/bin/sh

exit_script() {
    code=0
    if [ -n "$1" ]; then
        code=$1
    fi
    exit $code
}

apply_dotfile(){
    # $1 -> source file
    # $2 -> destination file
    mkdir -p $(dirname $2)
    ## check for file existence
    if [ -f "$2" ]; then
        ## backup file
        mv $2 $2.bak
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
	if [ "$ZSH_INSTALL" = "*" ]; then
		apply_dotfile "$PWD/configs/zsh/zshrc" "$ZSH_PATH"
	fi
	## ZSH Theme
	if [ "$ZSH_THEME_INSTALL" = "*" ]; then
		apply_dotfile "$PWD/configs/zsh/agnoster-wsl.zsh-theme" "$ZSH_THEME_PATH"
	fi
}

install_options(){
	# $1 -> text
	# $2 -> toogle flag
	# $2 -> install path
	toogle=$2
	path=$3
	## SubMenu
	while true; do
		## Menu
		printf "Component %s\nInstall?: " "$1" 1>&2
		if [ "$toogle" = " " ]; then
			printf "No\n" 1>&2
		else
			printf "Yes\n" 1>&2
		fi
		printf "Path: %s\n" "$path" 1>&2
		printf "\nSelect an action\n" 1>&2
		printf " 1) Toogle install\n" 1>&2
		printf " 2) Change path\n" 1>&2
		printf " 3) Done\n\n" 1>&2
		printf "> " 1>&2
		read subchoice
		## operate on choice
		case $subchoice in
			1) if [ "$toogle" = " " ]; then
					toogle="*"
				else
					toogle=" "
				fi
				;;
			2) printf "path> " 1>&2
				read path
				;;
			3) break ;;
			*) echo "invalid option" 1>&2 ;;
		esac
	done
	## return arguments
	echo "$path"
	if [ "$toogle" = " " ]; then
		return 0
	else
		return 1
	fi
}


## Variables to controll script
CREATE_SYMLINK=1

ZSH_INSTALL=" "
ZSH_PATH="$HOME/.zshrc"
ZSH_THEME_INSTALL=" "
ZSH_THEME_PATH="$HOME/.oh-my-zsh/custom/themes/agnoster-wsl.zsh-theme"

logLine=""
### Main entrypoint
while true; do
	## Menu
	printf "Select components to install\n"
	printf " 1) [%s] zshrc file\n" "$ZSH_INSTALL"
	printf " 2) [%s] zshrc custom themes\n" "$ZSH_THEME_INSTALL"
	printf " 3) Install configs\n 4) Exit\n"
	printf "%s\n" "$logLine"

	printf "> "
	read choice
	## operate on choice
	case $choice in
		1) echo ""
			ZSH_PATH=$(install_options 'zshrc' "$ZSH_INSTALL" "$ZSH_PATH")
			if [ $? -eq 0 ]; then
				ZSH_INSTALL=" "
			else
				ZSH_INSTALL="*"
			fi
			;;
		2) echo ""
			## install step
			ZSH_THEME_PATH=$(install_options 'zsh theme' "$ZSH_THEME_INSTALL" "$ZSH_THEME_PATH")
			if [ $? -eq 0 ]; then
				ZSH_THEME_INSTALL=" "
			else
				ZSH_THEME_INSTALL="*"
			fi
			;;
		3) install_configs
			break
			;;
		4) break ;;
		*) echo "invalid option"
			;;
	esac
done

printf "[%s]zsh: %s\n" "$ZSH_INSTALL" "$ZSH_PATH"
printf "[%s]theme: %s\n" "$ZSH_THEME_INSTALL" "$ZSH_THEME_PATH"
