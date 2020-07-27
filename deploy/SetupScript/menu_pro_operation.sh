#!/bin/bash
source script_lib
source menu
source ../Deploy/secret

function server_copy()
{
    echo 'server copy...'
	
	pushd $PWD > /dev/null
	cd ../Server
	
	srcDir=env/server/linux_pro
	dstDir=pro/server_go
	serverName=dataserver
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	serverName=gameserver
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	serverName=betquery
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	
	srcDir=env/wallet/linux_pro
	dstDir=pro/wallet
	serverName=wallet
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	serverName=gamelobby
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	
	popd > /dev/null
}
function server_stop()
{
    echo 'server stop...'
	
	echo 'gamelobby:'
	serverName=gamelobby
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "pm2 stop $serverName"
	echo 'wallet:'
	serverName=wallet
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "pm2 stop $serverName"
	
	echo 'betquery:'
	serverName=betquery
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "pm2 stop $serverName"
	echo 'gameserver 1:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "pm2 stop $serverName"
	echo 'gameserver 2:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "pm2 stop $serverName"
	echo 'dataserver:'
	serverName=dataserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "pm2 stop $serverName"
}
function server_deploy()
{
    echo 'server deploy...'
	
	pushd $PWD > /dev/null
	cd ../Server
	
	srcDir=pro/server_go
	dstDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	scp -i ../Deploy/$proPem -r $srcDir/$serverName $proUser@$proURL_dataserver:~/$dstDir
	echo 'gameserver 1:'
	serverName=gameserver
	scp -i ../Deploy/$proPem -r $srcDir/$serverName $proUser@$proURL_gameserver1:~/$dstDir
	echo 'gameserver 2:'
	serverName=gameserver
	scp -i ../Deploy/$proPem -r $srcDir/$serverName $proUser@$proURL_gameserver2:~/$dstDir
	echo 'betquery:'
	serverName=betquery
	scp -i ../Deploy/$proPem -r $srcDir/$serverName $proUser@$proURL_betquery:~/$dstDir
	
	srcDir=pro/wallet
	dstDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	scp -i ../Deploy/$proPem -r $srcDir/$serverName $proUser@$proURL_wallet:~/$dstDir
	echo 'gamelobby:'
	serverName=gamelobby
	scp -i ../Deploy/$proPem -r $srcDir/$serverName $proUser@$proURL_wallet:~/$dstDir
	
	popd > /dev/null
}
function server_down()
{
    echo 'server start...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "pm2 delete $serverName"
	echo 'gameserver 1:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "pm2 delete $serverName"
	echo 'gameserver 2:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "pm2 delete $serverName"
	echo 'betquery:'
	serverName=betquery
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "pm2 delete $serverName"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "pm2 delete $serverName"
	echo 'gamelobby:'
	serverName=gamelobby
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "pm2 delete $serverName"
}
function server_start()
{
    echo 'server start...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'gameserver 1:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'gameserver 2:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'betquery:'
	serverName=betquery
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'gamelobby:'
	serverName=gamelobby
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
}
function server_status()
{
	echo 'server status...'
	
	echo 'dataserver:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "pm2 list"
	echo 'gameserver 1:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "pm2 list"
	echo 'gameserver 2:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "pm2 list"
	echo 'betquery:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "pm2 list"
	
	echo 'wallet:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "pm2 list"
}
function server_version()
{
	echo 'server status...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gameserver 1:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gameserver 2:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'betquery:'
	serverName=betquery
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gamelobby:'
	serverName=gamelobby
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
}
function server_error()
{
	echo 'server status...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gameserver 1:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gameserver 2:'
	serverName=gameserver
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'betquery:'
	serverName=betquery
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gamelobby:'
	serverName=gamelobby
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
}
function check_time()
{
	echo 'check time...'
	
	diflimit=10
	
	serverName=dataserver
	timedif=$(abs $(($(date +%s) - $(ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "date +%s"))))
	if [ $timedif -lt $diflimit ]
	then
	  echo "$serverName synced! "$timedif"s"
	else
	  printc C_RED "$serverName not synced! "$timedif"s\n"
	fi
	serverName=gameserver1
	timedif=$(abs $(($(date +%s) - $(ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "date +%s"))))
	if [ $timedif -lt $diflimit ]
	then
	  echo "$serverName synced! "$timedif"s"
	else
	  printc C_RED "$serverName not synced! "$timedif"s\n"
	fi
	serverName=gameserver2
	timedif=$(abs $(($(date +%s) - $(ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "date +%s"))))
	if [ $timedif -lt $diflimit ]
	then
	  echo "$serverName synced! "$timedif"s"
	else
	  printc C_RED "$serverName not synced! "$timedif"s\n"
	fi
	serverName=betquery
	timedif=$(abs $(($(date +%s) - $(ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "date +%s"))))
	if [ $timedif -lt $diflimit ]
	then
	  echo "$serverName synced! "$timedif"s"
	else
	  printc C_RED "$serverName not synced! "$timedif"s\n"
	fi
	
	serverName=wallet
	timedif=$(abs $(($(date +%s) - $(ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "date +%s"))))
	if [ $timedif -lt $diflimit ]
	then
	  echo "$serverName synced! "$timedif"s"
	else
	  printc C_RED "$serverName not synced! "$timedif"s\n"
	fi
}

commands=(1 2 3 4 5 6 7 8 9)
descriptions=(\
	'copy'\
	'stop'\
	'deploy'\
	'down'\
	'start'\
	'status'\
	'version'\
	'error'\
	'check time'\
	)
funcs=(\
	'server_copy'\
	'server_stop'\
	'server_deploy'\
	'server_down'\
	'server_start'\
	'server_status'\
	'server_version'\
	'server_error'\
	'check_time'\
	)

menu_loop "pro operation" commands descriptions funcs
