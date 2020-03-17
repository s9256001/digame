#!/bin/bash
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
	
	popd > /dev/null
}
function server_stop()
{
    echo 'server stop...'
	
	echo 'wallet:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet 'pm2 stop wallet'
	
	echo 'betquery:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery 'pm2 stop betquery'
	echo 'gameserver 1:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 'pm2 stop gameserver'
	echo 'gameserver 2:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 'pm2 stop gameserver'
	echo 'dataserver:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver 'pm2 stop dataserver'
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
}
function server_status()
{
	echo 'server status...'
	
	echo 'dataserver:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_dataserver "pm2 list dataserver"
	echo 'gameserver 1:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver1 "pm2 list gameserver"
	echo 'gameserver 2:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_gameserver2 "pm2 list gameserver"
	echo 'betquery:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_betquery "pm2 list betquery"
	
	echo 'wallet:'
	ssh -i ../Deploy/$proPem $proUser@$proURL_wallet "pm2 list wallet"
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
}

commands=(1 2 3 4 5 6 7)
descriptions=(\
	'copy'\
	'stop'\
	'deploy'\
	'down'\
	'start'\
	'status'\
	'version'\
	)
funcs=(\
	'server_copy'\
	'server_stop'\
	'server_deploy'\
	'server_down'\
	'server_start'\
	'server_status'\
	'server_version'\
	)

menu_loop "pro operation" commands descriptions funcs
