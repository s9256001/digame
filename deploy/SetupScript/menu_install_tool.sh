#!/bin/bash
source install_tool
source menu
source ../Deploy/secret

goVersion=go1.12.9
dockerComposeVersion=1.24.0

commands=(1 2 3 4)
descriptions=(\
	'git'\
	'golang'\
	'sshpass'\
	'docker-compose'\
	)
funcs=(\
	'install_git $gitlabEmail $gitlabUser'\
	'install_golang $goVersion'\
	'install_sshpass'\
	'install_docker_compose $dockerComposeVersion'\
	)

menu_loop "install tool" commands descriptions funcs
