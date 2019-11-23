#!/bin/bash
source install_tool
source menu
source ../Deploy/secret

goVersion=go1.12.9

commands=(1 2)
descriptions=(\
	'git'\
	'golang'\
	)
funcs=(\
	'install_git $gitlabEmail $gitlabUser'\
	'install_golang $goVersion'\
	)

menu_loop "install tool" commands descriptions funcs
