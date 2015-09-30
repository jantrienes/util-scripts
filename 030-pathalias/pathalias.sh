#!/bin/bash
#######################################
# Version 0.1
# A script for creating aliases to switch in a directory
#
# This script needs one modification in your '/etc/bashrc' file. 
# Please add the following Statement to your bashrc
#	if [ -f ~/.bash_aliases ]; then
#   	 . ~/.bash_aliases
# 	fi
#
# For adding an alias, the script used the current path as target path
#
# Parametres:
# -add aliasName # added 'alias aliasName='cd currentPath' to '~/.bash_aliases'
# aliasName # added 'alias aliasName='cd currentPath' to '~/.bash_aliases'
# -rm aliasName # deleted all entries in the in '~/.bash_aliases'
# -p # printed all aliases
#######################################
addAlias()
{
    name=$1
	cmd="alias $name='cd $path'"
	result=( $(alias | grep "alias $name" | wc -l) )
	if [ $result = 0 ];
	then
			echo "$cmd" >> $bash_aliases
		else
			echo "there is already an alias with the name $name"
	fi;
}
path=$PWD
cmd=""
bash_aliases="${HOME}/.bash_aliases"
bash_tmp="${HOME}/.bash_tmp"
name=""
while [ "$1" != "" ]; do
	case $1 in
	        -add )
					 			shift
								addAlias $1
	                            ;;
	        -rm | --remove )    
								shift
								name=$1
								result=( $(alias | grep "alias $name" | wc -l) )
								if [ $result != 0 ];
								then
									sed '/alias '$name'/d' $bash_aliases > $bash_tmp
									mv $bash_tmp $bash_aliases
									echo "Please restart your commandline"								
								fi;
				 				;;
	        -p | --print )      
					 			alias
                                ;;
	        * )                    
								addAlias $1
	esac
    
	shift
done


sort $bash_aliases -o $bash_aliases
source /etc/bashrc
