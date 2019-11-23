#!/bin/bash
source server_operation
source menu
source ../Deploy/secret

commands=(1 2 3 4 5)
descriptions=(\
	'clone'\
	'pull'\
	'build'\
	'commit'\
	'deploy'\
	)
funcs=(\
	'server_clone $gitlabURL'\
	'server_pull'\
	'server_build'\
	'server_commit'\
	'server_deploy ../Deploy/$dev1Pem $dev1User@$dev1URL:/home/$dev1User'\
	)

menu_loop "server operation" commands descriptions funcs
