#!/bin/bash
source menu
source ../Deploy/secret

port_kg=2375

function server_copy()
{
    echo 'server copy...'
	
	pushd $PWD > /dev/null
	cd ../Server
	
	srcDir=env/server/linux_pro_kg
	dstDir=pro_kg/server_go
	serverName=dataserver
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	serverName=gameserver
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	serverName=betquery
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	
	srcDir=env/wallet/linux_pro_kg
	dstDir=pro_kg/wallet
	serverName=wallet
	cp -r $srcDir/$serverName $dstDir/$serverName/
	cp $srcDir/* $dstDir/$serverName 2>/dev/null
	
	popd > /dev/null
}
function server_stop()
{
    echo 'server stop...'
	
	echo 'wallet:'
	serverName=wallet
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_wallet -p$port_kg "pm2 stop $serverName"
	
	echo 'betquery:'
	serverName=betquery
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_betquery -p$port_kg "pm2 stop $serverName"
	echo 'gameserver 1:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver1 -p$port_kg "pm2 stop $serverName"
	echo 'gameserver 2:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver2 -p$port_kg "pm2 stop $serverName"
	echo 'dataserver:'
	serverName=dataserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_dataserver -p$port_kg "pm2 stop $serverName"
}
function server_deploy()
{
    echo 'server deploy...'
	
	pushd $PWD > /dev/null
	cd ../Server
	
	srcDir=pro_kg/server_go
	dstDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	sshpass -p $proPassword_KG scp -P$port_kg -r $srcDir/$serverName $proUser_KG@$proURL_KG_dataserver:~/$dstDir
	echo 'gameserver 1:'
	serverName=gameserver
	sshpass -p $proPassword_KG scp -P$port_kg -r -r $srcDir/$serverName $proUser_KG@$proURL_KG_gameserver1:~/$dstDir
	echo 'gameserver 2:'
	serverName=gameserver
	sshpass -p $proPassword_KG scp -P$port_kg -r -r $srcDir/$serverName $proUser_KG@$proURL_KG_gameserver2:~/$dstDir
	echo 'betquery:'
	serverName=betquery
	sshpass -p $proPassword_KG scp -P$port_kg -r -r $srcDir/$serverName $proUser_KG@$proURL_KG_betquery:~/$dstDir
	
	srcDir=pro_kg/wallet
	dstDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	sshpass -p $proPassword_KG scp -P$port_kg -r -r $srcDir/$serverName $proUser_KG@$proURL_KG_wallet:~/$dstDir
	
	popd > /dev/null
}
function server_down()
{
    echo 'server start...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_dataserver -p$port_kg "pm2 delete $serverName"
	echo 'gameserver 1:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver1 -p$port_kg "pm2 delete $serverName"
	echo 'gameserver 2:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver2 -p$port_kg "pm2 delete $serverName"
	echo 'betquery:'
	serverName=betquery
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_betquery -p$port_kg "pm2 delete $serverName"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_wallet -p$port_kg "pm2 delete $serverName"
}
function server_start()
{
    echo 'server start...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_dataserver -p$port_kg "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'gameserver 1:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver1 -p$port_kg "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'gameserver 2:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver2 -p$port_kg "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	echo 'betquery:'
	serverName=betquery
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_betquery -p$port_kg "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_wallet -p$port_kg "cd $envDir/$serverName/$serverName ; pm2 start --name $serverName server.out"
}
function server_status()
{
	echo 'server status...'
	
	echo 'dataserver:'
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_dataserver -p$port_kg "pm2 list"
	echo 'gameserver 1:'
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver1 -p$port_kg "pm2 list"
	echo 'gameserver 2:'
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver2 -p$port_kg "pm2 list"
	echo 'betquery:'
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_betquery -p$port_kg "pm2 list"
	
	echo 'wallet:'
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_wallet -p$port_kg "pm2 list"
}
function server_version()
{
	echo 'server status...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_dataserver -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gameserver 1:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver1 -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gameserver 2:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver2 -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'betquery:'
	serverName=betquery
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_betquery -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_wallet -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep ServerVersion server.log | tail -1"
}
function server_error()
{
	echo 'server status...'
	
	envDir=server/server_go
	echo 'dataserver:'
	serverName=dataserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_dataserver -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gameserver 1:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver1 -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gameserver 2:'
	serverName=gameserver
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_gameserver2 -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'betquery:'
	serverName=betquery
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_betquery -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	
	envDir=server/wallet
	echo 'wallet:'
	serverName=wallet
	sshpass -p $proPassword_KG ssh $proUser_KG@$proURL_KG_wallet -p$port_kg "cd $envDir/$serverName/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
}

commands=(1 2 3 4 5 6 7 8)
descriptions=(\
	'copy'\
	'stop'\
	'deploy'\
	'down'\
	'start'\
	'status'\
	'version'\
	'error'\
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
	)

menu_loop "pro kg operation" commands descriptions funcs
