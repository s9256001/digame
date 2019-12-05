#!/bin/bash
source server_operation
source menu
source ../Deploy/secret

commands=(1 2 3 4 5 6)
descriptions=(\
	'clone'\
	'pull'\
	'build'\
	'commit'\
	'deploy demo'\
	'deploy dev'\
	)
funcs=(\
	'server_clone $gitlabURL'\
	'server_pull'\
	'server_build'\
	'server_commit'\
	'server_deploy_with_password $demoPassword linux_demo $demoUser@$demoURL:~'\
	'server_deploy_with_key ../Deploy/$dev1Pem linux_dev $dev1User@$dev1URL:~'\
	)

menu_loop "server operation" commands descriptions funcs
