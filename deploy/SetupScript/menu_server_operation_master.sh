#!/bin/bash
source server_operation
source menu
source ../Deploy/secret

commands=(1 2 3 4 5)
descriptions=(\
	'pull'\
	'build'\
	'commit'\
	'deploy demo'\
	'deploy dev'\
	)
funcs=(\
	'server_pull master'\
	'server_build master'\
	'server_commit master'\
	'server_deploy_with_password $demoPassword linux_demo $demoUser@$demoURL $demoPort'\
	'server_deploy_with_key ../Deploy/$dev1Pem linux_dev $dev1User@$dev1URL'\
	)

menu_loop "server operation (master)" commands descriptions funcs
