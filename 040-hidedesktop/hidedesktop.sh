#!/bin/bash
#######################################
# Hides the contents of a Desktop of an OS X system.
#
# Parametres:
# -s | --show to show the desktop
# -h | --hide to hide the desktop
#######################################
show=false
while [ "$1" != "" ]; do
	case $1 in
	        -h | --hide )
					 			shift
								show=false
								;;
	        -s | --show )    
								shift
								show=true
								;;
	        * )                    
								show=false
	esac  
	shift
done

defaults write com.apple.finder CreateDesktop $show; killall Finder